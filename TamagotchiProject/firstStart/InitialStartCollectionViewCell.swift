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
    
    func configureCell(imageNumber: Int) {
        let textAndBoderColor: UIColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        let backgroundColor: UIColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        //MARK: labelViewUI
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 10
        labelView.layer.borderColor = textAndBoderColor.cgColor
        labelView.layer.borderWidth = 1.5
        labelView.layer.backgroundColor = UIColor.clear.cgColor
        
        //MARK: staticImage
        if imageNumber < 4 {
        staticImage.image = UIImage(named: "\(imageNumber)-6")
        } else {
            staticImage.image = UIImage(named: "noImage")
        }
        
    //MARK: staticLabel
        staticName
        
    }
}
