//
//  RegisterViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/15/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var selectImageButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    
    let defaults = UserDefaults.standard
    var userCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        emailTextField.delegate = self
        nameTextField.delegate = self
    
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard passwordTextField.hasText, emailTextField.hasText else { return }
        let user = User(userName: nil, email: emailTextField.text!, password: passwordTextField.text!, avatar: nil)
        userCount += 1
        defaults.setValue(user, forKey: "\(userCount)")
        
        
    }
    
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.hasText {
            return true
        } else {
            return false
        }
    }
}
