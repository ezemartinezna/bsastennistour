//
//  ProfesorCollectionCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit

class ProfesorCollectionCell: UICollectionViewCell {
    
    let viewContainer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.colorGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let uView1: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .colorSage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelOrg : UILabel = {
      let title = UILabel()
        title.text = "Organizador"
        title.font = .boldSystemFont(ofSize: 17)
        title.textColor = .colorMint
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    let labelTitle : UILabel = {
      let title = UILabel()
        title.textColor = .white
        title.font = UIFont(name: "Helvetica Bold", size: 18)!
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
       
        addSubview(viewContainer)
        viewContainer.addSubview(uView1)
        uView1.addSubview(labelOrg)
        uView1.addSubview(labelTitle)

        viewContainer.addSubview(imageType)

        NSLayoutConstraint.activate([
        
            viewContainer.topAnchor.constraint(equalTo: topAnchor,constant: 25),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -25),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 25),
            
            uView1.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            uView1.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            uView1.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            uView1.heightAnchor.constraint(equalToConstant: 150),
            
            labelOrg.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            labelOrg.topAnchor.constraint(equalTo: uView1.topAnchor,constant: 20),
            
            labelTitle.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: labelOrg.bottomAnchor, constant: 10),
            
            imageType.topAnchor.constraint(equalTo: uView1.bottomAnchor),
            imageType.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            imageType.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            imageType.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),

        
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
