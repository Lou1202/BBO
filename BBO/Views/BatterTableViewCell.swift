//
//  BatterTableViewCell.swift
//  BBO
//
//  Created by 楊曜安 on 2024/2/1.
//

import UIKit

class BatterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var positionLabel2: UILabel!
    @IBOutlet weak var battingHandLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var throwingLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var potentialLabel1: UILabel!
    @IBOutlet weak var potentialLabel2: UILabel!
    @IBOutlet weak var potentialLabel3: UILabel!
    @IBOutlet weak var veteranPotentialLabel: UILabel!
    @IBOutlet weak var upgradeTypeLabel: UILabel!
    @IBOutlet weak var weatherAttributeImageView: UIImageView!
    @IBOutlet weak var veteranWeatherAttributeImageView: UIImageView!
    @IBOutlet weak var addLineupButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellAppearance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCellAppearance() {
        // 設置圓角邊框
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
    }
    
    func updateUI(with batterInfo: BatterInfo){
        leagueLabel.text = batterInfo.league
        teamLabel.text = batterInfo.team
        battingHandLabel.text = batterInfo.battingHand
        powerLabel.text = String(batterInfo.power)
        contactLabel.text = String(batterInfo.contact)
        speedLabel.text = String(batterInfo.speed)
        throwingLabel.text = String(batterInfo.throwing)
        defenseLabel.text = String(batterInfo.defense)
        potentialLabel1.text = batterInfo.potential[0]
        potentialLabel2.text = batterInfo.potential[1]
        potentialLabel3.text = batterInfo.potential[2]
        potentialLabel1.layer.borderWidth = 1
        potentialLabel1.layer.borderColor = CGColor(red: 140/255, green: 160/255, blue: 220/255, alpha: 1)
        potentialLabel2.layer.borderWidth = 1
        potentialLabel2.layer.borderColor = CGColor(red: 140/255, green: 160/255, blue: 220/255, alpha: 1)
        potentialLabel3.layer.borderWidth = 1
        potentialLabel3.layer.borderColor = CGColor(red: 140/255, green: 160/255, blue: 220/255, alpha: 1)
        veteranPotentialLabel.text = batterInfo.veteranPotential
        veteranPotentialLabel.layer.borderWidth = 1
        veteranPotentialLabel.layer.borderColor = CGColor(red: 140/255, green: 160/255, blue: 220/255, alpha: 1)
        
        if batterInfo.addLineup == nil {
            addLineupButton.isHidden = false
        } else {
            addLineupButton.isHidden = true
        }
        
        if batterInfo.year != "AS" {
            nameLabel.text = "\(batterInfo.year.suffix(2)) \(batterInfo.name)"
        } else if batterInfo.rarity == "FR" {
            nameLabel.text = "\(batterInfo.rarity) \(batterInfo.name)"
        } else {
            nameLabel.text = batterInfo.name
        }
        
        if batterInfo.position.count == 1 {
            positionLabel.text = batterInfo.position[0]
            positionLabel2.isHidden = true
        } else {
            positionLabel.text = batterInfo.position[0]
            positionLabel2.text = batterInfo.position[1]
            positionLabel2.textColor = UIColor.gray
        }
        
        if batterInfo.specialStance == true {
            battingHandLabel.text = "\(batterInfo.battingHand)特姿"
            battingHandLabel.backgroundColor = UIColor(red: 15/255, green: 150/255, blue: 35/255, alpha: 1)
            battingHandLabel.textColor = UIColor(red: 210/255, green: 240/255, blue: 50/255, alpha: 1)
        } else {
            battingHandLabel.text = batterInfo.battingHand
            battingHandLabel.backgroundColor = .clear
            battingHandLabel.textColor = UIColor(red: 140/255, green: 160/255, blue: 220/255, alpha: 1)
        }
        
        switch batterInfo.rarity {
        case "黑":
            leagueLabel.backgroundColor = UIColor.black
            leagueLabel.textColor = UIColor(red: 210/255, green: 160/255, blue: 90/255, alpha: 1)
            nameLabel.backgroundColor = UIColor.black
            nameLabel.textColor = UIColor(red: 210/255, green: 160/255, blue: 90/255, alpha: 1)
        case "紫", "FR":
            leagueLabel.backgroundColor = UIColor(red: 70/255, green: 60/255, blue: 160/255, alpha: 1)
            leagueLabel.textColor = UIColor.white
            nameLabel.backgroundColor = UIColor(red: 70/255, green: 60/255, blue: 160/255, alpha: 1)
            nameLabel.textColor = UIColor.white
        case "金":
            leagueLabel.backgroundColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
            leagueLabel.textColor = UIColor.black
            nameLabel.backgroundColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
            nameLabel.textColor = UIColor.black
        case "紅":
            leagueLabel.backgroundColor = UIColor(red: 140/255, green: 40/255, blue: 60/255, alpha: 1)
            leagueLabel.textColor = UIColor.white
            nameLabel.backgroundColor = UIColor(red: 140/255, green: 40/255, blue: 60/255, alpha: 1)
            nameLabel.textColor = UIColor.white
        default:
            break
        }
        
        switch batterInfo.weatherAttribute {
        case "晴":
            weatherAttributeImageView.image = UIImage(systemName: "sun.max.fill")
            weatherAttributeImageView.tintColor = UIColor(red: 240/255, green: 15/255, blue: 20/255, alpha: 1)
        case "雪":
            weatherAttributeImageView.image = UIImage(systemName: "snowflake")
            weatherAttributeImageView.tintColor = UIColor.cyan
        case "雨":
            weatherAttributeImageView.image = UIImage(systemName: "umbrella.fill")
            weatherAttributeImageView.tintColor = UIColor(red: 10/255, green: 160/255, blue: 250/255, alpha: 1)
        case "陰":
            weatherAttributeImageView.image = UIImage(systemName: "cloud.fill")
            weatherAttributeImageView.tintColor = UIColor(red: 180/255, green: 180/255, blue: 210/255, alpha: 1)
        case "無":
            weatherAttributeImageView.image = UIImage(systemName: "circle.fill")
            weatherAttributeImageView.tintColor = UIColor(red: 110/255, green: 175/255, blue: 30/255, alpha: 1)
        default:
            break
        }
        
        switch batterInfo.veteranWeatherAttribute {
        case "晴":
            veteranWeatherAttributeImageView.image = UIImage(systemName: "sun.max.fill")
            veteranWeatherAttributeImageView.tintColor = UIColor(red: 240/255, green: 15/255, blue: 20/255, alpha: 1)
        case "雪":
            veteranWeatherAttributeImageView.image = UIImage(systemName: "snowflake")
            veteranWeatherAttributeImageView.tintColor = UIColor.cyan
        case "雨":
            veteranWeatherAttributeImageView.image = UIImage(systemName: "umbrella.fill")
            veteranWeatherAttributeImageView.tintColor = UIColor(red: 10/255, green: 160/255, blue: 250/255, alpha: 1)
        case "陰":
            veteranWeatherAttributeImageView.image = UIImage(systemName: "cloud.fill")
            veteranWeatherAttributeImageView.tintColor = UIColor(red: 180/255, green: 180/255, blue: 210/255, alpha: 1)
        default:
            break
        }
        
        switch batterInfo.upgradeType {
        case "力速":
            upgradeTypeLabel.text = "力量,速度型"
        case "力傳":
            upgradeTypeLabel.text = "力量,傳球型"
        case "力防":
            upgradeTypeLabel.text = "力量,守備型"
        case "打速":
            upgradeTypeLabel.text = "打擊,速度型"
        case "打傳":
            upgradeTypeLabel.text = "打擊,傳球型"
        case "打防":
            upgradeTypeLabel.text = "打擊,守備型"
        default:
            upgradeTypeLabel.text = "類型錯誤"
        }
    }
}
