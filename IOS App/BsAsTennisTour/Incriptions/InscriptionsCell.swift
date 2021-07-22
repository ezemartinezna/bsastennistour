//
//  InscriptionsCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 26/11/2020.
//

import UIKit

class InscriptionsCell: UITableViewCell {
    
    let containerPhotoHeader : UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 50 / 2
           view.layer.masksToBounds = false
           view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
           view.layer.shadowOffset = CGSize(width: 0, height: 0)
           view.layer.shadowOpacity = 0.9
           view.backgroundColor = .clear
           return view
       }()
    
    let imagePhotoHeader: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.cornerRadius = 30 / 2
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
       }()
    
    let labelName: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 11)!
          label.textColor = .colorCoal
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLastname: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 11)!
          label.textColor = .colorCoal
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPosition: UILabel = {
          let label = UILabel()
          label.textColor = .colorPop
          label.font = UIFont(name: "Helvetica Bold", size: 12)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
//    let labelScore: UILabel = {
//          let label = UILabel()
//          label.textColor = .colorCoal
//          label.font = UIFont(name: "Helvetica", size: 12)!
//          label.translatesAutoresizingMaskIntoConstraints = false
//          return label
//      }()
//
//    let labelPosition: UILabel = {
//          let label = UILabel()
//          label.textColor = .colorCoal
//          label.font = UIFont(name: "Helvetica", size: 12)!
//          label.translatesAutoresizingMaskIntoConstraints = false
//          return label
//      }()
//
//    let labelPoints: UILabel = {
//          let label = UILabel()
//          label.textColor = .colorCoal
//          label.font = UIFont(name: "Helvetica", size: 12)!
//          label.translatesAutoresizingMaskIntoConstraints = false
//          return label
//      }()
    
//    let lineOne : UIView = {
//        let uView = UIView()
//        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
//        uView.layer.masksToBounds = false
//        uView.translatesAutoresizingMaskIntoConstraints = false
//        return uView
//    }()
//
//    let lineTwo : UIView = {
//        let uView = UIView()
//        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
//        uView.layer.masksToBounds = false
//        uView.translatesAutoresizingMaskIntoConstraints = false
//        return uView
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupLayout()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupLayout() {
        
        contentView.backgroundColor = .white

        addSubview(containerPhotoHeader)
        containerPhotoHeader.addSubview(imagePhotoHeader)
        addSubview(labelName)
        addSubview(labelLastname)
        addSubview(labelPosition)
//        addSubview(labelScore)
//        addSubview(lineOne)
//        addSubview(labelPosition)
//        addSubview(lineTwo)
//        addSubview(labelPoints)

        NSLayoutConstraint.activate([
            containerPhotoHeader.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            containerPhotoHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            containerPhotoHeader.widthAnchor.constraint(equalToConstant: 30),
            containerPhotoHeader.heightAnchor.constraint(equalToConstant: 30),
            
            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.heightAnchor.constraint(equalTo: containerPhotoHeader.heightAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalTo: containerPhotoHeader.widthAnchor),
            
            labelName.topAnchor.constraint(equalTo: containerPhotoHeader.topAnchor, constant: 5),
            labelName.leadingAnchor.constraint(equalTo: containerPhotoHeader.trailingAnchor, constant: 15),
            
            labelLastname.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5),
            labelLastname.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            labelPosition.centerYAnchor.constraint(equalTo: imagePhotoHeader.centerYAnchor),
            labelPosition.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40)
            
//            labelScore.leadingAnchor.constraint(equalTo: containerPhotoHeader.leadingAnchor),
//            labelScore.topAnchor.constraint(equalTo: containerPhotoHeader.bottomAnchor, constant: 10),
//            labelScore.widthAnchor.constraint(equalToConstant: 70),
//            
//            lineOne.widthAnchor.constraint(equalToConstant: 1),
//            lineOne.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
//            lineOne.centerYAnchor.constraint(equalTo: labelScore.centerYAnchor),
//            lineOne.heightAnchor.constraint(equalToConstant: 10),
//            
//            labelPosition.leadingAnchor.constraint(equalTo: lineOne.trailingAnchor, constant: 10),
//            labelPosition.centerYAnchor.constraint(equalTo: labelScore.centerYAnchor),
//            labelPosition.widthAnchor.constraint(equalToConstant: 70),
//            
//            lineTwo.widthAnchor.constraint(equalToConstant: 1),
//            lineTwo.leadingAnchor.constraint(equalTo: labelPosition.trailingAnchor, constant: 10),
//            lineTwo.centerYAnchor.constraint(equalTo: labelScore.centerYAnchor),
//            lineTwo.heightAnchor.constraint(equalToConstant: 10),
//            
//            labelPoints.centerYAnchor.constraint(equalTo: labelScore.centerYAnchor),
//            labelPoints.leadingAnchor.constraint(equalTo: lineTwo.trailingAnchor, constant: 10),
            

        ])
        
        
    }


}
