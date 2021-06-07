//
//  ProfesorCollectionCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit

class ProfesorCollectionCell: UICollectionViewCell {
    
    let lableTitle : UILabel = {
      let title = UILabel()
        title.font = .boldSystemFont(ofSize: 21)
        title.textColor = .white
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
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
        addSubview(lableTitle)

        imageType.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageType.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageType.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageType.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        lableTitle.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30).isActive = true
        lableTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lableTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
