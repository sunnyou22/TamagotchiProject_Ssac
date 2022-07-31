//
//  SettingTableViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        cell.backgroundColor = TamagotchoColor.tamaBackgroundColor
        cell.separatorInset = .zero
        cell.setSelected(false, animated: false)
        cell.selectionStyle = .none
        
        //생명주기로 고민해보기(스레드오류)
        switch indexPath.row {
        case 0:
            // 처음실행했을 때는 username에 아무값도 없으니까 "대장"으로 실행
            cell.setCellUI(image: "pencil", title: "내 이름 설정하기", name: UserDefaults.standard.string(forKey: "username") ?? "대장")
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
        // cell을 선언해주지 않고 변경하기 버튼을 누른 상태를 저장해주려면?
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "NicknameViewController") as! NicknameViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let sb = UIStoryboard(name: "InitialStart", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "InitialStartCollectionViewController") as! InitialStartCollectionViewController
            let nav = UINavigationController(rootViewController: vc)
            self.navigationController?.pushViewController(vc, animated: true)
            
            // 다마고치 바꿔주기
            UserDefaults.standard.set(cell.isSelected, forKey: "changeTamagotchi")
            
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
                UserDefaults.standard.set(1, forKey: "level")
                UserDefaults.standard.removeObject(forKey: "riceCount")
                UserDefaults.standard.removeObject(forKey: "waterCount")
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.removeObject(forKey: "currentImageName")
                
                
                //MARK: 초기화로 구현
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
