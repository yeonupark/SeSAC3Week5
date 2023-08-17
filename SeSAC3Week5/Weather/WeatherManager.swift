//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/17.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    
    func callRequestCodable(success: @escaping (WeatherData) -> Void, failure: @escaping () -> Void) {
        let weatherKey = "5b6936b6cb57210a1335d46e65ad2f5d"
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(weatherKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: WeatherData.self) { response in
                
                switch response.result {
                case .success(let value) : success(value)
                    
                case .failure(let error) :
                    print(error)
                    failure()
                    
                }
            }
        
    }
    
    func callRequestJSON(completionHandler: @escaping (JSON) -> Void) {
        let weatherKey = "5b6936b6cb57210a1335d46e65ad2f5d"
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")

                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestString(completionHandler: @escaping (String,String) -> Void) {
        let weatherKey = "5b6936b6cb57210a1335d46e65ad2f5d"
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                let tempText = "온도 \(temp)도 입니다"
                let humidText = "습도 \(humidity)% 입니다"
                
                completionHandler(tempText, humidText)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
