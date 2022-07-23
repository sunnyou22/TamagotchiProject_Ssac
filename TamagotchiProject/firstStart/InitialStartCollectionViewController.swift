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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "InitialStart", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailPopoverViewController.identifier) as! DetailPopoverViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .overCurrentContext
        nav.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
  
        
        present(nav, animated: true)
        
        navigationItem.title = "다마고치 선택하기"
    }
}
