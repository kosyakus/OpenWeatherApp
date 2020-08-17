//
//  CitiesListTableViewController.swift
//  OpenWeatherApp
//
//  Created by Natali on 17.08.2020.
//

import UIKit

class CitiesListTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}

// MARK: - UITableViewDataSource

extension CitiesListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "Moscow"

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CitiesListTableViewController {
    
    /// Переход из выбранной ячейки к детальному экрану погоды
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sevenDayWeatherVC = SevenDayWeatherTableViewController()
        //filmDetailVC.movie = moviesArray[indexPath.row]
        self.navigationController?.pushViewController(sevenDayWeatherVC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
