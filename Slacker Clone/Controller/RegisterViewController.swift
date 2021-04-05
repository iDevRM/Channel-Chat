//
//  RegisterViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/15/21.
//

import UIKit

class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var nameTextField:     UITextField!
    @IBOutlet weak var imageView:         UIImageView!
    @IBOutlet weak var registerButton:    UIButton!

    var imagePicker: UIImagePickerController!
    let defaultPicture = "profileDefault"
    let defaultColor = "[0.5, 0.5, 0.5, 1]"
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate     = self
        emailTextField.delegate        = self
        nameTextField.delegate         = self
        imagePicker                    = UIImagePickerController()
        imagePicker.delegate           = self
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard passwordTextField.hasText, emailTextField.hasText else { return }
        
        
        NetworkManager.instance.registerUser(email: emailTextField.text!, password: passwordTextField.text!) { (success) in
            
            if success {
                NetworkManager.instance.loginUser(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (success) in
                    
                    if success {
                        NetworkManager.instance.createUser(name: self.nameTextField.text!, email: self.emailTextField.text!, avatarColor: "", avatarName: "") { (success) in
                            
                            if success {
                                let alert = UIAlertController(title: "You have successfully registered a new user", message: "You can now log in", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                    self.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "AvatarImageSegue", sender: nil)
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

extension RegisterViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
