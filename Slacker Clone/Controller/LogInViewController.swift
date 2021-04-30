//
//  LogInViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/12/21.
//

import UIKit

class LogInViewController: UIViewController {
    
 
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var textFieldBackgroundView: UIView!
    
    
    let icon1 = UIImage(systemName: "person.crop.circle.badge.questionmark")
    let icon2 = UIImage(systemName: "person.crop.circle.badge.checkmark")
    let icon3 = UIImage(systemName: "person.crop.circle.badge.person.crop.circle.badge.xmark")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate    = self
        passwordTextField.delegate = self
        logInButton.layer.cornerRadius = 10
        textFieldBackgroundView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.layer.shadowRadius = 3
        emailTextField.layer.shadowRadius = 3
        emailTextField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        passwordTextField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailTextField.layer.shadowOpacity = 0.5
        passwordTextField.layer.shadowOpacity = 0.5

        textFieldBackgroundView.layer.shadowOpacity = 0.50
        textFieldBackgroundView.layer.shadowRadius = 5
        textFieldBackgroundView.layer.cornerRadius = 10
        logInButton.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        logInButton.layer.shadowOpacity = 0.70
        logInButton.layer.shadowRadius = 5
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        guard emailTextField.hasText, passwordTextField.hasText else { return }
        
        NetworkManager.instance.loginUser(email: emailTextField.text!, password: passwordTextField.text!) { (success) in
            
            if success {
                
                NetworkManager.instance.findUserByEmail(email: self.emailTextField.text!) { (success) in
                    
                    self.performSegue(withIdentifier: "logInSegue", sender: nil)
                    
                }
            }
        }
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    

}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            if !textField.text!.contains("@") || !textField.text!.contains(".com") {
                emailTextField.layer.borderColor = UIColor.red.cgColor
                emailTextField.layer.borderWidth = 2
                emailTextField.text = ""
                emailTextField.placeholder = "must be a vaild email"
                return false
            } else {
                return true
            }
        case passwordTextField:
            if let count = textField.text?.count {
                if count < 6 {
                    passwordTextField.layer.borderColor = UIColor.red.cgColor
                    passwordTextField.layer.borderWidth = 2
                    passwordTextField.text = ""
                    passwordTextField.placeholder = "password must be six digits or more"
                    return false
                }
            } else {
                return true
            }
            
        default:
            break
        }
        return true
    }
}
