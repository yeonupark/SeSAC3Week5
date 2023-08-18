//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        dispatchGrounp()
    }
    
    func dispatchGrounp() {
        
        let group = DispatchGroup()
            
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 301...400 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("END")
            // 컬렉션 뷰에 대한 갱신 등의 코드 요기서 .
        }
    }
    
    
    func globalAsyncTwo() {
        print("Start")
        
        for i in 1...100 {
            DispatchQueue.global().async { // 반복문 하나하나를 다른 알바생에게 부여
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
    }
    
    func globalAsync() { // 효율적. 다른 알바생이랑 동시에 같이 일함
        print("Start")
        
        DispatchQueue.global().async { // 네트워크
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
    }
    
    func globalSync() { // 결국 또 그냥 닭벼슬에서 다 처리하는 것과 같음
        print("Start") // 1
        
        DispatchQueue.global().sync { // 2
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 { // 3
            sleep(1)
            print(i, terminator: " ")
        }
        print("End") // 4
    }
    
    func serialAsync() { // 매니저한테 보내놓고 다음꺼 먼저 실행. 미뤄놓은 작업은 다른거 다 끝나고 받아서 다시 실행
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        print("End")
    }
    
    func serialSync() { // 혼자 일을 다 하고 있는 상태
        print("Start")
        
        for i in 1...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        DispatchQueue.main.sync { // 무한 대기 상태.  지금은 쓰지 말자 !!!
            for i in 101...200 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        print("End")
    }
}
