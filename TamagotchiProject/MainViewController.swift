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
    
    var lavel: Int = 1 // 이미지별로 다른 거 확인
    var riceCount = 0
    var waterDropCount = 0
    let fontAndBorderColor = DafaultUISetting.fontAndBorderColor.setUI()
    let viewbackgroundColor = DafaultUISetting.tamaBackgroundColor.setUI()
    
    override func viewWillAppear(_ animated: Bool) {
        ballonLabel.text = randomlabelInballoon()
    }
    
    @IBAction func clickedEatRiceButton(_ sender: UIButton) {
        let ricecurrentValue = UserDefaults.standard.integer(forKey: "riceCount")
        var riceupdateValue = 0
        
        guard let riceTextField = riceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return }
        
        //MARK: 쌀
        if riceTextField.isEmpty {
            riceupdateValue = ricecurrentValue + 1
            UserDefaults.standard.set(riceupdateValue, forKey: "riceCount")
            print(riceCount, "ricecount")
        } else {
            guard !riceTextField.isEmpty, let riceTextcount = Int(riceTextField) else {
                return ballonLabel.text = "으악 먹을 수 없는거에요ㅠㅠ"
            }
            riceupdateValue = ricecurrentValue + riceTextcount
            UserDefaults.standard.set(riceupdateValue, forKey: "riceCount")
            print(riceCount)
        }
    }
    
    @IBAction func clicedwaterButton(_ sender: UIButton) {
        let watercurrentValue = UserDefaults.standard.integer(forKey: "waterCount")
        var waterupdateValue = 0
        
        guard let waterTextField = waterTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return }
        
    //MARK: 물
    if waterTextField.isEmpty {
            waterupdateValue = watercurrentValue + 1
            UserDefaults.standard.set(waterupdateValue, forKey: "waterCount")
            print(waterDropCount, "waterDropCount")
        } else {
            guard !waterTextField.isEmpty, let waterTextcount = Int(waterTextField) else {
                return ballonLabel.text = "으악 먹을 수 없는거에요ㅠㅠ"
            }
            waterupdateValue = watercurrentValue + waterTextcount
            UserDefaults.standard.set(waterupdateValue, forKey: "waterCount")
            print(waterDropCount)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: view
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        // MARK: 계산하기
        let cumulation: Double = Double(UserDefaults.standard.integer(forKey: "riceCount") / 5) + Double(UserDefaults.standard.integer(forKey: "waterCount") / 5)
        
        UserDefaults.standard.integer(forKey: "lavel")
        
        switch cumulation {
        case 0..<10.0:
            UserDefaults.standard.set(1, forKey: "lavel")
        case 10.0..<20.0:
            UserDefaults.standard.set(2, forKey: "lavel")
        case 20.0..<30.0:
            UserDefaults.standard.set(3, forKey: "lavel")
        case 30.0..<40.0:
            UserDefaults.standard.set(4, forKey: "lavel")
        case 40.0..<50.0:
            UserDefaults.standard.set(5, forKey: "lavel")
        case 50.0..<60.0:
            UserDefaults.standard.set(6, forKey: "lavel")
        case 60.0..<70.0:
            UserDefaults.standard.set(7, forKey: "lavel")
        case 70.0..<80.0:
            UserDefaults.standard.set(8, forKey: "lavel")
        case 80.0..<90.0:
            UserDefaults.standard.set(9, forKey: "lavel")
        case 100.0...:
            UserDefaults.standard.set(10, forKey: "lavel")
        default:
            UserDefaults.standard.set(0, forKey: "lavel")
        }
        
        tamagotchiStatus.text = "LV\(UserDefaults.standard.integer(forKey: "lavel")) • 밥알\(UserDefaults.standard.integer(forKey: "riceCount"))개 • 물방울 \(UserDefaults.standard.integer(forKey: "waterCount"))개"
        
        ballonLabel.text = UserDefaults.standard.integer(forKey: "lavel") > 99 ? "토..할 것 가 타 요....ㅠ" : randomlabelInballoon()
        ballonLabel.text = UserDefaults.standard.integer(forKey: "riceCount") > 49 ? "물 배 빵빵 그만그만...!!!!" : randomlabelInballoon()
        
        //MARK: 이미지
        image.image = UIImage(named: "\(UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))-\(UserDefaults.standard.integer(forKey: "lavel"))")
        
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
         2-1. 숫자만 입력 될 수 있게 만들기 V
         3. 함수에 담아서 이미지보다 상위에 실행시켜야함 -> 더 간단하게 만들수 잇는 방법생각하기
         */
        
    }
    
    
    // MARK: - 메서드
    
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
            "음~냠냠~~~",
            "오늘은 왠지 기분이 좋네요! ㅎ_ㅎ",
            "\(username)님 배고파요ㅠㅜㅜ",
            "목말라요오~~!ㅠㅠ"
        ]
        
        return labels.randomElement() ?? "오류입니다. 죄송합니다."
    }
}

