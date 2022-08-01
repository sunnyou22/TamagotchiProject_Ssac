//
//  InitialStartCollectionViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/23.
//

import UIKit
import Toast

class InitialStartCollectionViewController: UICollectionViewController {
    //MARK: 값을 보내기 위한 프로퍼티
    var tamagotchiInfo = TamagotchiInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "changeTamagotchi") {
            navigationItem.title = "다마고치 변경하기"
        } else {
            navigationItem.title = "다마고치 선택하기"
        }
        
        // 초기화면으로 씬에서 지정하면 나타날 거임
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width:  width / 3.2, height: (width / 2.8) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        collectionView.collectionViewLayout = layout
        requestAuthorization()
    }
    
    //MARK: 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //MARK: 셀 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InitialStartCollectionViewCell.reuseIdentifier, for: indexPath) as! InitialStartCollectionViewCell
        
        cell.configureCell(index: indexPath.row)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row < 3 {
            let sb = UIStoryboard(name: "InitialStart", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: DetailPopoverViewController.reuseIdentifier) as! DetailPopoverViewController
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .overCurrentContext
            present(nav, animated: true)
            
            vc.tamagotchiData = tamagotchiInfo.Tamagotchis[indexPath.row]
        } else {
            let alert = UIAlertController(title: "알림", message: "아직 준비중입니다ㅠ△ㅠ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
}

//MARK: 노티 프로토콜 만들어서 체크
extension InitialStartCollectionViewController: SetNotification {

    var notificationCenter: UNUserNotificationCenter {
        return UNUserNotificationCenter.current()
    }
    
    var triggerTime: UNTimeIntervalNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
    }
    
    func requestAuthorization() {
        let authorixationOption = UNAuthorizationOptions(arrayLiteral: .alert, .sound , .badge)
        notificationCenter.requestAuthorization(options: authorixationOption) { success, error in
            if success {
                self.sendNotification()
            } else {
                print("ERROR")
            }
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        let request: UNNotificationRequest = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: triggerTime)
        var count: Int = 0
        
        var pulsTrigger: Int {
            if triggerTime.repeats {
                count += 1
                return count
            } else {
                return count
            }
        }
        
        notificationContent.title = "다마고치 키우기\(Int.random(in: 1...100))" // 어떤 다마고치인지 값전달 해보기
        notificationContent.subtitle = "냠냠"
        notificationContent.body = "대장님 오늘 저한테 밥을 주셨나요??" // 대장님 이름 받아오기
        notificationContent.badge = (pulsTrigger) as NSNumber
        
        notificationCenter.add(request) // ERROR관리하기
        
    }
}

