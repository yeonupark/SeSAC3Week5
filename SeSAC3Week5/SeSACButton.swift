//
//  SeSACButton.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/21.
//

import UIKit

// UIButton을 상속받는 클래스

@IBDesignable // 설정한 값이 스토리보드에 반영되는 것
class SeSACButton: UIButton {
    
    @IBInspectable // attribute inspector에 해당 요소 보여주는 것
    var jack: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }
}
