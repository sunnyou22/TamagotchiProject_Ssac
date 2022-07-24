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
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet var buttonsStyle: [UIButton]!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet var textFieldSectionViews: [UIView]!
    
    // 값전달
    var tamagotchiData: Tamagotchi?
    let fontAndBorderColor = DafaultUISetting.fontAndBorderColor.setUI()
    let viewbackgroundColor = DafaultUISetting.tamaBackgroundColor.setUI()
    
    override func viewWillAppear(_ animated: Bool) {
        ballonLabel.text = randomlabelInballoon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lavel: Int = 5 // 이미지별로 다른 거 확인
        var riceCount: Int
        var waterDropCount: Int
        
        //MARK: view
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        //MARK: 이미지
        image.image = UIImage(named: "\(UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))-\(lavel)")
        print(UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))
        
        //MARK: label
        tamagotchiName.text = UserDefaults.standard.string(forKey: "UserTamagotchiName")
        setLableUI(ballonLabel)
        setLableUI(tamagotchiName)
        setLableUI(tamagotchiStatus)
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 5
        labelView.layer.borderColor = fontAndBorderColor.cgColor
        labelView.layer.borderWidth = 1
        labelView.backgroundColor = .clear
        
        //MARK: Textfeild
        setTextFieldUI(riceTextField, placeholder: "밥주세용")
        setTextFieldUI(waterTextField, placeholder: "물주세용")
        textFieldSectionViews[0].backgroundColor = fontAndBorderColor
        textFieldSectionViews[1].backgroundColor = fontAndBorderColor
    }
    
    //MARK: text UI 속성
    func setLableUI(_ label: UILabel) {
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = fontAndBorderColor
        label.textAlignment = .center
    }
    
    func setTextFieldUI(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .none
        textField.placeholder = placeholder
        textField.font = .boldSystemFont(ofSize: 14)
        textField.textColor = fontAndBorderColor
        textField.textAlignment = .center
    }
    
    //MARK: 말풍선 대사 랜덤 추출
    func randomlabelInballoon() -> String {
        var labels: [String] = []
        guard let username = tamagotchiData?.username else {
            return "누구시죠!!?"
        }
        labels = [
            "\(username)님 반가워요!",
            "\(username)님 잘 지내셨나요?",
            "\(username)님 오늘 킷허브 푸시 하셨나영?",
            "복습은 당연히 하고 오셨겠찌요? 그렇죠? \(username)님?",
            "테이블뷰컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?",
            "오늘은 왠지 기분이 좋네요! ㅎ_ㅎ"
        ]
        
        return labels.randomElement() ?? "오류입니다. 죄송합니다."
    }
}

