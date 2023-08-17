//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/16.
//

import UIKit
import Alamofire

enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

class CodableViewController: UIViewController {

    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    var resultText = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchTranslateData(source: "ko", target: "en", text: "날이 많이 더운데 아이스크림 사주라")
        
        WeatherManager.shared.callRequestCodable { data in
            //self.tempLabel.text = "\(data.main.temp)"
        } failure: {
            print("show Alert")
        }

        
        WeatherManager.shared.callRequestString { temp, humidity in
            //self.tempLabel.text = temp
            //self.humidityLabel.text = humidity
        }
        
        WeatherManager.shared.callRequestJSON { json in
            let temp = json["main"]["temp"].doubleValue - 273.15
            let humidity = json["main"]["humidity"].intValue
            
            self.tempLabel.text = String(temp)
            self.humidityLabel.text = String(humidity)
            
        }
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        guard let text = dateTextField.text else {return}
        
        do {
            let result = try validateUserInputError(text: text)
            // bool 값이 true 일 때. 올바른 경우에 대한 코드 여기에 작성
        } catch {
            print("ERROR")
        }
        
//        if validateUserInput(text: text) {
//            print("검색 가능. 네트워크 요청 가능")
//        } else {
//            print("검색 불가")
//        }
    }
    
    func validateUserInputError(text: String) throws -> Bool {
        
        guard !(text.isEmpty) else {
            print("빈 값")
            throw ValidationError.emptyString
        }
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
        }
        guard checkIfDateFormat(text: text) else {
            print("올바른 형식 아님")
            throw ValidationError.isNotDate
        }
        
        return true
    }
    
    func validateUserInput(text: String) -> Bool {
        // 빈 칸일 경우
        guard !(text.isEmpty) else {
            print("빈 값")
            return false
        }
        // 숫자 여부
        guard Int(text) != nil else {
            print("숫자 아님")
            return false
        }
        // 날짜 형식으로 변환이 되는지
        guard checkIfDateFormat(text: text) else {
            print("올바른 형식 아님")
            return false
        }
        
        // 모든 검증을 통과햇다먄, 유효성 검증 완료 !
        return true
    }
    
    func checkIfDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let result = format.date(from: text)
        
        return result == nil ? false : true
    }
    
    
//    func fetchTranslateData(source: String, target: String, text: String) {
//
//        print("fetchTranslateData", source, target, text)
//
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500) // 범위 조절해서 상태 코드에 대한 유효성 검증
//            .responseDecodable(of: Translation.self) { response in
//
//                print(response) // 오류 확인
//                guard let value = response.value else { return }
//                print(value.message.result.translatedText)
//
//                self.resultText = value.message.result.translatedText
//
//                print("확인",self.resultText)
//
//                // ViewDidLoad 아니구 함수 내부에서 응답값 받은 이후에 호출해야함
//                self.fetchReTranslateData(source: "en", target: "ko", text: self.resultText)
//            }
//    }
    
    func fetchReTranslateData(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500) // 범위 조절해서 상태 코드에 대한 유효성 검증
            .responseDecodable(of: Translation.self) { response in
                
                print(response) // 오류 확인
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                
                print("최종 확인",self.resultText)
                
            }
    }

    
//    func fetchLottoData() {
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
//
//        // dispatchQuese async thread: 요청 순서와 상관없이 누가 먼저 끝날지 모름 !
//
//        // 1
//        AF.request(url, method: .get).validate()
//            .responseData { response in
//                guard let value = response.value else { return }
//                print("responseData:", value)
//
//                DispatchQueue.main.async {
//                    // UI 관련된건 main에서 처리해야 함 !
//                    // 레이블에 숫자 출력하기
//                }
//            }
//        // 2
//        AF.request(url, method: .get).validate()
//            .responseString { response in
//                guard let value = response.value else { return }
//                print("responseString:", value)
//            }
//        // 3
//        AF.request(url, method: .get).validate()
//            .response { response in
//                guard let value = response.value else { return }
//                print("response:", value)
//            }
//
//        // 4
//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: Lotto.self) { response in
//                guard let value = response.value else { return }
//                print("responseDecodable:", value)
//            }
//    }

}

// MARK: - Lotto
struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

// 안에 있는 형태만 맞는다면 식판 이름은 상관 없음
struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}
