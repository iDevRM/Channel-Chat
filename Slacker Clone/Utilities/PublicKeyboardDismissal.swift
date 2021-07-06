//
//  PublicKeyboardDismissal.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 5/4/21.
//

import UIKit

class PublicKeyboardDimissal {
    
    static let instance = PublicKeyboardDimissal()
    
    func hideKeyboardFromOutsideTap(for view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(for view: UIView) {
        view.endEditing(true)
    }
    
}
