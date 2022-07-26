//
//  SettingTableViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

class SettingTableViewController: UITableViewController {
    let fontAndBorderColor: UIColor = DafaultUISetting.fontAndBorderColor.setUI()
    let backgrountColor: UIColor = DafaultUISetting.tamaBackgroundColor.setUI()
//    var newname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgrountColor

        navigationController?.navigationBar.tintColor = fontAndBorderColor

        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : fontAndBorderColor]
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = backgrountColor
        navigationItem.scrollEdgeAppearance = barAppearance
        
        //        navigationItem.backButtonTitle = ""
        //        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(goMainViewController))
        //        navigationItem.leftBarButtonItem?.tintColor = fontAndBorderColor
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData() // 무족건....
        print(#function)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        cell.backgroundColor = backgrountColor
        cell.separatorInset = .zero
    
        //생명주기로 고민해보기(스레드오류)
        switch indexPath.row {

        case 0:
            cell.setCellUI(image: "pencil", title: "내 이름 설정하기", name: UserDefaults.standard.string(forKey: "username")!)
        case 1:
            cell.setCellUI(image: "moon.fill", title: "다마고치 변경하기", name: "")
        case 2:
            cell.setCellUI(image: "arrow.clockwise", title: "데이터 초기화", name: "")
        default: cell.setCellUI(image: "xmark", title: "미지정셀입니다.", name: "")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        

        
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "NicknameViewController") as! NicknameViewController
//            newname = vc.newName
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let sb = UIStoryboard(name: "InitialStart", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "InitialStartCollectionViewController") as! InitialStartCollectionViewController
            let nav = UINavigationController(rootViewController: vc)
            self.navigationController?.pushViewController(vc, animated: true)
            
//            UserDefaults.standard.set(cell, forKey: "changeTamagotchi")
            
            vc.navigationItem.title = "다마고치 변경하기"
            nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action:  #selector(goMainViewController))
        } else if indexPath.row == 2 {
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", preferredStyle: .alert)
            let cancle = UIAlertAction(title: "아냐!", style: .cancel)
            let ok = UIAlertAction(title: "웅", style: .default) {_ in
            
                UserDefaults.standard.removeObject(forKey: "clickedStartButton")
                UserDefaults.standard.removeObject(forKey: "UserTamagotchiName")
                UserDefaults.standard.removeObject(forKey: "UserTamagotchImageNumber")
                UserDefaults.standard.removeObject(forKey: "changeTamagotchi")
                UserDefaults.standard.set(1, forKey: "lavel")
                UserDefaults.standard.removeObject(forKey: "riceCount")
                UserDefaults.standard.removeObject(forKey: "waterCount")
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.removeObject(forKey: "currentImageName")
                
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDeleate = windowScene?.delegate as? SceneDelegate
            let sb = UIStoryboard(name: "InitialStart", bundle: nil)
            let vc  = sb.instantiateViewController(withIdentifier: "InitialStartCollectionViewController") as! InitialStartCollectionViewController
            let nav = UINavigationController(rootViewController: vc)
                
                //샤라락 화면 전환 왜 안될까
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .crossDissolve
                
            sceneDeleate?.window?.rootViewController = nav
            sceneDeleate?.window?.makeKeyAndVisible()
            }
                alert.addAction(cancle)
                alert.addAction(ok)
            present(alert, animated: true)
        } else {
            print("오류입니다")
        }
    }

@objc
func goMainViewController() {
    self.navigationController?.popViewController(animated: true)
}
}
