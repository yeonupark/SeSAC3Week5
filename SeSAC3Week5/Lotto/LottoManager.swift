//
//  LottoManager.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/17.
//

import Foundation
import Alamofire

class LottoManager {
    
    static let shared = LottoManager() // 타입 프로퍼티로 생성
    
    func callLotto(completionHandler: @escaping (String, Int) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        
        // 통신 // 응답 전체말고 부분적으로 가져오기
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
                print(value.drwNoDate, value.drwNo)
                
                completionHandler(value.drwNoDate, value.drwNo)
            }
    }
    
}
