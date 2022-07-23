//
//  InitialStartCollectionViewCell.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/23.
//

import UIKit

class InitialStartCollectionViewCell: UICollectionViewCell {
    static let identifier = "InitialStartCollectionViewCell"
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var staticImage: UIImageView!
    @IBOutlet weak var staticName: UILabel!
    
    func configureCell(index: Int) {
        let textAndBoderColor: UIColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        let tamagochi: TamagochiInfo = TamagochiInfo()
        
        //MARK: labelViewUI
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 5
        labelView.layer.borderColor = textAndBoderColor.cgColor
        labelView.layer.borderWidth = 1.5
        labelView.layer.backgroundColor = UIColor.clear.cgColor
        staticName.backgroundColor = UIColor.clear
        staticName.textColor = textAndBoderColor
        staticName.font = UIFont.boldSystemFont(ofSize: 13)
        
        if index < 3 {
            //MARK: staticImage
            staticImage.image = UIImage(named: "\(tamagochi.Tamagochis[index].imageNumber)-6")
            
            //MARK: staticLabel
            staticName.text = tamagochi.Tamagochis[index].name
        } else {
            staticName.text = "준비중이에요"
            staticImage.image = UIImage(named: "noImage")
        }
    }
}
