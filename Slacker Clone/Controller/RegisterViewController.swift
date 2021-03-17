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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate     = self
        emailTextField.delegate        = self
        nameTextField.delegate         = self
        imagePicker                    = UIImagePickerController()
        imagePicker.delegate           = self
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard passwordTextField.hasText,
              emailTextField.hasText else { return }
        
        
        NetworkManager.instance.registerUser(email: emailTextField.text!, password: passwordTextField.text!) { (completion) in
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
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
