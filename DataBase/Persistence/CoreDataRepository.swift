//
//  CoreDataRepository.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation
import CoreData

class CoreDataRepository<RepositoryObject>: Repository
        where RepositoryObject: Entity,
        RepositoryObject.StoreType: NSManagedObject,
        RepositoryObject.StoreType.EntityObject == RepositoryObject {

    var persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getAll(where predicate: NSPredicate?) throws -> [RepositoryObject] {
        let objects = try getManagedObjects(with: predicate)
        return objects.compactMap { $0.model }
    }

    func insert(item: RepositoryObject) throws {
        persistentContainer.viewContext.insert(item.toStorable(in: persistentContainer.viewContext))
        saveContext()
    }
    
    func update(item: RepositoryObject) throws {
        try delete(item: item)
        try insert(item: item)
    }
    
    func delete(item: RepositoryObject) throws {
        let predicate = NSPredicate(format: "date == %@", item.toStorable(in: persistentContainer.viewContext).weatherDate)
        let items = try getManagedObjects(with: predicate)

        persistentContainer.viewContext.delete(items.first!)
        saveContext()
    }
    
    public func deleteAll() throws {
        // Create Fetch Request
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let context = persistentContainer.viewContext
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(batchDeleteRequest)
    }
    
    private func getManagedObjects(with predicate: NSPredicate?) throws -> [RepositoryObject.StoreType] {
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<RepositoryObject.StoreType>(entityName: entityName)
        request.predicate = predicate
        
        return try persistentContainer.viewContext.fetch(request)
    }
    
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
