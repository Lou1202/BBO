//
//  RegisterViewController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/7/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    /// 驗證帳號的正則表達式
    let loginRegex = "^(?=.*[a-zA-Z])[a-zA-Z0-9_]{1,20}$"
    /// 驗證 email 的正則表達式
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    /// 活動指示器（等待伺服器回應時，讓用戶知道目前正在執行）
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
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let email = emailTextField.text else { return }
        
        print("Login: \(login)")
        print("Password: \(password)")
        print("Email: \(email)")
        
        // 檢查Login格式
        if !NSPredicate(format: "SELF MATCHES %@", loginRegex).evaluate(with: login) {
            stopLoadingUI()
            showAlert(message: "登錄名稱只能包含至少包含一個英文字母(a-z)、數字(0-9)和底線。長度必須在1至20個字之間")
            return
        }
        
        // 檢查Email格式
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            stopLoadingUI()
            showAlert(message: "請輸入有效的電子郵件地址")
            return
        }
        
        // 檢查密碼長度
        if password.count < 5 || password.count > 120 {
            stopLoadingUI()
            showAlert(message: "密碼長度必須在5至120個字之間")
            return
        }
        
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UserController.shared.registerUser(user: CreateUser(login: login, email: email, password: password)) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
                
                switch result {
                case .success(let response):
                    if response.errorCode != nil {
                        self?.showAlert(message: response.message ?? "未知錯誤")
                    } else {
                        self?.showAlert(message: "註冊成功", success: true)
                    }
                    
                case .failure(let error):
                    self?.showAlert(message: "註冊失敗：\(error.localizedDescription)")
                }
                
            }
        }
    }
    
    func showAlert(message: String, success: Bool = false) {
        
        let alertController = UIAlertController(title: success ? "成功" : "錯誤", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if success {
                self.performSegue(withIdentifier: "showMainViewForRegister", sender: self)
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
