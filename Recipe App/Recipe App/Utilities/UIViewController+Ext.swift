//
//  UIViewController+Ext.swift
//  Recipe App
//
//  Created by meekam okeke on 1/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = RAAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

