//
//  MainSetting.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/08/01.
//

import Foundation

enum ButtonKey: Int {
    case riceCount, waterCount
    
    var buttonUserDefaultsName: String {
        switch self {
        case .riceCount:
           return "riceCount"
        case .waterCount:
           return "waterCount"
        }
    }
}
