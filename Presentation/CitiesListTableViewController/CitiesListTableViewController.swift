//
//  CitiesListTableViewController.swift
//  OpenWeatherApp
//
//  Created by Natali on 17.08.2020.
//

import UIKit

class CitiesListTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var citiesArray = ["Москва", "Самара"]
    var networkManager = NetworkManager()
    var forecastService = ForecastService()
    
    // MARK: - CitiesListTableViewController
        
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTapped))
    }
    
    func getWeather(city: String, completion: @escaping ([WeatherModel]) -> Void) {
        forecastService.fetcForecast(city: city) { weatherArray in
            completion(weatherArray)
        }
    }
    
    @objc func addTapped() {
        print("add tapped")
    }
}

// MARK: - UITableViewDataSource

extension CitiesListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !citiesArray.isEmpty else {
            return 0
        }
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let city = citiesArray[indexPath.row]
        cell.textLabel?.text = city

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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.getWeather(city: "") { weatherArray in
            self.navigationController?.pushViewController(sevenDayWeatherVC, animated: true)
        }
    }
}
