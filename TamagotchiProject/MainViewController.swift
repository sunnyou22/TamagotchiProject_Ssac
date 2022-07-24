//
//  ViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/22.
//
import Toast
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
    var tamagotchiData: Tamagotchi = Tamagotchi(name: UserDefaults.standard.string(forKey: "UserTamagotchiName") ?? "아무개 다마고치", description: "", imageNumber: UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))
    
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
        
        
        //MARK: ButtonUI
        setButtonUI(buttonsStyle[0], title: "밥먹기", systemImage: "drop.circle")
        setButtonUI(buttonsStyle[1], title: "물먹기", systemImage: "leaf.circle")
        
        /*
         1. 밥먹기를 그냥 누르면 1씩 올라가고
         2. 텍스트 필드의 숫자 입력 -> 버튼 한번에 올라감
            2-1. 숫자만 입력 될 수 있게 만들기
         */
    }
    
    
    
    //MARK: - 메서드
    @IBAction func userTextFields(_ sender: UITextField) {
        sender.keyboardType = .numberPad
        guard let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty, Int(text) != nil else {
            ballonLabel.text = "으악 먹을 수 없는거에요ㅠㅠ"
            return self.view.makeToast("숫자로만 입력해주세요", duration: 0.8, position: .center)
        }
        ballonLabel.text = "~냠냠~"
    }
    
    //MARK: text UI세팅 메서드
    func setLableUI(_ label: UILabel) {
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = fontAndBorderColor
        label.textAlignment = .center
    }
    
    //MARK: textField UI세팅 메서드
    func setTextFieldUI(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .none
        textField.placeholder = placeholder
        textField.font = .boldSystemFont(ofSize: 14)
        textField.textColor = fontAndBorderColor
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
    }
    
    func setButtonUI(_ btn: UIButton, title: String, systemImage: String) {
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = fontAndBorderColor.cgColor
        btn.layer.borderWidth = 1.5
        btn.backgroundColor = .clear
        
        btn.setImage(UIImage(systemName: systemImage), for: .normal)
        btn.tintColor = fontAndBorderColor
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(fontAndBorderColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setInsets(forContentPadding: .init(top: 8, left: 8, bottom: 8, right: 8), imageTitlePadding: 4)
    }
    
    //MARK: 말풍선 대사 랜덤 추출
    func randomlabelInballoon() -> String {
        var labels: [String] = []
        let username = tamagotchiData.username
        
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

