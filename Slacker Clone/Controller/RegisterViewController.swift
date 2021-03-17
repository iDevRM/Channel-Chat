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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    
    let defaults = UserDefaults.standard
    var userCount = 0
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        emailTextField.delegate = self
        nameTextField.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        navigationController?.delegate = self
        
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard passwordTextField.hasText,
              emailTextField.hasText,
              nameTextField.hasText,
              imageView.image != nil else { return }
        
        let encodedImage = imageView.image?.pngData()
        
        let user = User(userName: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, avatar: encodedImage ?? nil )
        
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(user)

            UserDefaults.standard.set(data, forKey: user.userName)

        } catch {
            print("Unable to Encode User (\(error.localizedDescription))")
        }
        
        NetworkManager.instance.registerUser(email: user.email, password: user.password) { (completion) in
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
