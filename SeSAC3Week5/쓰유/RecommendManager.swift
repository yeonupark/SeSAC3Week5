//
//  RecommendManager.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/17.
//

import Foundation
import Alamofire

class RecommendManager {
    
    static let shared = RecommendManager()
    
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=98a44a09aa6864ca38329b66c0679d08"
        
        AF.request(url).validate(statusCode: 200...500)
            .responseDecodable(of: Recommendation.self) { response in
                
                switch response.result {
                case .success(let value) :
                    completionHandler(value)
                    
                case .failure(let error) :
                    print(error)
                    
                }
                
            }
    }
}
