//
//  DetailPopoverViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/23.
//

import UIKit

class DetailPopoverViewController: UIViewController {
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var tamagochName: UILabel!
    @IBOutlet weak var tamagochiInfoLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var buttonSection: UIView!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    //MARK: 값 받을 공간 - 값이 없을 수도 있으니 옵셔널
    var tamagotchiData: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultImage.image = UIImage(named: "\(String(describing: tamagotchiData!.imageNumber))-6")
        
        //MARK: text
        tamagochName.text = tamagotchiData?.name
        tamagochName.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        tamagochName.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        tamagochiInfoLabel.text = tamagotchiData?.description
        tamagochiInfoLabel.numberOfLines = 0
        tamagochiInfoLabel.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        tamagochiInfoLabel.font = UIFont.systemFont(ofSize: 15)
        tamagochiInfoLabel.textAlignment = .center
        
        
        //MARK: 배경색
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        popView.clipsToBounds = true
        popView.layer.cornerRadius = 5
        popView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 5
        labelView.layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
        labelView.layer.borderWidth = 1
        labelView.backgroundColor = .clear
        
        sectionView.backgroundColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        
        //MARK: Button 스타일
        buttonSection.backgroundColor = .lightGray
        cancleButton.setTitle("취소", for: .normal)
        cancleButton.setTitleColor(UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1), for: .normal)
        cancleButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        cancleButton.tintColor = .lightGray
        if UserDefaults.standard.bool(forKey: "changeTamagotchi") {
            startButton.setTitle("변경하기", for: .normal)
        } else {
            startButton.setTitle("시작하기", for: .normal)
        }
     
        startButton.setTitleColor(UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1), for: .normal)
        startButton.tintColor = .lightGray
    }
    
    @IBAction func cancleButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        // 화면분기처리를 위한 버튼 클릭 상태 저장
        UserDefaults.standard.set(sender.isTouchInside, forKey: "clickedStartButton")
        UserDefaults.standard.set(tamagotchiData?.name, forKey: "UserTamagotchiName")
        UserDefaults.standard.set(tamagotchiData?.imageNumber, forKey: "UserTamagotchImageNumber")
        
        // 화면 초기화
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MainViewController.reuseIdentifier) as! MainViewController
        let nav = UINavigationController(rootViewController: vc)
//        vc.tamagotchiData = tamagotchiData -> UserDefault로 저장해서 필요없음
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

