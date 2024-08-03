//
//  LineupValueTableViewCell.swift
//  BBO
//
//  Created by 楊曜安 on 2024/3/4.
//

import UIKit

class LineupValueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherAttributeImageView: UIImageView!
    @IBOutlet weak var veteranWeatherAttributeImageView: UIImageView!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var throwingLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var levelMenu: UIMenu!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(with batter: Batter) {
        powerLabel.text = String(batter.fields.power)
        contactLabel.text = String(batter.fields.contact)
        speedLabel.text = String(batter.fields.speed)
        throwingLabel.text = String(batter.fields.throwing)
        defenseLabel.text = String(batter.fields.defense)
        positionLabel.text = batter.fields.position[0]
        
        switch batter.fields.level {
        case "LV 0":
            levelButton.setTitle("LV 0", for: .normal)
            powerLabel.text = String(batter.fields.power)
            contactLabel.text = String(batter.fields.contact)
            speedLabel.text = String(batter.fields.speed)
            throwingLabel.text = String(batter.fields.throwing)
            defenseLabel.text = String(batter.fields.defense)
        case "LV 1":
            levelButton.setTitle("LV 1", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速", "力傳", "力防":
                powerLabel.text = String(batter.fields.power + 1)
            case "打速", "打傳", "打防":
                contactLabel.text = String(batter.fields.contact + 1)
            default:
                break
            }
        case "LV 2":
            levelButton.setTitle("LV 2", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速":
                self.powerLabel.text = String(batter.fields.power + 1)
                self.speedLabel.text = String(batter.fields.speed + 1)
            case "力傳":
                self.powerLabel.text = String(batter.fields.power + 1)
                self.throwingLabel.text = String(batter.fields.throwing + 1)
            case "力防":
                self.powerLabel.text = String(batter.fields.power + 1)
                self.defenseLabel.text = String(batter.fields.defense + 1)
            case "打速":
                self.contactLabel.text = String(batter.fields.contact + 1)
                self.speedLabel.text = String(batter.fields.speed + 1)
            case "打傳":
                self.contactLabel.text = String(batter.fields.contact + 1)
                self.throwingLabel.text = String(batter.fields.throwing + 1)
            case "打防":
                self.contactLabel.text = String(batter.fields.contact + 1)
                self.defenseLabel.text = String(batter.fields.defense + 1)
            default:
                break
            }
        case "LV 3":
            levelButton.setTitle("LV 3", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速":
                self.powerLabel.text = String(batter.fields.power + 2)
                self.speedLabel.text = String(batter.fields.speed + 1)
            case "力傳":
                self.powerLabel.text = String(batter.fields.power + 2)
                self.throwingLabel.text = String(batter.fields.throwing + 1)
            case "力防":
                self.powerLabel.text = String(batter.fields.power + 2)
                self.defenseLabel.text = String(batter.fields.defense + 1)
            case "打速":
                self.contactLabel.text = String(batter.fields.contact + 2)
                self.speedLabel.text = String(batter.fields.speed + 1)
            case "打傳":
                self.contactLabel.text = String(batter.fields.contact + 2)
                self.throwingLabel.text = String(batter.fields.throwing + 1)
            case "打防":
                self.contactLabel.text = String(batter.fields.contact + 2)
                self.defenseLabel.text = String(batter.fields.defense + 1)
            default:
                break
            }
        case "LV 4":
            levelButton.setTitle("LV 4", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速":
                self.powerLabel.text = String(batter.fields.power + 2)
                self.speedLabel.text = String(batter.fields.speed + 2)
            case "力傳":
                self.powerLabel.text = String(batter.fields.power + 2)
                self.throwingLabel.text = String(batter.fields.throwing + 2)
            case "力防":
                self.powerLabel.text = String(batter.fields.power + 2)
                self.defenseLabel.text = String(batter.fields.defense + 2)
            case "打速":
                self.contactLabel.text = String(batter.fields.contact + 2)
                self.speedLabel.text = String(batter.fields.speed + 2)
            case "打傳":
                self.contactLabel.text = String(batter.fields.contact + 2)
                self.throwingLabel.text = String(batter.fields.throwing + 2)
            case "打防":
                self.contactLabel.text = String(batter.fields.contact + 2)
                self.defenseLabel.text = String(batter.fields.defense + 2)
            default:
                break
            }
        case "LV 5":
            levelButton.setTitle("LV 5", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速":
                self.powerLabel.text = String(batter.fields.power + 3)
                self.speedLabel.text = String(batter.fields.speed + 3)
            case "力傳":
                self.powerLabel.text = String(batter.fields.power + 3)
                self.throwingLabel.text = String(batter.fields.throwing + 3)
            case "力防":
                self.powerLabel.text = String(batter.fields.power + 3)
                self.defenseLabel.text = String(batter.fields.defense + 3)
            case "打速":
                self.contactLabel.text = String(batter.fields.contact + 3)
                self.speedLabel.text = String(batter.fields.speed + 3)
            case "打傳":
                self.contactLabel.text = String(batter.fields.contact + 3)
                self.throwingLabel.text = String(batter.fields.throwing + 3)
            case "打防":
                self.contactLabel.text = String(batter.fields.contact + 3)
                self.defenseLabel.text = String(batter.fields.defense + 3)
            default:
                break
            }
        case "LV 6":
            levelButton.setTitle("LV 6", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速":
                self.powerLabel.text = String(batter.fields.power + 5)
                self.speedLabel.text = String(batter.fields.speed + 5)
            case "力傳":
                self.powerLabel.text = String(batter.fields.power + 5)
                self.throwingLabel.text = String(batter.fields.throwing + 5)
            case "力防":
                self.powerLabel.text = String(batter.fields.power + 5)
                self.defenseLabel.text = String(batter.fields.defense + 5)
            case "打速":
                self.contactLabel.text = String(batter.fields.contact + 5)
                self.speedLabel.text = String(batter.fields.speed + 5)
            case "打傳":
                self.contactLabel.text = String(batter.fields.contact + 3)
                self.throwingLabel.text = String(batter.fields.throwing + 3)
            case "打防":
                self.contactLabel.text = String(batter.fields.contact + 5)
                self.defenseLabel.text = String(batter.fields.defense + 5)
            default:
                break
            }
        case "LV 7":
            levelButton.setTitle("LV 7", for: .normal)
            
            switch batter.fields.upgradeType {
            case "力速":
                self.powerLabel.text = String(batter.fields.power + 7)
                self.speedLabel.text = String(batter.fields.speed + 7)
            case "力傳":
                self.powerLabel.text = String(batter.fields.power + 7)
                self.throwingLabel.text = String(batter.fields.throwing + 7)
            case "力防":
                self.powerLabel.text = String(batter.fields.power + 7)
                self.defenseLabel.text = String(batter.fields.defense + 7)
            case "打速":
                self.contactLabel.text = String(batter.fields.contact + 7)
                self.speedLabel.text = String(batter.fields.speed + 7)
            case "打傳":
                self.contactLabel.text = String(batter.fields.contact + 7)
                self.throwingLabel.text = String(batter.fields.throwing + 7)
            case "打防":
                self.contactLabel.text = String(batter.fields.contact + 7)
                self.defenseLabel.text = String(batter.fields.defense + 7)
            default:
                break
            }
        default:
            break
        }
        
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
        
        switch batter.fields.weatherAttribute {
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
        
        switch batter.fields.veteranWeatherAttribute {
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
        
    }
    
    func setLevelButton(with batter: Batter) {
        
        levelButton.menu = UIMenu(children: [
            UIAction(title: "LV 0", handler: { action in
                
                self.updatelevel(level: "LV 0", with: batter)
                self.powerLabel.text = String(batter.fields.power)
                self.contactLabel.text = String(batter.fields.contact)
                self.speedLabel.text = String(batter.fields.speed)
                self.throwingLabel.text = String(batter.fields.throwing)
                self.defenseLabel.text = String(batter.fields.defense)
            }),
            UIAction(title: "LV 1", handler: { action in
                
                self.updatelevel(level: "LV 1", with: batter)
                
                switch batter.fields.upgradeType {
                case "力速", "力傳", "力防":
                    self.powerLabel.text = String(batter.fields.power + 1)
                case "打速", "打傳", "打防":
                    self.contactLabel.text = String(batter.fields.contact + 1)
                default:
                    break
                }
            }),
            UIAction(title: "LV 2", handler: { action in
                
                self.updatelevel(level: "LV 2", with: batter)
                
                switch batter.fields.upgradeType {
                case "力速":
                    self.powerLabel.text = String(batter.fields.power + 1)
                    self.speedLabel.text = String(batter.fields.speed + 1)
                case "力傳":
                    self.powerLabel.text = String(batter.fields.power + 1)
                    self.throwingLabel.text = String(batter.fields.throwing + 1)
                case "力防":
                    self.powerLabel.text = String(batter.fields.power + 1)
                    self.defenseLabel.text = String(batter.fields.defense + 1)
                case "打速":
                    self.contactLabel.text = String(batter.fields.contact + 1)
                    self.speedLabel.text = String(batter.fields.speed + 1)
                case "打傳":
                    self.contactLabel.text = String(batter.fields.contact + 1)
                    self.throwingLabel.text = String(batter.fields.throwing + 1)
                case "打防":
                    self.contactLabel.text = String(batter.fields.contact + 1)
                    self.defenseLabel.text = String(batter.fields.defense + 1)
                default:
                    break
                }
            }),
            UIAction(title: "LV 3", handler: { action in
                
                self.updatelevel(level: "LV 3", with: batter)
                
                switch batter.fields.upgradeType {
                    
                case "力速":
                    self.powerLabel.text = String(batter.fields.power + 2)
                    self.speedLabel.text = String(batter.fields.speed + 1)
                case "力傳":
                    self.powerLabel.text = String(batter.fields.power + 2)
                    self.throwingLabel.text = String(batter.fields.throwing + 1)
                case "力防":
                    self.powerLabel.text = String(batter.fields.power + 2)
                    self.defenseLabel.text = String(batter.fields.defense + 1)
                case "打速":
                    self.contactLabel.text = String(batter.fields.contact + 2)
                    self.speedLabel.text = String(batter.fields.speed + 1)
                case "打傳":
                    self.contactLabel.text = String(batter.fields.contact + 2)
                    self.throwingLabel.text = String(batter.fields.throwing + 1)
                case "打防":
                    self.contactLabel.text = String(batter.fields.contact + 2)
                    self.defenseLabel.text = String(batter.fields.defense + 1)
                default:
                    break
                }
            }),
            UIAction(title: "LV 4", handler: { action in
                
                self.updatelevel(level: "LV 4", with: batter)
                
                switch batter.fields.upgradeType {
                case "力速":
                    self.powerLabel.text = String(batter.fields.power + 2)
                    self.speedLabel.text = String(batter.fields.speed + 2)
                case "力傳":
                    self.powerLabel.text = String(batter.fields.power + 2)
                    self.throwingLabel.text = String(batter.fields.throwing + 2)
                case "力防":
                    self.powerLabel.text = String(batter.fields.power + 2)
                    self.defenseLabel.text = String(batter.fields.defense + 2)
                case "打速":
                    self.contactLabel.text = String(batter.fields.contact + 2)
                    self.speedLabel.text = String(batter.fields.speed + 2)
                case "打傳":
                    self.contactLabel.text = String(batter.fields.contact + 2)
                    self.throwingLabel.text = String(batter.fields.throwing + 2)
                case "打防":
                    self.contactLabel.text = String(batter.fields.contact + 2)
                    self.defenseLabel.text = String(batter.fields.defense + 2)
                default:
                    break
                }
            }),
            UIAction(title: "LV 5", handler: { action in
                
                self.updatelevel(level: "LV 5", with: batter)
                
                switch batter.fields.upgradeType {
                case "力速":
                    self.powerLabel.text = String(batter.fields.power + 3)
                    self.speedLabel.text = String(batter.fields.speed + 3)
                case "力傳":
                    self.powerLabel.text = String(batter.fields.power + 3)
                    self.throwingLabel.text = String(batter.fields.throwing + 3)
                case "力防":
                    self.powerLabel.text = String(batter.fields.power + 3)
                    self.defenseLabel.text = String(batter.fields.defense + 3)
                case "打速":
                    self.contactLabel.text = String(batter.fields.contact + 3)
                    self.speedLabel.text = String(batter.fields.speed + 3)
                case "打傳":
                    self.contactLabel.text = String(batter.fields.contact + 3)
                    self.throwingLabel.text = String(batter.fields.throwing + 3)
                case "打防":
                    self.contactLabel.text = String(batter.fields.contact + 3)
                    self.defenseLabel.text = String(batter.fields.defense + 3)
                default:
                    break
                }
            }),
            UIAction(title: "LV 6", handler: { action in
                
                self.updatelevel(level: "LV 6", with: batter)
                
                switch batter.fields.upgradeType {
                case "力速":
                    self.powerLabel.text = String(batter.fields.power + 5)
                    self.speedLabel.text = String(batter.fields.speed + 5)
                case "力傳":
                    self.powerLabel.text = String(batter.fields.power + 5)
                    self.throwingLabel.text = String(batter.fields.throwing + 5)
                case "力防":
                    self.powerLabel.text = String(batter.fields.power + 5)
                    self.defenseLabel.text = String(batter.fields.defense + 5)
                case "打速":
                    self.contactLabel.text = String(batter.fields.contact + 5)
                    self.speedLabel.text = String(batter.fields.speed + 5)
                case "打傳":
                    self.contactLabel.text = String(batter.fields.contact + 3)
                    self.throwingLabel.text = String(batter.fields.throwing + 3)
                case "打防":
                    self.contactLabel.text = String(batter.fields.contact + 5)
                    self.defenseLabel.text = String(batter.fields.defense + 5)
                default:
                    break
                }
            }),
            UIAction(title: "LV 7", handler: { action in
                
                self.updatelevel(level: "LV 7", with: batter)
                
                switch batter.fields.upgradeType {
                case "力速":
                    self.powerLabel.text = String(batter.fields.power + 7)
                    self.speedLabel.text = String(batter.fields.speed + 7)
                case "力傳":
                    self.powerLabel.text = String(batter.fields.power + 7)
                    self.throwingLabel.text = String(batter.fields.throwing + 7)
                case "力防":
                    self.powerLabel.text = String(batter.fields.power + 7)
                    self.defenseLabel.text = String(batter.fields.defense + 7)
                case "打速":
                    self.contactLabel.text = String(batter.fields.contact + 7)
                    self.speedLabel.text = String(batter.fields.speed + 7)
                case "打傳":
                    self.contactLabel.text = String(batter.fields.contact + 7)
                    self.throwingLabel.text = String(batter.fields.throwing + 7)
                case "打防":
                    self.contactLabel.text = String(batter.fields.contact + 7)
                    self.defenseLabel.text = String(batter.fields.defense + 7)
                default:
                    break
                }
            })
        ])
    }
    
    func updatelevel(level: String, with batter: Batter) {
        Task {
            do {
                
                var updatedBatterInfo = batter.fields
                updatedBatterInfo.level = level
                updatedBatterInfo.createdTime = nil
                let updatedBatter = Batter(fields: updatedBatterInfo)

                let _ = try await PlayersController.shared.updatelevel(batter.id ?? "", with: updatedBatter)
            } catch {
                print("更新球員等級失敗: \(error)")
            }
        }
    }



}
