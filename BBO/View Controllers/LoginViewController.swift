//
//  LoginViewController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/7/14.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingUI()

        // Do any additional setup after loading the view.
    }
    
    func setupLoadingUI() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func stopLoadingUI() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            stopLoadingUI()
            showAlert(message: "請輸入使用者帳號或email和密碼")
            return
        }
        
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UserController.shared.loginUser(loginUser: UserSession(login: login, password: password)) { [weak self] result in
            
            
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
                
                switch result {
                case .success(let response):
                    if response.errorCode != nil {
                        self?.showAlert(message: response.message ?? "未知錯誤")
                    } else {
                        self?.showAlert(message: "登入成功", success: true)
                    }
                case .failure(let error):
                    self?.showAlert(message: "登入失敗：\(error.localizedDescription)")
                }
            }
        }
        
    }
    
    func showAlert(message: String, success: Bool = false) {
        
        let alertController = UIAlertController(title: success ? "成功" : "錯誤", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if success {
                self.performSegue(withIdentifier: "showMainViewForLogin", sender: self)
            }
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
