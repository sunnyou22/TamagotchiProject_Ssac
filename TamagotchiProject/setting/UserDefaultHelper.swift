//
//  UserDefaultHelper.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/08/01.
//

import Foundation

class UserDefaultHelper {
    
    static let shared = UserDefaultHelper()
    let userDefaultHelper = UserDefaults.standard
    
    enum Key: String {
        case UserTamagotchiName
        case UserTamagotchImageNumber
        case riceCount
        case waterCount
        case buttonClick
        case currentImageName
        case level
        case username
        case clickedStartButton
        case changeTamagotchi
        
    }
    
    
}
