//
//  RABodyLabel.swift
//  Recipe App
//
//  Created by meekam okeke on 1/11/22.
//

import UIKit

class RABodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        textColor                         = .secondaryLabel
        font                              = .preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        numberOfLines                     = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
