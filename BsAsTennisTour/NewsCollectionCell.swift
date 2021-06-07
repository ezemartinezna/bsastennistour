//
//  NewsCollectionCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 27/11/2020.
//

import UIKit

class NewsCollectionCell: UICollectionViewCell {
    
    
    let imageType : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
       
        addSubview(imageType)

        imageType.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageType.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageType.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageType.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
