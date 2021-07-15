//
//  RankCollectionCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 23/05/2021.
//

import UIKit

class RankCollectionCell: UICollectionViewCell {
    
    let collectionViewAll : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.white.cgColor
        uView.layer.borderWidth = 0.5
        uView.layer.borderColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let collectionView : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorChoco.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let imagePerson : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let labelPos: UILabel = {
          let label = UILabel()
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelName: UILabel = {
          let label = UILabel()
          label.textColor = .white
          label.font = UIFont(name: "Helvetica Bold", size: 17)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLastName: UILabel = {
          let label = UILabel()
          label.textColor = .white
          label.font = UIFont(name: "Helvetica Bold", size: 17)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPoints: UILabel = {
          let label = UILabel()
          label.textColor = .colorPop
          label.font = UIFont(name: "Helvetica Bold", size: 17)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPuntos: UILabel = {
          let label = UILabel()
          label.text = "PUNTOS"
          label.textColor = .colorPop
          label.font = UIFont(name: "Helvetica Bold", size: 17)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
       
        addSubview(collectionViewAll)
        collectionViewAll.addSubview(collectionView)
        
        collectionView.addSubview(labelPos)
        collectionView.addSubview(labelName)
        collectionView.addSubview(labelLastName)
        collectionView.addSubview(labelPoints)
        collectionView.addSubview(labelPuntos)
        
        collectionViewAll.addSubview(imagePerson)
        
        NSLayoutConstraint.activate([
        
            collectionViewAll.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            collectionViewAll.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            collectionViewAll.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            collectionViewAll.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 8),
//            collectionViewAll.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            collectionView.topAnchor.constraint(equalTo: collectionViewAll.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionViewAll.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewAll.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionViewAll.heightAnchor , multiplier: 0.65),
            
            labelPos.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 30),
            labelPos.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 30),
            
            labelLastName.topAnchor.constraint(equalTo: labelPos.bottomAnchor, constant: 15),
            labelLastName.leadingAnchor.constraint(equalTo: labelPos.leadingAnchor),
            
            labelName.topAnchor.constraint(equalTo: labelLastName.bottomAnchor, constant: 5),
            labelName.leadingAnchor.constraint(equalTo: labelPos.leadingAnchor),
            
            labelPoints.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5),
            labelPoints.leadingAnchor.constraint(equalTo: labelPos.leadingAnchor),
            
            labelPuntos.topAnchor.constraint(equalTo: labelPoints.bottomAnchor, constant: 5),
            labelPuntos.leadingAnchor.constraint(equalTo: labelPos.leadingAnchor),
            
            imagePerson.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            imagePerson.leadingAnchor.constraint(equalTo: collectionViewAll.leadingAnchor),
            imagePerson.trailingAnchor.constraint(equalTo: collectionViewAll.trailingAnchor),
            imagePerson.bottomAnchor.constraint(equalTo: collectionViewAll.bottomAnchor),

        
        ])

    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
