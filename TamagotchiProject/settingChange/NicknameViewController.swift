//
//  NicknameViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

class NicknameViewController: UIViewController {
    let backgountdColor: UIColor = DafaultUISetting.tamaBackgroundColor.setUI()
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var sectionView: UIView!
    var username = "대장" // 초기값 및 바뀌는 닉네임을 담아줄 변수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(username, forKey: "username") // 키벨류 초기 세팅
        nicknameTextField.text = username // 텍스트필트에 유저네임을 나타나도록하기, 버튼을 클릭하면 변경된 유저네임을 넣어줌

        view.backgroundColor = backgountdColor
        
        nicknameUI()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(goSettingView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save))
    }
   
    @objc
    func goSettingView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func save() {
        guard let text = nicknameTextField.text, !text.isEmpty, (2...6).contains(text.count) else {
            self.view.makeToast("이 이름은 쓸 수 없습니다 ㅇㅅㅇ", duration: 1, position: .center)
            return
        }
        
        // 저장버튼을 누르면 유저네임에 텍스트 필드에 입력된 값을 넣어줌
        username = nicknameTextField.text!
//        UserDefaults.standard.value(forKey: "username") as! String //* 다른방법 타입캐스팅
        UserDefaults.standard.set(username, forKey: "username") // 변경된 값을 다시 넣어줌
        print(username)
        self.navigationController?.popViewController(animated: true)
    }
    
    func nicknameUI() {
        containView.backgroundColor = .clear
        
        nicknameTextField.borderStyle = .none
        nicknameTextField.font = .systemFont(ofSize: 14)
        nicknameTextField.textColor = DafaultUISetting.fontAndBorderColor.setUI()
        nicknameTextField.backgroundColor = .clear
        
        sectionView.backgroundColor = DafaultUISetting.fontAndBorderColor.setUI()
    }
}
