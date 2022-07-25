//
//  NicknameTableViewCell.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

class NicknameTableViewCell: UITableViewCell {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var sectionView: UIView!
    
    func nicknameUI() {
        containView.backgroundColor = .clear
        nicknameTextField.borderStyle = .none
        nicknameTextField.font = .systemFont(ofSize: 14)
        nicknameTextField.textColor = DafaultUISetting.fontAndBorderColor.setUI()
        nicknameTextField.backgroundColor = .clear
        
        sectionView.backgroundColor = DafaultUISetting.fontAndBorderColor.setUI()
        
    }
}
