//
//  CitiesListTableViewController.swift
//  OpenWeatherApp
//
//  Created by Natali on 17.08.2020.
//

import UIKit

class CitiesListTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var citiesArray: [String]?
    var networkManager = NetworkManager()
    var forecastService = ForecastService()
    
    // MARK: - CitiesListTableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserSettings.shareInstance.isFirstTime {
            citiesArray = ["Moscow"]
            UserSettings.shareInstance.isFirstTime = false
        } else {
            citiesArray = UserSettings.shareInstance.citiesArray
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTapped))
    }
    
    // MARK: - Public methods
    
    /// Загрузка погоды с сервера
    func getWeather(city: String, completion: @escaping ([WeatherModel]) -> Void) {
        forecastService.fetcForecast(city: city) { result in
            switch result {
            case .success(let weatherArray):
                completion(weatherArray)
            case .failure(let error):
                print(error)
                switch error {
                case .noConnection:
                    self.navigateToSevenDayVC(array: nil, city: city)
                default:
                    DispatchQueue.main.async {
                        self.showErrorAlert()
                        
                    }
                }
            }
        }
    }
    
    /// Обработка нажатия на "+"
    @objc func addTapped() {
        self.showAlertWithTextField() { newCity in
            /// Добавляем новый город в массив и новую строчку в таблицу
            self.citiesArray?.append(newCity)
            guard let array = self.citiesArray else { return }
            self.tableView.performBatchUpdates({
                self.tableView.insertRows(at: [IndexPath(row: array.count - 1, section: 0)], with: .automatic)
            }, completion: nil)
            UserSettings.shareInstance.citiesArray = array
        }
    }
    
    /// При нажатии на "+" выскакивает алерт с возможностью вписать нужный город
    func showAlertWithTextField(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Добавьте новый город", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                completion(text)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Тольятти"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Не удалось распознать город", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showNoConnectionAlert() {
        let alertController = UIAlertController(title: "Отсутствует подключение к интернету", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Переход на контроллер с 7-ми дневным прогнозом
    func navigateToSevenDayVC(array: [WeatherModel]?, city: String) {
        DispatchQueue.main.async {
            let sevenDayWeatherVC = SevenDayWeatherTableViewController()
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            if array != nil {
                sevenDayWeatherVC.weatherArray = array
            } else {
                sevenDayWeatherVC.city = city
            }
            self.navigationController?.pushViewController(sevenDayWeatherVC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension CitiesListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = citiesArray else {
            return 0
        }
        return array.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let array = citiesArray else {
            return cell
        }
        let city = array[indexPath.row]
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
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let text = cell?.textLabel?.text else { return }
        self.getWeather(city: text) { weatherArray in
            self.navigateToSevenDayVC(array: weatherArray, city: text)
        }
    }
    
    /// Удаление выбранной строчки
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            citiesArray?.remove(at: indexPath.row)
            UserSettings.shareInstance.citiesArray = citiesArray ?? []
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            // TO DO: Придумать,как удалять город из БД, если он написан на англ.
        }
    }
}
