# 다마고치 키우기 👾

## 프로젝트 설명
다마고치에게 밥알과 물을 줘서 레벨업을 해보자

- 선택하기 화면
  - 선택하기 화면에서 원하는 다마고치를 선택한다.
  - 다마고치를 선택하면 앱의 초기화면이 메인화면으로 바뀐다.
- 메인화면
  - 텍스트 필드가 비어있을 때 밥먹기 물먹기 버튼을 누르면 +1 씩 먹을 수 있다.
  - 반면 텍스트 필드에 먹이고 싶은 갯수를 기입하면 그 만큼 먹는다. 단 일정수준 이상의 밥알과 물은 한 번에 먹을 수 없다.
  - 다마고치의 말풍선은 앱을 켰을 때, 무언가를 먹을 때만 바뀐다.
- 설정창
  - 유저 네임을 바꿀 수 있다. 기본네임은 "대장"이다. 
      - 이름은 2글자 이상 6글자 이하이다.
      - 유저 네임은 메인화면 타이틀, 네임화면 말풍선, 설정창에서 유지된다.
  - 다마고치를 변경할 수 있는데 캐릭터를 변경할 뿐 데이터는 유지된다.
  - 다마고치 게임을 초기화 할 수 있다. 데이터가 초기화 된다. 

## 개발 환경
- iOS15로 설정 / 아이패드 고려 안함
- MacBook Air (M1, 2020)
- Language : swift
- Framwork : UIKit, Foundation
- Add Library : [Toast](https://github.com/scalessec/Toast-Swift)

## 폴더 구성 및 화면구성
### InitialStart
- InitialStart : 초기화면 및 팝업화면 스토리보드
- InitialStartCollectionViewController : 초기 다마고치 선택화면
-  InitialStartCollectionViewCell : 선택화면에 대한 cell
- DetailPopoverViewController : 선택이후 다마고치 팝업화면(시작하기버튼 및 취소)
- TamagotchiIData : 다마고치에 대한 기본정보를 담은 
### main
- 메인화면을 위한 스토리보드 및 뷰컨
### settingChange
- Setting : 설정창 스토리보드 및 유저네임 변경화면
- NicknameViewController : 이름변경 화면
- SettingTableViewController : 설정화면 
### 화면구성
<img src="https://drive.google.com/uc?export=view&id=1jjZIpDnbj9-szkf4PdhBJkX3SOKuiwgP" width="500" height="220">

---

## 트러블 슈핑(개인 fix)

### 설정창에서 셀 클릭시 스토리보드상 셀의 이미지 나오는 것
<img src="https://drive.google.com/uc?export=view&id=1_yx8jAGHmc5qr_LlC9ymyP2XYRqVcJzC">

- 셀에 클릭이 생기고 상태가 바뀌는데 reload를 걸어주지 않아 스토리보드상의 UI가 계속 보이는 것이었다.
처음에는 아래처럼 전체 셀에 reload를 걸어줬다. 하지만 해당 뷰에서 클릭이 발생하여 alert창이 떠있을 때는 viewWillAppear가 실행되지 않았는데 셀의 상태가 변경됐으므로  
alert창이 떠있을 때 스토리보드상의 셀UI가 나타난다. 때문에 두번째 코드블럭처럼 작성해야 셀의 모든 상태 변화에 대응할 수 있다. 
```
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData() // 변경한 값으로 바꿔주고 싶으면 무족건....
        //        print(#function)
    }
```

```
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        // cell을 선언해주지 않고 변경하기 버튼을 누른 상태를 저장해주려면?
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
```
- 시점을 잘 파악하여 화면과 데이터변화를 연결시켜주자.

### 자잘한 부분
- 변경하기 버튼을 누르고 다마고치를 변경하면 레벨이 처음 로드됐을 때 1로 변함 -> level, lavel 섞어서 사용하여 초기값이 고정값으로 들어가는 등..
- 셀의 상태가 바뀔 때마다(클릭도 포함) reload필수 -> 전체를 reload할 지 부분적인 cell을 reload해줄지 따져서 효율적으로 재세팅해줘야함
- root뷰는 처음 로드될 때 이후로 viewWillAppear이기 때문에 시점을 잘 파악해야한다.
- 디버깅 (breakPoint) 및 print문으로 실행 시점을 알기 좋음
- cellRowAt과 didSelectRowAt은 한 셀마다 적용되는 것이니까 cell 전체에 적용할 코드가 없다면 그냥 index로 해줘도 괜찮다
- 무언가 안 바뀔 때는 시점이 맞는지, 고정값으로 어디에 해두지 않았는지 확인하기 -> 유저이름이 안 바뀌는 문제
- 클릭 뒤 셀이 회색인 이유는 오류가 아니라 선택된 상태를 의미하는 거였다 -> 먼저 속성값이 의도한 대로 맞춰져있는지 확인하자
    `cell.setSelected(false, animated: false)` 이거 작성해주면 됨
---
# 다마고치 소회
## 과제 기한이 끝났는데 나는 끝나지 않은. 
과제를 하면서 이걸 내가 해결할 수 있을까...하다가 몇시간뒤에 어찌어찌 해결하는 상황의 반복이었다.  
점점 일단 빌드가 되게만 하자라는 마인드로 임하게됐다.  
### 과제를 하면서 힘든점은
- 뷰가 로드되는 순서를 맞추는게 힘들었다(분명 나와야하는데 다른 뷰가 덮어버리는 등)
- 마지막 설정창에서 백버튼을 누르면 설정 셀이 계속 태초의 상태로 돌아온다 그리고 다시
셀을 터치하면 스레드가 "너 인덱스가 안맞아~"라는데 아직 찾지 못했다.
- 변수를 선언할 때 클래스의 프로퍼티로 해야할 지, 함수내에 선언하는게 나은지 고민스러웠다.
- 네비게이션을 많이 연결하니까 머리속에서 구조가 꼬여 얼마나 스택에서 쌓이고 있는지 감이 안왔다.

### 좋은 점
- 오토레이아웃을 아직도 힘들어하는데 많이 빨라졌다. 3시간이 1시간 된정도..?
나는 아이팟터와 아이패드도 프리뷰를 해서 살펴보는 편인데 뷰 객체간의 의존과 디바이스와의 의존을 잘 지정해야할 것 같다.  
지금 오토레이아웃도 살짝 자기 멋대로이다.
- 화면전환을 이해했다. 이해가 될 수 밖에 없는 시간이었다.
- 많은 메서드를 살펴봤던 것 같다. "이걸 애플이 안 줬을리가 없어, 이걸 사람들이 안 쓸까?"하면서 메서드를 꼼꼼하게
꽤 살펴봤다. 하지만 내 생각과 다른게 90프로정도..ㅎ 

리팩토링하면서 또 나를 많이 원망할 것 같다 내 뇌와 손구락 반성해...  

_궁금한 점과 과제 설계 및 과정 추가 작성예정_



