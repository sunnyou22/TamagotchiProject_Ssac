//
//  defaultUISetting.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/24.
//

import Foundation
import UIKit

enum DafaultUISetting {
    case fontAndBorderColor, tamaBackgroundColor
    
    func setUI() -> UIColor {
        switch self {
        case .fontAndBorderColor:
            return UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        case .tamaBackgroundColor:
            return UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        }
    }
}
