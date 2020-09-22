//
//  ViewController.swift
//  AlarTest
//
//  Created by Oleg Frolov on 21.09.2020.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    private var cancellable: AnyCancellable?
    private let authManager = AuthManager()
    private let placesManager = PlacesManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.addTarget(self, action: #selector(onTextFieldEdit(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(onTextFieldEdit(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribe()
    }
    
    

    override func viewDidDisappear(_ animated: Bool) {
        loginTextField.text = nil
        passwordTextField.text = nil
        setLoginButton()
        activityIndicatory(show: false)
    }
    
    
    @objc private func onTextFieldEdit(_ textField: UITextField) {
        setLoginButton()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        passwordTextField.resignFirstResponder()
        activityIndicatory(show: true)
        let login = loginTextField.text!
        let pass = passwordTextField.text!
        self.tryToLogin(login, pass)
    }
    
    
    // Настраиваю loginButton
    private func setLoginButton() {
        let isEnabled = loginTextField.hasText && passwordTextField.hasText
        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) : #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
    }
    
    
    // Подписываюсь на отслеживание изменений в placesArray, при заполнении идем на следующий viewController
    private func subscribe() {
        cancellable = placesManager.objectWillChange.sink { [weak self] in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "Places") as! PlacesListVC
            vc.modalPresentationStyle = .fullScreen
            vc.placesManager = self!.placesManager
            self?.show(vc, sender: nil)
            self?.cancellable?.cancel()
        }
    }
    
    
    
    private func tryToLogin(_ login: String, _ pass: String) {
        authManager.tryToAuth(login: login, pass: pass) { auth in
            if let auth = auth {
                if auth.status == "ok" {
                    AppSettings.shared.authCode = auth.code
                    var placesArray: [Place] = []
                    // Использую цикл для заполнения всего экрана записями, так как 10 - мало
                    for i in 1...3 {
                        self.placesManager.getPlaces(code: AppSettings.shared.authCode, page: i) { places in
                            if let places = places {
                                placesArray += places.data
                                if i == 3 {
                                    self.placesManager.placesArray = placesArray
                                }
                            }
                        }
                    }
                } else {
                    self.activityIndicatory(show: false)
                    self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка!", message: "Неверный логин или пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

