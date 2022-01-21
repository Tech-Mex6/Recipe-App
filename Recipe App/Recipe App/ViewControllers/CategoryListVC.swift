//
//  CategoryListVC.swift
//  Recipe App
//
//  Created by meekam okeke on 1/11/22.
//

import UIKit

class CategoryListVC: UIViewController {

    var tableView  = UITableView()
    var categories: [Category] = []
    
    struct Cells {
        static let categoryCell = "CategoryCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        configureTableView()
        fetchData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.pin(to: view)
        tableView.rowHeight = 250
        tableView.register(CategoryCell.self, forCellReuseIdentifier: Cells.categoryCell)
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchData() {
        NetworkManager.shared.fetchMealCategories { [weak self] result in
            switch result {
            case.success(let categories):
                self?.categories = categories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                self?.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension CategoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.categoryCell) as! CategoryCell
        cell.setCellData(category: categories[indexPath.row])
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let vc = MealListVC(category: category.strCategory)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

