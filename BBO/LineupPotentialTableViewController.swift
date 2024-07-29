//
//  LineupPotentialTableViewController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/3/20.
//

import UIKit

class LineupPotentialTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLineupBatters()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLineupBatters()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return LineupValueTableViewController.teamLineupBatters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LineupPotentialTableViewCell.self)", for: indexPath) as? LineupPotentialTableViewCell else { fatalError("LineupPotentialTableViewCell failed")}
            let batter = LineupValueTableViewController.teamLineupBatters[indexPath.section]
            cell.setPotentialButton(with: batter)
            cell.updateUI(with: batter)
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row == 1 ? .none : .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let batter = LineupValueTableViewController.teamLineupBatters[indexPath.section]
            
            Task{
                if let batterID = batter.id {
                    do{
                        
                        let _ = try await PlayersController.shared.deleteTeamLineup(batterID)
                        LineupValueTableViewController.teamLineupBatters.remove(at: indexPath.section)
                        tableView.deleteSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
                        
                        var selectedBatter = batter
                        selectedBatter.id = nil
                        selectedBatter.createdTime = nil
                        selectedBatter.fields.createdTime = nil
                        selectedBatter.fields.addLineup = ""
                        selectedBatter.fields.level = nil
                        let _ = try await PlayersController.shared.updateBatterTeamLineup(batter.fields.addLineup ?? "", with: selectedBatter)
                        
                        
                    }catch{
                        print("Failed to delete batter: \(error)")
                    }
                } else {
                    print("Batter ID is nil")
                }
                
            }
        }
    }
    
    func fetchLineupBatters() {
        Task {
            do {
                // 使用 await 來呼叫異步方法
                LineupValueTableViewController.teamLineupBatters = try await PlayersController.shared.fetchTeamLineup()
                // 在異步操作完成後，更新 UI
                DispatchQueue.main.async {
                    // 這裡可以進行相關的 UI 更新，例如更新表格、視圖等
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to fetch batters: \(error)")
            }
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
