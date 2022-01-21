//
//  CategoryCell.swift
//  Recipe App
//
//  Created by meekam okeke on 1/11/22.
//

import UIKit

class CategoryCell: UITableViewCell {
    var category: Category?
    var categoryImageView  = UIImageView()
    var categoryTitleLabel = RASecondaryTitleLabel(fontSize: 20)
    var categoryBodyLabel  = RABodyLabel(textAlignment: .natural)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        addSubview(categoryImageView)
        addSubview(categoryTitleLabel)
        addSubview(categoryBodyLabel)
        
        configureImageView()
        setImageConstraints()
        setTitleLabelConstraints()
        setBodyLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellData(category: Category) {
        self.category = category
        downloadCategoryImage()
        categoryTitleLabel.text = category.strCategory
        categoryBodyLabel.text  = category.strCategoryDescription
    }
    
    func downloadCategoryImage() {
        guard let imageUrl = category?.strCategoryThumb else { return }
        NetworkManager.shared.downloadImage(from: imageUrl ) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.categoryImageView.image = image
            }
        }
    }
    
    func configureImageView() {
        categoryImageView.layer.cornerRadius = 10
        categoryImageView.clipsToBounds      = true
    }
    
    func setImageConstraints() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints                                  = false
        categoryImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                  = true
        categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive     = true
        categoryImageView.heightAnchor.constraint(equalToConstant: 80).isActive                      = true
        categoryImageView.widthAnchor.constraint(equalTo: categoryImageView.heightAnchor, multiplier:16/9).isActive      = true
    }
    
    func setTitleLabelConstraints() {
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints                                  = false
        categoryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive             = true
        categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 10).isActive = true
        categoryTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive                      = true
        categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    func setBodyLabelConstraints() {
        categoryBodyLabel.translatesAutoresizingMaskIntoConstraints                                  = false
        categoryBodyLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 5).isActive = true
        categoryBodyLabel.leadingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor).isActive = true
        categoryBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive      = true
        categoryBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }

}
