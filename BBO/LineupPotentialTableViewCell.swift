//
//  LineupPotentialTableViewCell.swift
//  BBO
//
//  Created by 楊曜安 on 2024/3/21.
//

import UIKit

class LineupPotentialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var potentialButton: UIButton!
    @IBOutlet weak var veteranPotentialLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func updateUI(with batter: Batter) {
        positionLabel.text = batter.fields.position[0]
        veteranPotentialLabel.text = batter.fields.veteranPotential
        potentialButton.setTitle("\(batter.fields.selectedPotential ?? "\(batter.fields.potential[0])")", for: .normal)
        
        if batter.fields.year != "AS" {
            nameLabel.text = "\(batter.fields.year.suffix(2)) \(batter.fields.name)"
        } else if batter.fields.rarity == "FR" {
            nameLabel.text = "\(batter.fields.rarity) \(batter.fields.name)"
        } else {
            nameLabel.text = batter.fields.name
        }
        
        switch batter.fields.rarity {
        case "黑":
            nameLabel.backgroundColor = UIColor.black
            nameLabel.textColor = UIColor(red: 210/255, green: 160/255, blue: 90/255, alpha: 1)
        case "紫", "FR":
            
            nameLabel.backgroundColor = UIColor(red: 70/255, green: 60/255, blue: 160/255, alpha: 1)
            nameLabel.textColor = UIColor.white
        case "金":
            nameLabel.backgroundColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
            nameLabel.textColor = UIColor.black
        case "紅":
            nameLabel.backgroundColor = UIColor(red: 140/255, green: 40/255, blue: 60/255, alpha: 1)
            nameLabel.textColor = UIColor.white
        default:
            break
        }
    }
    
    
    func setPotentialButton(with batter: Batter) {

        potentialButton.menu = UIMenu(children: [
            UIAction(title: "\(batter.fields.potential[0])", handler: { action in
                self.updatePotential(potential: "\(batter.fields.potential[0])", with: batter)
            }),
            UIAction(title: "\(batter.fields.potential[1])", handler: { action in
                self.updatePotential(potential: "\(batter.fields.potential[1])", with: batter)
            }),
            UIAction(title: "\(batter.fields.potential[2])", handler: { action in
                self.updatePotential(potential: "\(batter.fields.potential[2])", with: batter)
            })
        ])
    }
    
    
    func updatePotential(potential: String, with batter: Batter) {
        Task {
            do {
                var updatedBatterInfo = batter.fields
                updatedBatterInfo.createdTime = nil
                updatedBatterInfo.selectedPotential = potential
                let updatedBatter = Batter(fields: updatedBatterInfo)
                let _ = try await PlayersController.shared.updatelevel(batter.id ?? "", with: updatedBatter)
            } catch {
                print("更新球員潛力失敗: \(error)")
            }
        }
    }
}

