//
//  SevenDayWeatherTableViewController.swift
//  OpenWeatherApp
//
//  Created by Natali on 17.08.2020.
//

import UIKit

class SevenDayWeatherTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    let tableCell = "tableCell"
    
    // MARK: - Public Properties
    
    let CDWeatherModel = WeatherViewModel(with: CoreDataRepository(persistentContainer:
        CoreDataService.shared.persistentContainer))
    var weatherArray: [WeatherModel]?
    var city: String?
    
    // MARK: - SevenDayWeatherTableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpCell()
        if weatherArray == nil {
            getWeatherFromDB(city: city ?? "")
        } else {
            saveWeatherToDB()
        }
    }
    
    // MARK: - Public methods
    
    /// Метод для регистрации ячейки
    func setUpCell() {
        self.tableView.register(UINib(nibName: "SevenDayTableViewCell", bundle: nil), forCellReuseIdentifier: tableCell)
    }
    
    ///  Сохранение погоды в БД
    func saveWeatherToDB() {
        guard weatherArray != nil, let array = weatherArray else { return }
        CDWeatherModel.saveRepository(weatherArray: array)
    }
    
    func getWeatherFromDB(city: String) {
        weatherArray = CDWeatherModel.getWeather(city: city)
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SevenDayWeatherTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = weatherArray else {
            return 0
        }
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! SevenDayTableViewCell
        
        guard let array = weatherArray else { return cell }
        let weather = array[indexPath.row]
        cell.temperatureLabel.text = "\(weather.temperature)" + "℃"
        cell.pressureLabel.text = "\(weather.pressure)" + "мм ртс"
        if let icon = weather.icon {
            cell.imageView?.image = UIImage(data: icon)
        }
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SevenDayWeatherTableViewController {
    
    /// Переход из выбранной ячейки к детальному экрану погоды
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailWeatherVC = DetailWeatherViewController()
        detailWeatherVC.weather = weatherArray?[indexPath.row]
        self.navigationController?.pushViewController(detailWeatherVC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Анимированная перезагрузка ячеек таблицы
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        }
        )
    }
    
    /// Установка нужной высоты ячеек
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 8
    }
}
