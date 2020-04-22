//
//  ViewController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 24.03.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

// На основе предыдущего ПЗ:
// 1. Сделать анимацию переходов между экранами в UINavigationController. Появляющийся экран сначала находится за пределами видимости и повернут на 90 градусов, при этом его верхний правый угол прижат к такому же углу текущего экрана. В момент перехода появляющийся экран разворачивается относительно верхнего правого угла и становится на место текущего. Анимация закрытия должна выглядеть точно наоборот.
// 2. Сделать интерактивную анимацию закрытия экрана в UINavigationController. В качестве распознавателя жестов использовать UIScreenEdgePanGestureRecognizer.
// 3.* Сделать анимацию показа и закрытия экрана просмотра фотографии. При нажатии картинка увеличивается на весь экран, а при закрытии — уменьшается до исходного размера.
// 4.* Добавить возможность закрыть экран просмотра фотографии с помощью жеста смахивания вниз.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.borderColor = UIColor.black.cgColor

        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc func keyboardWasShown(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        scrollViewBottomConstraint.constant = frame.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollViewBottomConstraint.constant = 0
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    func isCredentialsValid() -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        return login == "admin" && password == "1234"
    }
    
    func showErrorAlert(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(actionOk)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        view.endEditing(true)
        if identifier == "segueShowTabBar" {
            let isValid = isCredentialsValid()
            if !isValid {
                showErrorAlert("Неверный логин или пароль")
            }
            return isValid
        }
        return true
    }
}

extension ViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            view.endEditing(true)
        }
        return true
    }
}
