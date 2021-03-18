//
//  LogInViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/12/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        NetworkManager.instance.loginUser(email: userNameTextField.text!, password: passwordTextField.text!) { (success) in
            if success {
                self.performSegue(withIdentifier: "afterLogInSegue", sender: nil)
                print(NetworkManager.instance.authToken)
                print(NetworkManager.instance.userEmail)
            }
        }
        
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    

}

extension LogInViewController: UITextFieldDelegate {
    
}
