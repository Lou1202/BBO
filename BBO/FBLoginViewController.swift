//
//  LoginViewController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/5/7.
//

import UIKit
import FacebookLogin
import FacebookCore

class FBLoginViewController: UIViewController {
    
    let nameLabel = UILabel()
    let profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        profileImageView.frame = CGRect(x: (view.bounds.width - 100) / 2, y: view.center.y - 150, width: 100, height: 100)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        view.addSubview(profileImageView)
        
        nameLabel.frame = CGRect(x: 20, y: profileImageView.frame.maxY + 10, width: view.bounds.width - 40, height: 40)
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
        
        let loginButton = FBLoginButton()
        loginButton.center = CGPoint(x: view.center.x, y: nameLabel.frame.maxY + 50)
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        
        
        if let accessToken = AccessToken.current, !accessToken.isExpired {
            print("\(accessToken.userID) 登入")
            fetchProfile()
        } else {
            print("未登入")
            displayDefaultProfile()
        }
        
        
    }
    
    func fetchProfile() {
        Profile.loadCurrentProfile { profile, error in
            if let profile = profile {
                DispatchQueue.main.async {
                    self.nameLabel.text = profile.name
                    if let imageURL = profile.imageURL(forMode: .square, size: CGSize(width: 100, height: 100)) {
                        self.loadImage(from: imageURL)
                    }
                }
            }
        }
    }
    
    func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("下載圖片失敗: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("圖片無效")
                return
            }
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }
        task.resume()
    }

    
    func displayDefaultProfile() {
        nameLabel.text = "未登入"
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate)
        profileImageView.tintColor = .gray
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

extension FBLoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("登入失敗: \(error.localizedDescription)")
            return
        }
        
        if result?.isCancelled == true {
            print("登入取消")
        } else {
            print("登入成功")
            fetchProfile()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("登出")
        displayDefaultProfile()
    }
}
