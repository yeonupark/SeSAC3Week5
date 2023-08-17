//
//  Extenstion+Alert.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    // @escaping: 나중에 실행됨. 바깥에서 실행하겠다
    func showAlert(title: String, message: String, buttonTitle: String, completionHandler: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonTitle, style: .default) { action in
            guard let title = action.title else { return }
            print("클릭", title)
            
            completionHandler() // 바깥에서 사용할 수 있게됨
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(button)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}
