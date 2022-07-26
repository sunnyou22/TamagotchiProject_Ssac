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
    var sample = "대장"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let defaultName = UserDefaults.standard.string(forKey: "")
//        nicknameTextField.text = "대장"
        
        
        
        UserDefaults.standard.set(sample, forKey: "username")
        nicknameTextField.text = sample
//        UserDefaults.standard.set(sample, forKey: "username")
        
        view.backgroundColor = backgountdColor
        
        nicknameUI()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(goSettingView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        sample = nicknameTextField.text!
//        UserDefaults.standard.value(forKey: "username") as! String //* 다른방법
        UserDefaults.standard.set(sample, forKey: "username")
        print(sample)
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
