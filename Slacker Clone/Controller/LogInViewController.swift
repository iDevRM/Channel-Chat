//
//  LogInViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/12/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let icon1 = UIImage(systemName: "person.crop.circle.badge.questionmark")
    let icon2 = UIImage(systemName: "person.crop.circle.badge.checkmark")
    let icon3 = UIImage(systemName: "person.crop.circle.badge.person.crop.circle.badge.xmark")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    
}
