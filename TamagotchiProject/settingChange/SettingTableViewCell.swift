//
//  SettingTableViewCell.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    let fontAndBorderColor: UIColor = DafaultUISetting.fontAndBorderColor.setUI()
    
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTiltle: UILabel!
    @IBOutlet weak var username: UILabel!
    
   
    func setCellUI(image: String, title: String, name: String) {
        settingImage.image = UIImage(systemName: "\(image)")
        settingImage.tintColor = fontAndBorderColor
        
        settingTiltle.text = title
        settingTiltle.textColor = .black
        settingTiltle.font = .boldSystemFont(ofSize: 14)
        
        username.text = name
        username.textColor = fontAndBorderColor
        username.font = .systemFont(ofSize: 14)
        
    }
}
