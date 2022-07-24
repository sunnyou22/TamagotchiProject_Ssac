//
//  TamagotchiInfo.swift
//  TamagotchiProject
//
//  Created by 방선우 on 2022/07/23.
//

import Foundation

// 유저 이름 넣어주기
struct Tamagotchi {
    var name: String
    var username: String = "대장"
    var description: String
    var imageNumber: Int
   
}

struct TamagotchiInfo {
    let Tamagotchis: [Tamagotchi] = [
        Tamagotchi(name: "따끔따끔 다마고치", description: "저는 선인장 다마고치 입니다.\n키는 2cm 몸무케는 150g이에요\n성격은 소심하지만 마음은 따듯해요\n열심히 잘 먹고 잘 클 자신있답니다.\n반가워요 주인님!!!!", imageNumber: 1),
        Tamagotchi(name: "방실방실 다마고치", description: "저는 방실방실 다마고치입니당\n키는 100km 몸무게는 150t에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신 있답니당 방실방실~", imageNumber: 2),
        Tamagotchi(name: "반짝반짝 다마고치", description: "저는 반짝반짝 다마고치 입니다.\n키는 1000km 몸무케는 비밀이에요(씽긋)\n성격은 낙천적이고 발랄하답니다 *_*\n열심히 잘 먹고 잘 클 자신있답니닷\n주인님과 잘 지내고 싶어요 *O*!", imageNumber: 3),
                  Tamagotchi(name: "준비중이에요", description: "준비중이에요", imageNumber: 0)
        ]
}
