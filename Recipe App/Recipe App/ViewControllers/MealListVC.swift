//
//  MealListVC.swift
//  Recipe App
//
//  Created by meekam okeke on 1/13/22.
//

import UIKit

class MealListVC: UIViewController {
    var tableView = UITableView()
    var meals: [Meal] = []
    var category: String = ""
    var mealRecipe: MealRecipe!

    
    struct Cells {
        static let mealCell = "MealCell"
    }
    
    init(category: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
        title         = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchMealData()
    }
    
    func configureTableView() {
        setTableViewDelegate()
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.rowHeight = 100
        tableView.register(MealCell.self, forCellReuseIdentifier: Cells.mealCell )
    }
    
    func setTableViewDelegate() {
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    func fetchMealData() {
        NetworkManager.shared.fetchListOfMeals(for: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let meals):
                self.meals = meals.meals
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case.failure(.invalidData):
                print("Invalid data")
            case .failure(.invalidResponse):
                print("Invalid response")
            case .failure(.unableToComplete):
                print("Unable to complete")
            }
        }
    }

}

extension MealListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mealCell) as! MealCell
        cell.setCellData(meal: meals[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = meals[indexPath.row]
        let vc = RecipeVC(ID: meal.idMeal)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
