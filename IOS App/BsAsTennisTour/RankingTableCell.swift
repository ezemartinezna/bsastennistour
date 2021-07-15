//
//  RankingTableCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 29/11/2020.
//

import UIKit

class RankingTableCell: UITableViewCell {
    
    let viewContainer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelName: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 15)!
          label.textColor = .colorCoal
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLastname: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorCoal
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let containerPhotoHeader : UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.masksToBounds = false
           view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
           view.layer.shadowOffset = CGSize(width: 0, height: 0)
           view.layer.shadowOpacity = 0.9
           view.backgroundColor = .clear
           view.layer.cornerRadius = 50 / 2
        
           return view
       }()
   
   let imagePhotoHeader: UIImageView = {
          let imageView = UIImageView()
          imageView.image = #imageLiteral(resourceName: "perfilIcon")
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.layer.masksToBounds = true
          imageView.contentMode = .scaleAspectFill
          imageView.isUserInteractionEnabled = true
          imageView.layer.cornerRadius = 50 / 2
          return imageView
      }()
    
    let labelPosition: UILabel = {
          let label = UILabel()
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 13)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let tourImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let lineOne : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let lineTwo : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let lineThree : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let lineFour : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let lineFive : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let lineSix : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let lineSeven : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorGray.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let labelPos: UILabel = {
          let label = UILabel()
          label.text = "Puesto"
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPoints: UILabel = {
          let label = UILabel()
          label.text = "Puntos"
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPlays: UILabel = {
          let label = UILabel()
          label.text = "Jugados"
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelWins: UILabel = {
          let label = UILabel()
          label.text = "Ganados"
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelTours: UILabel = {
          let label = UILabel()
          label.text = "Torneos"
          label.textColor = .colorGray
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPosB: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 11)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPointsB: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 11)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPlaysB: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 11)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelWinsB: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 11)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelToursB: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 11)!
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()

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

        addSubview(viewContainer)
        viewContainer.addSubview(labelName)
        viewContainer.addSubview(labelLastname)
        viewContainer.addSubview(containerPhotoHeader)
        containerPhotoHeader.addSubview(imagePhotoHeader)
        viewContainer.addSubview(labelPosition)
        viewContainer.addSubview(tourImage)
        viewContainer.addSubview(lineOne)
        viewContainer.addSubview(lineTwo)
        viewContainer.addSubview(lineThree)
        viewContainer.addSubview(lineFour)
        viewContainer.addSubview(lineFive)
        viewContainer.addSubview(lineSix)
        viewContainer.addSubview(lineSeven)
        viewContainer.addSubview(labelPos)
        viewContainer.addSubview(labelPoints)
        viewContainer.addSubview(labelPlays)
        viewContainer.addSubview(labelWins)
        viewContainer.addSubview(labelTours)
        viewContainer.addSubview(labelPosB)
        viewContainer.addSubview(labelPointsB)
        viewContainer.addSubview(labelPlaysB)
        viewContainer.addSubview(labelWinsB)
        viewContainer.addSubview(labelToursB)

        NSLayoutConstraint.activate([
        
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerPhotoHeader.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 15),
            containerPhotoHeader.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 15),
            containerPhotoHeader.widthAnchor.constraint(equalToConstant: 50),
            containerPhotoHeader.heightAnchor.constraint(equalToConstant: 50),
            
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalToConstant: 50),
            imagePhotoHeader.heightAnchor.constraint(equalToConstant: 50),

            labelName.topAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor,constant: -20),
            labelName.leadingAnchor.constraint(equalTo: containerPhotoHeader.trailingAnchor, constant: 15),
            
            labelLastname.centerYAnchor.constraint(equalTo: labelName.centerYAnchor),
            labelLastname.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 5),
            
            labelPosition.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5),
            labelPosition.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            tourImage.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            tourImage.heightAnchor.constraint(equalToConstant: 25),
            tourImage.widthAnchor.constraint(equalToConstant: 25),
            tourImage.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor,constant: -35),
            
            lineOne.heightAnchor.constraint(equalToConstant: 0.5),
            lineOne.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            lineOne.topAnchor.constraint(equalTo: containerPhotoHeader.bottomAnchor, constant: 10),
            lineOne.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -25),
            
            labelPos.topAnchor.constraint(equalTo: lineOne.bottomAnchor,constant: 6),
            labelPos.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            labelPosB.topAnchor.constraint(equalTo: labelPos.bottomAnchor, constant: 6),
            labelPosB.centerXAnchor.constraint(equalTo: labelPos.centerXAnchor),
            
            lineTwo.widthAnchor.constraint(equalToConstant: 0.5),
            lineTwo.leadingAnchor.constraint(equalTo: labelPos.trailingAnchor,constant: 10),
            lineTwo.topAnchor.constraint(equalTo: labelPos.centerYAnchor,constant: -5),
            lineTwo.bottomAnchor.constraint(equalTo: labelPosB.centerYAnchor, constant: 5),
            
            labelPoints.leadingAnchor.constraint(equalTo: lineTwo.trailingAnchor, constant: 10),
            labelPoints.centerYAnchor.constraint(equalTo: labelPos.centerYAnchor),
            labelPointsB.centerYAnchor.constraint(equalTo: labelPosB.centerYAnchor),
            labelPointsB.centerXAnchor.constraint(equalTo: labelPoints.centerXAnchor),
            
            lineThree.widthAnchor.constraint(equalToConstant: 0.5),
            lineThree.leadingAnchor.constraint(equalTo: labelPoints.trailingAnchor,constant: 10),
            lineThree.topAnchor.constraint(equalTo: labelPos.centerYAnchor,constant: -5),
            lineThree.bottomAnchor.constraint(equalTo: labelPosB.centerYAnchor, constant: 5),
            
            labelPlays.leadingAnchor.constraint(equalTo: lineThree.trailingAnchor, constant: 10),
            labelPlays.centerYAnchor.constraint(equalTo: labelPos.centerYAnchor),
            labelPlaysB.centerYAnchor.constraint(equalTo: labelPosB.centerYAnchor),
            labelPlaysB.centerXAnchor.constraint(equalTo: labelPlays.centerXAnchor),
            
            lineFour.widthAnchor.constraint(equalToConstant: 0.5),
            lineFour.leadingAnchor.constraint(equalTo: labelPlays.trailingAnchor,constant: 10),
            lineFour.topAnchor.constraint(equalTo: labelPos.centerYAnchor,constant: -5),
            lineFour.bottomAnchor.constraint(equalTo: labelPosB.centerYAnchor, constant: 5),
            
            labelWins.leadingAnchor.constraint(equalTo: lineFour.trailingAnchor, constant: 10),
            labelWins.centerYAnchor.constraint(equalTo: labelPos.centerYAnchor),
            labelWinsB.centerYAnchor.constraint(equalTo: labelPosB.centerYAnchor),
            labelWinsB.centerXAnchor.constraint(equalTo: labelWins.centerXAnchor),
            
            lineFive.widthAnchor.constraint(equalToConstant: 0.5),
            lineFive.leadingAnchor.constraint(equalTo: labelWins.trailingAnchor,constant: 10),
            lineFive.topAnchor.constraint(equalTo: labelPos.centerYAnchor,constant: -5),
            lineFive.bottomAnchor.constraint(equalTo: labelPosB.centerYAnchor, constant: 5),
            
            labelTours.leadingAnchor.constraint(equalTo: lineFive.trailingAnchor, constant: 10),
            labelTours.centerYAnchor.constraint(equalTo: labelPos.centerYAnchor),
            labelToursB.centerYAnchor.constraint(equalTo: labelPosB.centerYAnchor),
            labelToursB.centerXAnchor.constraint(equalTo: labelTours.centerXAnchor),
            
            lineSix.widthAnchor.constraint(equalToConstant: 0.5),
            lineSix.leadingAnchor.constraint(equalTo: labelTours.trailingAnchor,constant: 10),
            lineSix.topAnchor.constraint(equalTo: labelPos.centerYAnchor,constant: -5),
            lineSix.bottomAnchor.constraint(equalTo: labelPosB.centerYAnchor, constant: 5),
            
            lineSeven.heightAnchor.constraint(equalToConstant: 0.5),
            lineSeven.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            lineSeven.topAnchor.constraint(equalTo: labelPosB.bottomAnchor, constant: 6),
            lineSeven.trailingAnchor.constraint(equalTo: lineOne.trailingAnchor),
            lineSeven.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -10),
            
        ])
        
        
    }

}
