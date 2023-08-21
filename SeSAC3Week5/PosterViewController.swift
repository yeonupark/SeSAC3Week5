//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


protocol CollectionViewAttributeProtocol { // 프로토콜은 선언만. 실질적인 내용은 채택하는 애들이 작성
    func configureCollectionView()
    func configureCollectionViewLayout()
}

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    var list: Recommendation = Recommendation(results: [], page: 0, totalPages: 0, totalResults: 0)
    var secondList = Recommendation(results: [], page: 0, totalPages: 0, totalResults: 0)
    var thirdList = Recommendation(results: [], page: 0, totalPages: 0, totalResults: 0)
    var fourthList = Recommendation(results: [], page: 0, totalPages: 0, totalResults: 0)
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        // 포그라운드에서 알림이 안뜨는게 디폴트. 백그라운드모드에서만 알림이 뜨는게 애플의 정책이다 -> appldelegate에서 설정 바꿈
        
        //1. 컨텐츠
        let content = UNMutableNotificationContent()
        content.title = "다마고치에게 물을 \(Int.random(in: 10...100))모금 주세요"
        content.body = "아직 레벨 3이에요. 물을 주세요!!"
        content.badge = 100
        
        // 2. 언제
        // 타임 인터벌
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // 캘린더 기반
        var component = DateComponents() // DateComponents 구조체가 미리 생성되어 있음
        component.hour = 10
        component.minute = 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        
        // -> 알림 보내 !
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = [976573,872585,13,634649]
        let group = DispatchGroup()
        
        for item in id {
            
            group.enter() //
            RecommendManager.shared.callRecommendation(id: item) { data in
                if item == 13 {
                    self.thirdList = data
                }
                group.leave() //
            }
        }
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
        }
        
//        for item in UIFont.familyNames {
//            print(item)
//            for name in UIFont.fontNames(forFamilyName: item) {
//                print("=== \(name) ===")
//            }
//        }
        
        // LottoManager().callLotto() // 인스턴스를 매번 생성하게 됨
        //LottoManager.shared.callLotto() // 타입 프로퍼티 사용
        
//        LottoManager.shared.callLotto { date, num in
//            print("클로저로 꺼내온 값: \(date), \(num)")
//        }

        // 뷰디드로드 최대한 간결하게 작업
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    func dispatchGroupEnterLeave() {
        let group = DispatchGroup()
        
        group.enter() // + 1 (작업이 하나 추가되었구나!)
        RecommendManager.shared.callRecommendation(id: 976573) { data in
            self.list = data
            print("1")
            group.leave() // -1 (작업 하나 완료 했구낭)
        }
        
        group.enter()
        RecommendManager.shared.callRecommendation(id: 872585) { data in
            self.secondList = data
            print("2")
            group.leave()
        }
        
        group.enter()
        RecommendManager.shared.callRecommendation(id: 13) { data in
            self.thirdList = data
            print("3")
            group.leave()
        }
        
        group.enter()
        RecommendManager.shared.callRecommendation(id: 634649) { data in
            self.fourthList = data
            print("4")
            group.leave()
        }
        group.notify(queue: .main){
            print("5")
            self.posterCollectionView.reloadData()
        }
    }
    
    func dispatchGroupNotify() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group){
            RecommendManager.shared.callRecommendation(id: 976573) { data in
                self.list = data
                print("1")
            }
        }
        
        DispatchQueue.global().async(group: group){
            RecommendManager.shared.callRecommendation(id: 872585) { data in
                self.secondList = data
                print("2")
            }
        }
        
        DispatchQueue.global().async(group: group){
            RecommendManager.shared.callRecommendation(id: 13) { data in
                self.thirdList = data
                print("3")
            }
        }
        
        DispatchQueue.global().async(group: group){
            RecommendManager.shared.callRecommendation(id: 634649) { data in
                self.fourthList = data
                print("4")
            }
        }
        
        group.notify(queue: .main) {
            self.posterCollectionView.reloadData()
            print("5")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        showAlert(title: "테스트", message: "메세지", buttonTitle: "배경색 변경") {
//            print("배경색 변경됨")
//            self.posterCollectionView.backgroundColor = .black
//        }
    }
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return list.results.count
        case 1:
            return secondList.results.count
        case 2:
            return thirdList.results.count
        case 3:
            return fourthList.results.count
        default:
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in:  0...1), green: CGFloat.random(in:  0...1), blue: CGFloat.random(in:  0...1), alpha: 1)
        
        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(list.results[indexPath.row].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2\(secondList.results[indexPath.row].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2"
        switch indexPath.section {
        case 0:
            cell.posterImageView.kf.setImage(with: URL(string: "\(url)\(list.results[indexPath.row].posterPath ?? "")"))
        case 1:
            cell.posterImageView.kf.setImage(with: URL(string: "\(url)\(secondList.results[indexPath.row].posterPath ?? "")"))
        case 2:
            cell.posterImageView.kf.setImage(with: URL(string: "\(url)\(thirdList.results[indexPath.row].posterPath ?? "")"))
        case 3:
            cell.posterImageView.kf.setImage(with: URL(string: "\(url)\(fourthList.results[indexPath.row].posterPath ?? "")"))
        default:
            print(" ")
        }
        
        return cell
    }
    
    // 헤더 뷰 디자인 해주는 함수
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView()}
            
            view.titleLabel.text = "테스트섹션"
            view.titleLabel.font = UIFont(name: "cachildren-modu", size: 24)
            
            return view
        }
        else {
            return UICollectionReusableView()
        }
    }
}

extension PosterViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        posterCollectionView.delegate = self // protocol as type
        posterCollectionView.dataSource = self
        
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }

}

//protocol Test {
//    func test()
//}
//
//class A: Test {
//    func test() {
//        <#code#>
//    }
//}
//
//class B: Test {
//    func test() {
//        <#code#>
//    }
//}
//
//class C: A {
//
//}
//
//// protocol as Type. 프로토콜을 채택을 받고 있는 클래스라면 타입처럼 쓰일 수 있음
//let example: Test = B()
//
//let value: A = C()
