//
//  TeamLineupViewController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/3/3.
//

import UIKit

class TeamLineupViewController: UIViewController {

    @IBOutlet var containerViews: [UIView]!
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeInfo(_ sender: UISegmentedControl) {
        containerViews.forEach {
            $0.isHidden = true
        }
        views.forEach {
            $0.isHidden = true
        }
        containerViews[sender.selectedSegmentIndex].isHidden = false
        views[sender.selectedSegmentIndex].isHidden = false
        
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
