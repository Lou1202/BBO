//
//  BatterTableViewController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/2/1.
//

import UIKit

class BatterTableViewController: UITableViewController {
    
    
    
    static var batters = [Batter]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBatters()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBatters()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return BatterTableViewController.batters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SeparatorTableViewCell.self)", for: indexPath) as? SeparatorTableViewCell else { fatalError("SeparatorTableViewCell failed") }
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BatterTableViewCell.self)", for: indexPath) as? BatterTableViewCell else { fatalError("BatterTableViewCell failed") }
            cell.updateUI(with: BatterTableViewController.batters[indexPath.section].fields)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 5
        } else {
            return 160
        }
    }
    
    func fetchBatters() {
        Task {
            do {
                // 使用 await 來呼叫異步方法
                BatterTableViewController.batters = try await PlayersController.shared.fetchBatters()
                // 在異步操作完成後，更新 UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to fetch batters: \(error)")
            }
        }
    }
    
    @IBAction func addBatterLineup(_ sender: UIButton) {
        
        
        // tableview選取的位置對應indexPath
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            //如果選取的section 超出陣列範圍 將無效
            guard indexPath.section < BatterTableViewController.batters.count else {
                return
            }
            
            var selectedBatter = BatterTableViewController.batters[indexPath.section]
            selectedBatter.fields.addLineup = selectedBatter.id
            selectedBatter.id = nil
            selectedBatter.createdTime = nil
            selectedBatter.fields.createdTime = nil
            
            Task {
                do {
                    let _ = try await PlayersController.shared.updateBatterTeamLineup(BatterTableViewController.batters[indexPath.section].id ?? "", with: selectedBatter)
                    selectedBatter.fields.level = "LV 0"
                    selectedBatter.fields.selectedPotential = selectedBatter.fields.potential[0]
                    
                    let _ = try await PlayersController.shared.addTeamLineup(selectedBatter)
                    fetchBatters()
                    
                } catch {
                    print("Failed to add or update batter: \(error)")
                }
            }
            
            let alertController = UIAlertController(title: "\(selectedBatter.fields.year == "AS" ? "\(selectedBatter.fields.rarity == "FR" ? "\(selectedBatter.fields.rarity) \(selectedBatter.fields.name)" : "\(selectedBatter.fields.name)")" : "\(selectedBatter.fields.year.suffix(2)) \(selectedBatter.fields.name)")", message: "加入到隊伍陣容", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }








/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}
