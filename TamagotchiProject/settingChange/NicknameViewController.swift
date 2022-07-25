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
//    var defaultname = "대장"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgountdColor
        nicknameUI()
        nicknameTextField.text = UserDefaults.standard.string(forKey: "username")
        //초기이름 대장이라고 어떻게 설정할까
//        if let text = UserDefaults.standard.string(forKey: "username"), text == "" {
//            nicknameTextField.text = defaultname
//        } else {
//        nicknameTextField.text = UserDefaults.standard.string(forKey: "username")
//        }
        
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
            return self.view.makeToast("이 이름은 쓸 수 없습니다 ㅇㅅㅇ", duration: 1, position: .center)
        }
        UserDefaults.standard.set(text, forKey: "username")
        
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
