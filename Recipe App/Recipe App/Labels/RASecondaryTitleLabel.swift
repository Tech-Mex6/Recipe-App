//
//  RASecondaryTitleLabel.swift
//  Recipe App
//
//  Created by meekam okeke on 1/11/22.
//

import UIKit

class RASecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        textColor                                 = .secondaryLabel
        adjustsFontSizeToFitWidth                 = true
        adjustsFontForContentSizeCategory         = true
        minimumScaleFactor                        = 0.75
        numberOfLines                             = 0
        lineBreakMode                             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
