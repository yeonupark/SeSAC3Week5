//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // 재사용 할 때 준비할 사항 있냐고 물어보는 메서드 (ex 기존 이미지 지우기 등)
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
}
