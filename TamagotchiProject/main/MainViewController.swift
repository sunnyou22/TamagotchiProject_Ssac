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
    
    //MARK: 프로퍼티
    var tamagotchiData: Tamagotchi = Tamagotchi(name: UserDefaults.standard.string(forKey: "UserTamagotchiName") ?? "아무개 다마고치", description: "", imageNumber: UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))
    //    var level: Int = 1// 이미지별로 다른 거 확인
    var riceCount = 0
    var waterDropCount = 0
    let ricecount = UserDefaults.standard.integer(forKey: "riceCount") / 5
    let watercount = UserDefaults.standard.integer(forKey: "waterCount") / 5
    
    
    // MARK: 계산하기
    var cumulation: Double {
        Double(ricecount) + Double(watercount)
    }
    
    
    var level: Int {
        switch cumulation {
        case 0:
            return 1
        case 100...:
            return 10
        default: // cumulation % 10 가 안되는 이유로는
            return Int(cumulation.truncatingRemainder(dividingBy: 10.0) == 0 ? cumulation / 10 : (cumulation / 10) + 1)
        }
    }
    
    let fontAndBorderColor = DafaultUISetting.fontAndBorderColor.setUI()
    let viewbackgroundColor = DafaultUISetting.tamaBackgroundColor.setUI()
    var keyHeight: CGFloat = 0 // 키보드 높이 지정 변수?
    
    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let username = UserDefaults.standard.string(forKey: "username") ?? "대장" // 이후 유저디폴트로 바꿔주기
        
        navigationItem.title = "\(username)님의 다마고치"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(goSettingTableViewController))
        navigationItem.rightBarButtonItem?.tintColor = fontAndBorderColor
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : fontAndBorderColor]
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = DafaultUISetting.tamaBackgroundColor.setUI()
        navigationItem.scrollEdgeAppearance = barAppearance
        
        navigationItem.backButtonTitle = ""
        
        //MARK: 이미지
        // 이름도 이렇게 처리하면 되려나
        if UserDefaults.standard.bool(forKey: "buttonClick") {
            image.image = UIImage(named: UserDefaults.standard.string(forKey: "currentImageName") ?? "1-1")
        } else {
            image.image = UIImage(named: "\(UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))-1")
        }
        
        ballonLabel.text = randomlabelInballoon() // 랜덤 텍스트
        addKeyboardNotifications()
        
    }
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            keyHeight = keyboardHeight
            
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y += keyHeight
    }
    
    //MARK: - 버튼 클릭하는 메서드
    @IBAction func clickbuttons(_ sender: UIButton) {
        clickedEatButton(sender, textField: riceTextField)
        //        clickedEatButton(sender, textField: waterTextField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: view 배경색
        view.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        tamagotchiStatus.text =  "LV\(UserDefaults.standard.integer(forKey: "level")) • 밥알 \(UserDefaults.standard.integer(forKey: "riceCount"))개 • 물방울 \(UserDefaults.standard.integer(forKey: "waterCount"))개"
        
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
    }
    
    // 텍스트 필드가 비어있을 때 먹어야하는데...버그
    func clickedEatButton(_ button: UIButton, textField: UITextField) {
        let ricecurrentValue = UserDefaults.standard.integer(forKey: "riceCount")
        var riceupdateValue = 0
        let watercurrentValue = UserDefaults.standard.integer(forKey: "waterCount")
        var waterupdateValue = 0
        UserDefaults.standard.set(button.isTouchInside, forKey: "buttonClick")
        
        ballonLabel.text = randomlabelInballoon()
        
        if button.titleLabel?.text == "밥먹기" {
            if let textField = textField.text, textField.isEmpty {
                riceupdateValue = ricecurrentValue + 1
                UserDefaults.standard.set(riceupdateValue, forKey: "riceCount")
                print(riceCount, "ricecount")
            } else {
                if let textCount = Int(textField.text!), textCount < 100, textCount >= 0 {
                    riceupdateValue = ricecurrentValue + textCount
                    UserDefaults.standard.set(riceupdateValue, forKey: "riceCount")
                    print(riceCount)
                } else if let textCount = Int(textField.text!), textCount >= 100 {
                    ballonLabel.text = "토할것가타요오...ㅠㅠ"
                } else {
                    ballonLabel.text = "으악 먹을 수 없는거에요ㅠㅠ"
                }
            }
        } else {
            if let textField = textField.text, textField.isEmpty {
                waterupdateValue = watercurrentValue + 1
                UserDefaults.standard.set(waterupdateValue, forKey: "waterCount")
                print(waterDropCount, "watercount")
            } else {
                if let textCount = Int(textField.text!), textCount < 50, textCount >= 0 {
                    waterupdateValue = watercurrentValue + textCount
                    UserDefaults.standard.set(waterupdateValue, forKey: "waterCount")
                    print(waterDropCount)
                } else if let textCount = Int(textField.text!), textCount >= 50 {
                    ballonLabel.text = "물 그만그만이에요!!ㅜㅜㅜ"
                } else {
                    ballonLabel.text = "으악 먹을 수 없는거에요ㅠㅠ"
                }
            }
        }
        
        tamagotchiStatus.text = "LV\(level) • 밥알\(UserDefaults.standard.integer(forKey: "riceCount"))개 • 물방울 \(UserDefaults.standard.integer(forKey: "waterCount"))개"
        
        //MARK: 이미지
        let imageName = level == 1 ? "\(UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))-\(level))" : "\(UserDefaults.standard.integer(forKey: "UserTamagotchImageNumber"))-\(level - 1)"
        
        image.image = UIImage(named: imageName)
        UserDefaults.standard.set(imageName, forKey: "currentImageName")
    }
    
    // MARK: - 메서드
    
    @objc
    func goSettingTableViewController() {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
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
        let username = UserDefaults.standard.string(forKey: "username") ?? "대장"
        //        UserDefaults.standard.set(username, forKey: "username")
        
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
    
    /*
     @objc
     func keyboardWillShow(_ sender: Notification) {
     self.keyboardWillShow(sender)
     let userInfo: NSDictionary = sender.userInfo! as NSDictionary
     l
     self.view.frame.size.height -= keyboardHeight
     }
     
     @objc
     func keyboardWillHide(_ sender: Notification) {
     self.view.frame.size.height += keyHeight
     }
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.removeKeyboardNotifications()
    }
}


