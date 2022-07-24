//
//  ViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ballonLabel: UILabel!
    @IBOutlet weak var tamagotchiName: UILabel!
    @IBOutlet weak var tamagotchiStatus: UILabel!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var buttonsStyle: [UIButton]!
    
    
    // 값전달
    var tamagotchiData: Tamagochi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var username = tamagotchiData?.username
        let lavel: Int = 5 // 이미지별로 다른 거 확인
        var riceCount: Int
        var waterDropCount: Int
        var labelsInballoon: [String] = []
        
        //MARK: 말풍선 대사
        guard let username = username else {
            return
        }
        labelsInballoon = [
            "\(username)님 반가워요!",
            "\(username)님 잘 지내셨나요?",
            "토할 것 같아요 ㅠㅁㅠ",
            "\(username)님 오늘 킷허브 푸시 하셨나영?",
            "복습은 당연히 하고 오셨겠찌요? 그렇죠? \(username)님?",
            "테이블뷰컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?",
            "오늘은 왠지 기분이 좋네요! ㅎ_ㅎ"
        ]
        
        
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        
        
        
        
        image.image = UIImage(named: "\(String(describing: tamagotchiData!.imageNumber))-\(lavel)")
        
    }
    
    //MARK: text UI 속성
    func textSetting() {
       
    }
    
    
}

