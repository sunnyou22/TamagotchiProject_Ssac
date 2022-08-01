//
//  SettingTableViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

enum SettingOption: Int, CaseIterable {
    case setUsername, changeTamagotchi, resetGame
    
    var cellTitle: String {
        switch self {
        case .setUsername:
            return "내 이름 설정하기"
        case .changeTamagotchi:
            return "다마고치 변경하기"
        case .resetGame:
            return "데이터 초기화"
        }
    }
    
    var image: String {
        switch self {
        case .setUsername:
            return "pencil"
        case .changeTamagotchi:
            return "moon.fill"
        case .resetGame:
            return "arrow.clockwise"
        }
    }
    var username: String {
        switch self {
        case .setUsername:
            return UserDefaults.standard.string(forKey: "username") ?? "대장"
        case .changeTamagotchi:
            return ""
        case .resetGame:
            return ""
        }
    }
    
}

class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TamagotchoColor.tamaBackgroundColor
        navigationItem.title = "설정"
        
        
        // 한방에 네비게이션 바 색깔 지정방법
        navigationController?.navigationBar.tintColor = TamagotchoColor.fontAndBorderColor
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : TamagotchoColor.fontAndBorderColor]
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = TamagotchoColor.tamaBackgroundColor
        navigationItem.scrollEdgeAppearance = barAppearance
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        print(#function)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOption.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = TamagotchoColor.tamaBackgroundColor
        cell.separatorInset = .zero
        cell.setSelected(false, animated: false)
        cell.selectionStyle = .none
        
        cell.setCellUI(image: SettingOption.allCases[indexPath.row].image, title: SettingOption.allCases[indexPath.row].cellTitle, name: SettingOption.allCases[indexPath.row].username)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: NicknameViewController.reuseIdentifier) as? NicknameViewController else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let clickedCell: Bool = true
            let sb = UIStoryboard(name: "InitialStart", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: InitialStartCollectionViewController.reuseIdentifier) as? InitialStartCollectionViewController else { return }
            let nav = UINavigationController(rootViewController: vc)
            self.navigationController?.pushViewController(vc, animated: true)
            
            UserDefaults.standard.set(clickedCell, forKey: "changeTamagotchi")
            
            nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action:  #selector(goMainViewController))
            
        } else if indexPath.row == 2 {
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", preferredStyle: .alert)
            let cancle = UIAlertAction(title: "아냐!", style: .cancel)
            let ok = UIAlertAction(title: "웅", style: .default) {_ in
                
                UserDefaults.standard.removeObject(forKey: "clickedStartButton")
                UserDefaults.standard.removeObject(forKey: "UserTamagotchiName")
                UserDefaults.standard.removeObject(forKey: "UserTamagotchImageNumber")
                UserDefaults.standard.removeObject(forKey: "changeTamagotchi")
                UserDefaults.standard.set(1, forKey: "level")
                UserDefaults.standard.removeObject(forKey: "riceCount")
                UserDefaults.standard.removeObject(forKey: "waterCount")
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.removeObject(forKey: "currentImageName")
                
                
                //MARK: 초기화로 구현
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDeleate = windowScene?.delegate as? SceneDelegate
                let sb = UIStoryboard(name: "InitialStart", bundle: nil)
                guard let vc  = sb.instantiateViewController(withIdentifier: InitialStartCollectionViewController.reuseIdentifier) as? InitialStartCollectionViewController else { return }
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
