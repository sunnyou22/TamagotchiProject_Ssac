//
//  defaultUISetting.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/24.
//

import Foundation
import UIKit

//MARK: 버튼기능 확장 -> 이후 수정필요
extension UIButton {
    func setInsets(forContentPadding contentPadding: UIEdgeInsets, imageTitlePadding: CGFloat?) {
        
        if let imageTitlePadding = imageTitlePadding {
            
            self.contentEdgeInsets = UIEdgeInsets(
                top: contentPadding.top,
                left: contentPadding.left,
                bottom: contentPadding.bottom,
                right: contentPadding.right + imageTitlePadding
            )
            self.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: imageTitlePadding,
                bottom: 0,
                right: -imageTitlePadding
            )
        } else {
            self.contentEdgeInsets = UIEdgeInsets(
                top: contentPadding.top,
                left: contentPadding.left,
                bottom: contentPadding.bottom,
                right: contentPadding.right
            )
        }
    }
}

struct TamagotchoColor {
    static let fontAndBorderColor: UIColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    static let tamaBackgroundColor: UIColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
}
