//
//  ViewController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 24.03.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

// На основе предыдущего ПЗ:
// 1. Создать индикатор загрузки, который будет состоять из трех точек, меняющих прозрачность по очереди.
// 2. Добавить анимацию нажатия на аватарку пользователя/группы в соответствующих таблицах. По нажатию фотография должна немного сжиматься, а после — возвращаться к исходному размеру с эффектом пружины. Нужно подобрать оптимальное время анимации, чтобы получить максимально реалистичный эффект.
// 3. Сделать анимацию изменения количества отметок «Мне нравится». Это может быть любая анимация: переворот из стороны в сторону, плавная смена или перелистывание.
// * 4. Сделать анимацию появления и исчезновения ячеек с фотографиями. Перед показом ячейки она должна увеличиваться и становиться непрозрачной, а перед исчезновением — уменьшаться и становиться прозрачной. (Необязательное задание — для тех, у кого есть время.)
// * 5. Сделать кастомную строку поиска (как UISearchBar). Посередине должна находиться иконка лупы. Когда строку поиска активируют, лупа перемещается в сторону и останавливается с эффектом пружины. Также в этот момент строка поиска укорачивается с правой стороны и на пустом месте появляется кнопка отмены. Все это происходит анимированно. Когда поиск отменяется или с его строки снимается фокус, она должна вернуться в исходное состояние. (Необязательное задание — для тех, у кого есть время.)

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
