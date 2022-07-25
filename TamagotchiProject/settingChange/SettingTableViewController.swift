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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgrountColor
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : fontAndBorderColor]
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = backgrountColor
        navigationItem.scrollEdgeAppearance = barAppearance
        
//        navigationItem.backButtonTitle = ""
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(goMainViewController))
//        navigationItem.leftBarButtonItem?.tintColor = fontAndBorderColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.backgroundColor = backgrountColor
        cell.separatorInset = .zero
        switch indexPath.row {
        case 0:
            cell.setCellUI(image: "pencil", title: "내 이름 설정하기", name: "유저디폴트")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "NicknameViewController") as! NicknameViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        
//        case 1:
//        let sb = UIStoryboard(name: "InitialStart", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "InitialStartCollectionViewController") as! InitialStartCollectionViewController
//            let nav = UINavigationController(rootViewController: vc)
//            self.navigationController?.pushViewController(vc, animated: true)
//            
//            UserDefaults.standard.set(cell.isSelected, forKey: "changeTamagotchi")
//                
//            vc.navigationItem.title = "다마고치 변경하기"
//            nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action:  #selector(goMainViewController))
//        default: 2
//        }
    }
    
    @objc
    func goMainViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
