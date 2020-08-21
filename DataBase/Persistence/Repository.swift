//
//  Repository.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation
import CoreData

protocol Repository {
    associatedtype EntityObject: Entity
    
    func getAll(where predicate: NSPredicate?) throws -> [EntityObject]
    func insert(item: EntityObject) throws
    func update(item: EntityObject) throws
    func delete(item: EntityObject) throws
}

extension Repository {
    func getAll() throws -> [EntityObject] {
        return try getAll(where: nil)
    }
}

public protocol Entity {
    associatedtype StoreType: Storable
    
    func toStorable(in context: NSManagedObjectContext) -> StoreType
}

public protocol Storable {
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    var nameId: String { get }
}
