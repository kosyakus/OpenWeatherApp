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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpCell()
        //self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: - Public methods
    
    /// Метод для регистрации ячейки
    func setUpCell() {
        self.tableView.register(UINib(nibName: "SevenDayTableViewCell", bundle: nil), forCellReuseIdentifier: tableCell)
    }
}

// MARK: - UITableViewDataSource

extension SevenDayWeatherTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! SevenDayTableViewCell
        
        cell.temperatureLabel.text = "18" + "℃"
        cell.pressureLabel.text = "" + "мм ртс"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SevenDayWeatherTableViewController {
    
    /// Переход из выбранной ячейки к детальному экрану погоды
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        let filmDetailVC = FilmDetailViewController()
        //        filmDetailVC.movie = moviesArray[indexPath.row]
        //        self.navigationController?.pushViewController(filmDetailVC, animated: true)
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