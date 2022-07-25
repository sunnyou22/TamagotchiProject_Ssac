//
//  NicknameViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/25.
//

import UIKit

class NicknameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let backgountdColor: UIColor = DafaultUISetting.tamaBackgroundColor.setUI()
    @IBOutlet weak var nameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgountdColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(goSettingView))
    }
    
    @objc
    func goSettingView() {
        self.navigationController?.popViewController(animated: true)
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NicknameTableViewCell") as! NicknameTableViewCell
        
        cell.nicknameUI()
        cell.separatorInset = .zero
        
        return cell
    }
}
