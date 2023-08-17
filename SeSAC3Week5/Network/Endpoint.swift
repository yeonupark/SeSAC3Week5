//
//  Endpoint.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import Foundation
    
// Enums must not contain stored properties : 열거형은 인스턴스 생성 불가 -> static으로 써야함
enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    // test: 인스턴스 연산 프로퍼티 > 값을 저장하고 있지는 않고, 값을 사용할 수 있는 통로로서의 역할만 담당
    // 연산 프로퍼티는 인스턴스던 static이던 사용 가능함
    var test: URL { // static 안써도 가능
        return URL(string: "www.naver.com")!
    }
    
    // 얘는 연산 프로퍼티 안에서 사용하는 변수들이 type으로 저장되어있기 때문에 static으로 써야함 ,, (baseURL이)
    static var photo: URL { // 연산 프로퍼티. photo는 통로 역할만 해주고, 저장을 담당하고 있지는 않음
        return URL(string: baseURL + allCases.randomElement()!.rawValue)! // Nasa. 넣어주면 인스턴스 프로퍼티에서도 타입 프로퍼티 사용이 가능함
    }
}
