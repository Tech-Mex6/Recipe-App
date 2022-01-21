//
//  RecipeVC.swift
//  Recipe App
//
//  Created by meekam okeke on 1/13/22.
//

import UIKit

class RecipeVC: UIViewController {
    var ID: String = ""
    var foodRecipe: MealRecipe!
    var recipes: [MealRecipe] = []
    
    var vStackView               = UIStackView()
    var scrollView               = UIScrollView()
    var mealNameLabel            = RATitleLabel(textAlignment: .center, fontSize: 20)
    var instructionsTitleLabel   = RASecondaryTitleLabel(fontSize: 16)
    var instructionsBodyLabel    = RABodyLabel(textAlignment: .natural)
    var ingredientTitleLabel     = RASecondaryTitleLabel(fontSize: 16)
    var ingredientLabel1         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel2         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel3         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel4         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel5         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel6         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel7         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel8         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel9         = RABodyLabel(textAlignment: .natural)
    var ingredientLabel10        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel11        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel12        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel13        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel14        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel15        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel16        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel17        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel18        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel19        = RABodyLabel(textAlignment: .natural)
    var ingredientLabel20        = RABodyLabel(textAlignment: .natural)
    var recipeImageView          = UIImageView()
    
    init(ID: String) {
        super.init(nibName: nil, bundle: nil)
        self.ID = ID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureScrollView()
        configureVStackView()
        configureImageView()
        setImageViewConstraints()
        fetchRecipeData()
    }
    
    func configureImageView() {
        recipeImageView.layer.cornerRadius = 15
        recipeImageView.clipsToBounds = true
    }
    
    func configureVStackView() {
        vStackView.axis         = .vertical
        vStackView.alignment    = .center
        vStackView.distribution = .equalSpacing
        vStackView.spacing      = 5
        vStackView.addArrangedSubview(recipeImageView)
        vStackView.addArrangedSubview(mealNameLabel)
        vStackView.addArrangedSubview(instructionsTitleLabel)
        vStackView.addArrangedSubview(instructionsBodyLabel)
        vStackView.addArrangedSubview(ingredientTitleLabel)
        vStackView.addArrangedSubview(ingredientLabel1)
        vStackView.addArrangedSubview(ingredientLabel2)
        vStackView.addArrangedSubview(ingredientLabel3)
        vStackView.addArrangedSubview(ingredientLabel4)
        vStackView.addArrangedSubview(ingredientLabel5)
        vStackView.addArrangedSubview(ingredientLabel6)
        vStackView.addArrangedSubview(ingredientLabel7)
        vStackView.addArrangedSubview(ingredientLabel8)
        vStackView.addArrangedSubview(ingredientLabel9)
        vStackView.addArrangedSubview(ingredientLabel10)
        vStackView.addArrangedSubview(ingredientLabel11)
        vStackView.addArrangedSubview(ingredientLabel12)
        vStackView.addArrangedSubview(ingredientLabel13)
        vStackView.addArrangedSubview(ingredientLabel14)
        vStackView.addArrangedSubview(ingredientLabel15)
        vStackView.addArrangedSubview(ingredientLabel16)
        vStackView.addArrangedSubview(ingredientLabel17)
        vStackView.addArrangedSubview(ingredientLabel18)
        vStackView.addArrangedSubview(ingredientLabel19)
        vStackView.addArrangedSubview(ingredientLabel20)
    }
    
    func configureScrollView() {
        scrollView.bouncesZoom = true
    }
    
    private func layoutUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(vStackView)
        view.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: margins.widthAnchor),
            
            vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setImageViewConstraints() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: vStackView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor, constant: 10),
            recipeImageView.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor, constant: -10),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    func fetchRecipeData() {
        NetworkManager.shared.fetchMealDetails(for: ID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let recipes):
                self.foodRecipe = recipes.meals.first
                self.downloadMealImage()
                DispatchQueue.main.async {
                    self.mealNameLabel.text = self.foodRecipe.strMeal
                    self.instructionsTitleLabel.text = "Instructions"
                    self.instructionsBodyLabel.text  = self.foodRecipe?.strInstructions
                    self.ingredientTitleLabel.text   = "Ingredients"
                    self.ingredientLabel1.text  = "\(self.foodRecipe?.strIngredient1 ?? "") \((self.foodRecipe?.strMeasure1 ?? ""))"
                    self.ingredientLabel2.text  = "\(self.foodRecipe?.strIngredient2 ?? "") \((self.foodRecipe?.strMeasure2 ?? ""))"
                    self.ingredientLabel3.text  = "\(self.foodRecipe?.strIngredient3 ?? "") \((self.foodRecipe?.strMeasure3 ?? ""))"
                    self.ingredientLabel4.text  = "\(self.foodRecipe?.strIngredient4 ?? "") \((self.foodRecipe?.strMeasure4 ?? ""))"
                    self.ingredientLabel5.text  = "\(self.foodRecipe?.strIngredient5 ?? "") \((self.foodRecipe?.strMeasure5 ?? ""))"
                    self.ingredientLabel6.text  = "\(self.foodRecipe?.strIngredient6 ?? "") \((self.foodRecipe?.strMeasure6 ?? ""))"
                    self.ingredientLabel7.text  = "\(self.foodRecipe?.strIngredient7 ?? "") \((self.foodRecipe?.strMeasure7 ?? ""))"
                    self.ingredientLabel8.text  = "\(self.foodRecipe?.strIngredient8 ?? "") \((self.foodRecipe?.strMeasure8 ?? ""))"
                    self.ingredientLabel9.text  = "\(self.foodRecipe?.strIngredient9 ?? "") \((self.foodRecipe?.strMeasure9 ?? ""))"
                    self.ingredientLabel10.text = "\(self.foodRecipe?.strIngredient10 ?? "") \((self.foodRecipe?.strMeasure10 ?? ""))"
                    self.ingredientLabel11.text = "\(self.foodRecipe?.strIngredient11 ?? "") \((self.foodRecipe?.strMeasure11 ?? ""))"
                    self.ingredientLabel12.text = "\(self.foodRecipe?.strIngredient12 ?? "") \((self.foodRecipe?.strMeasure12 ?? ""))"
                    self.ingredientLabel13.text = "\(self.foodRecipe?.strIngredient13 ?? "") \((self.foodRecipe?.strMeasure13 ?? ""))"
                    self.ingredientLabel14.text = "\(self.foodRecipe?.strIngredient14 ?? "") \((self.foodRecipe?.strMeasure14 ?? ""))"
                    self.ingredientLabel15.text = "\(self.foodRecipe?.strIngredient15 ?? "") \((self.foodRecipe?.strMeasure15 ?? ""))"
                    self.ingredientLabel16.text = "\(self.foodRecipe?.strIngredient16 ?? "") \((self.foodRecipe?.strMeasure16 ?? ""))"
                    self.ingredientLabel17.text = "\(self.foodRecipe?.strIngredient17 ?? "") \((self.foodRecipe?.strMeasure17 ?? ""))"
                    self.ingredientLabel18.text = "\(self.foodRecipe?.strIngredient18 ?? "") \((self.foodRecipe?.strMeasure18 ?? ""))"
                    self.ingredientLabel19.text = "\(self.foodRecipe?.strIngredient19 ?? "") \((self.foodRecipe?.strMeasure19 ?? ""))"
                    self.ingredientLabel20.text = "\(self.foodRecipe?.strIngredient20 ?? "") \((self.foodRecipe?.strMeasure20 ?? ""))"
                }
            case .failure(.invalidData):
                print("Invalid data")
            case .failure(.unableToComplete):
                print("Unable to complete")
            case .failure(.invalidResponse):
                print("Invalid response")
            }
        }
    }
    
    func downloadMealImage() {
        guard let imageUrl = foodRecipe?.strMealThumb else { return }
        NetworkManager.shared.downloadImage(from: imageUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.recipeImageView.image = image
            }
        }
    }
}
