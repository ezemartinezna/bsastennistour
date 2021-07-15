//
//  ToursCollectionViewCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 26/05/2021.
//

import UIKit

class ToursCollectionViewCell: UICollectionViewCell {
    
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
    
    let labelDate : UILabel = {
      let title = UILabel()
        title.font = .boldSystemFont(ofSize: 14)
        title.textColor = .colorMint
        title.textAlignment = .left
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    let labelNameTour : UILabel = {
      let title = UILabel()
        title.text = "Torneo Club Mitre"
        title.font = UIFont(name: "Helvetica Bold", size: 18)!
        title.textAlignment = .left
        title.textColor = .colorPaper
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    let labelType : UILabel = {
      let title = UILabel()
        title.textColor = .white
        title.textAlignment = .left
        title.font = UIFont(name: "Helvetica", size: 18)!
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    let labelMaxPlayers : UILabel = {
      let title = UILabel()
        title.textColor = .colorPop
        title.textAlignment = .left
        title.font = UIFont(name: "Helvetica", size: 17)!
      title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    let imageType : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "red-tennis")
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
        uView1.addSubview(labelDate)
        uView1.addSubview(labelNameTour)
        uView1.addSubview(labelType)
        uView1.addSubview(labelMaxPlayers)

        viewContainer.addSubview(imageType)

        NSLayoutConstraint.activate([
        
            viewContainer.topAnchor.constraint(equalTo: topAnchor,constant: 25),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -25),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 25),
            
            uView1.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            uView1.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            uView1.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            uView1.heightAnchor.constraint(equalToConstant: 180),
            
            labelDate.leadingAnchor.constraint(equalTo: uView1.leadingAnchor,constant: 25),
            labelDate.topAnchor.constraint(equalTo: uView1.topAnchor,constant: 25),
            
            labelNameTour.leadingAnchor.constraint(equalTo: labelDate.leadingAnchor),
            labelNameTour.topAnchor.constraint(equalTo: labelDate.bottomAnchor,constant: 10),
            
            labelType.leadingAnchor.constraint(equalTo: labelDate.leadingAnchor),
            labelType.topAnchor.constraint(equalTo: labelNameTour.bottomAnchor, constant: 5),
            
            labelMaxPlayers.leadingAnchor.constraint(equalTo: labelDate.leadingAnchor),
            labelMaxPlayers.topAnchor.constraint(equalTo: labelType.bottomAnchor, constant: 10),
            
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
