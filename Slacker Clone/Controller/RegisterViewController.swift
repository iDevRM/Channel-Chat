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
    @IBOutlet weak var chooseColorButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    let colorPicker   = UIColorPickerViewController()
    var avatarPicture = UserDataService.instance.avatarName
    var avatarColor   = UserDataService.instance.avatarColor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayersForUI()
        setAllDelegates()
        hideKeyboardFromOutsideTap()
    }
    
    
    //MARK: - IBActions / API calls
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard passwordTextField.hasText, emailTextField.hasText else { return }
        
        
        NetworkManager.instance.registerUser(email: emailTextField.text!, password: passwordTextField.text!) { (success) in
            
            if success {
                NetworkManager.instance.loginUser(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (success) in
                    
                    if success {
                        NetworkManager.instance.createUser(name: self.nameTextField.text!, email: self.emailTextField.text!, avatarColor: self.avatarColor, avatarName: UserDataService.instance.avatarName) { (success) in
                            
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
        
        if let avatarVC = storyboard?.instantiateViewController(identifier: "avatarID") as? AvatarImageViewController {
            avatarVC.imageDelegate = self
            present(avatarVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func chooseColorTapped(_ sender: UIButton) {
        
        present(colorPicker, animated: true)
        
    }
    
}

//MARK: - Color Picker Protocols and Delegate Methods
extension RegisterViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        
        if let chosenColor = colorPicker.selectedColor.cgColor.components?.description {
            avatarColor = chosenColor
            chooseColorButton.backgroundColor = colorPicker.selectedColor
        }
    }
    
}

//MARK: - Text Field Protocols and Delegate Methods
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return validateText(for: textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return validateText(for: textField)
    }
    
}

//MARK: - Helper Functions
extension RegisterViewController {
    
    func setLayersForUI() {
        nameTextField.layer.cornerRadius     = 10
        emailTextField.layer.cornerRadius    = 10
        passwordTextField.layer.cornerRadius = 10
        chooseColorButton.layer.cornerRadius = 10
        backgroundView.layer.cornerRadius    = 10
        registerButton.layer.cornerRadius    = 10
        chooseColorButton.layer.cornerRadius = 10
        
        nameTextField.layer.shadowColor     = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailTextField.layer.shadowColor    = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        passwordTextField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        chooseColorButton.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        nameTextField.layer.shadowRadius     = 5
        emailTextField.layer.shadowRadius    = 5
        passwordTextField.layer.shadowRadius = 5
        chooseColorButton.layer.shadowRadius = 5
        
        nameTextField.layer.shadowOpacity     = 0.5
        emailTextField.layer.shadowOpacity    = 0.5
        passwordTextField.layer.shadowOpacity = 0.5
        chooseColorButton.layer.shadowOpacity = 0.5
        
        colorPicker.supportsAlpha = true
        colorPicker.selectedColor = UIColor.systemTeal
        imageView.image           = UIImage(systemName: "questionmark.square")
    }
    
    func setAllDelegates() {
        navigationController?.delegate = self
        passwordTextField.delegate     = self
        emailTextField.delegate        = self
        nameTextField.delegate         = self
        colorPicker.delegate           = self
    }
    
    func validateText(for textField: UITextField) -> Bool {
        switch textField {
            case emailTextField:
                if !textField.text!.contains("@") || !textField.text!.contains(".com") {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    textField.text              = ""
                    textField.placeholder       = "Must have valid email"
                    return false
                } else {
                    textField.layer.borderWidth = 0
                    textField.resignFirstResponder()
                    return true
                }
            case passwordTextField:
                if textField.text!.count < 6 {
                    textField.layer.borderWidth = 2
                    textField.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                    textField.text              = ""
                    textField.placeholder       = "Must have six characters"
                    return false
                } else {
                    textField.layer.borderWidth = 0
                    textField.resignFirstResponder()
                    return true
                }
                
            default:
                return true
        }
    }
    
    func hideKeyboardFromOutsideTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK: - Custom Protocols and Delegate Methods
extension RegisterViewController: ImageSelecterDelegate {
    func setNewImage(image: String, backgroundColor: UIColor) {
        imageView.image = UIImage(named: image)
        imageView.backgroundColor = backgroundColor
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.cornerRadius = 10
        
    }
    
}
