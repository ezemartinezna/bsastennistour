//
//  NewsCollectionCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 27/11/2020.
//

import UIKit

class NewsCollectionCell: UICollectionViewCell {
    
    let viewContainer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.colorGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageType : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
       
        addSubview(viewContainer)
        viewContainer.addSubview(imageType)
        
        NSLayoutConstraint.activate([
        
            viewContainer.topAnchor.constraint(equalTo: topAnchor,constant: 25),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -25),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 25),
            
            imageType.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            imageType.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            imageType.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            imageType.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),

        
        ])
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
