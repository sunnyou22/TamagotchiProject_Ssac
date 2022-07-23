//
//  InitialStartCollectionViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/23.
//

import UIKit

class InitialStartCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sb = UIStoryboard()
        let vc = sb.instantiateViewController(withIdentifier: "InitialStartCollectionViewController") as! InitialStartCollectionViewController
        let nav = UINavigationController(rootViewController: vc) // 씬딜리게이트에서 초기화면 지정할 때 바꾸기
        
        nav.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width:  width / 3, height: width / 2.8)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        
        
        collectionView.collectionViewLayout = layout
    }
    
    //MARK: 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //MARK: 셀 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InitialStartCollectionViewCell.identifier, for: indexPath) as! InitialStartCollectionViewCell
        
        cell.configureCell(index: indexPath.row)
        
        
        
        return cell
    }
    
    
}
