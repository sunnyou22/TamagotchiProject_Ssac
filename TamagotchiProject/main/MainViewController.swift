//
//  ViewController.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/22.
//
 
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    // 값전달
    var tamagotchiData: Tamagochi?

    override func viewDidLoad() {
        super.viewDidLoad()
        let lavel: Int = 5 // 이미지별로 다른 거 확인
        var riceCount: Int
        var waterDrop: Int
        
        image.image = UIImage(named: "\(String(describing: tamagotchiData!.imageNumber))-\(lavel)")

    }


}

