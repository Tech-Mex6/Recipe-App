//
//  MealCell.swift
//  Recipe App
//
//  Created by meekam okeke on 1/13/22.
//

import UIKit

class MealCell: UITableViewCell {
    var meal: Meal!
    var mealImageView      = UIImageView()
    var mealTitleLabel     = RASecondaryTitleLabel(fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        addSubview(mealImageView)
        addSubview(mealTitleLabel)
        configureImageView()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellData(meal: Meal) {
        self.meal = meal
        downloadMealImage()
        mealTitleLabel.text = meal.strMeal
    }
    
    func downloadMealImage() {
        guard let imageUrl = meal?.strMealThumb else { return }
        NetworkManager.shared.downloadImage(from: imageUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mealImageView.image = image
            }
        }
    }
    
    func configureImageView() {
        mealImageView.layer.cornerRadius = 10
        mealImageView.clipsToBounds      = true
    }
    
    func setImageConstraints() {
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mealImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        mealImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        mealImageView.widthAnchor.constraint(equalTo: mealImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleLabelConstraints() {
        mealTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mealTitleLabel.centerYAnchor.constraint(equalTo: mealImageView.centerYAnchor).isActive = true
        mealTitleLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 10).isActive = true
        mealTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        mealTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }
}
