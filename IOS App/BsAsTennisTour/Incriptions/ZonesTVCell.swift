//
//  ZonesCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 23/07/2021.
//

import UIKit

class ZonesTVCell: UITableViewCell {
    
    let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .white
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()

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
           return imageView
       }()
    
    let containerPhotoHeader1 : UIView = {
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
    
    let imagePhotoHeader1: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.cornerRadius = 30 / 2
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
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
    
    let labelPositionPoints: UILabel = {
          let label = UILabel()
          label.textColor = .colorPop
          label.textAlignment = .center
          label.font = UIFont(name: "Helvetica Bold", size: 12)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelWins: UILabel = {
          let label = UILabel()
          label.textColor = .colorPop
          label.textAlignment = .center
          label.font = UIFont(name: "Helvetica Bold", size: 12)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLosts: UILabel = {
          let label = UILabel()
          label.textColor = .colorPop
          label.textAlignment = .center
          label.font = UIFont(name: "Helvetica Bold", size: 12)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let stackview : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
        addSubview(containerView)
        containerView.addSubview(containerPhotoHeader)
        containerPhotoHeader.addSubview(imagePhotoHeader)
        containerView.addSubview(containerPhotoHeader1)
        containerPhotoHeader1.addSubview(imagePhotoHeader1)
        containerView.addSubview(labelName)
        containerView.addSubview(labelLastname)
        containerView.addSubview(stackview)
        stackview.addArrangedSubview(labelWins)
        stackview.addArrangedSubview(labelLosts)
        stackview.addArrangedSubview(labelPositionPoints)

        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerPhotoHeader.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            containerPhotoHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            containerPhotoHeader.widthAnchor.constraint(equalToConstant: 30),
            containerPhotoHeader.heightAnchor.constraint(equalToConstant: 30),
            
            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.heightAnchor.constraint(equalTo: containerPhotoHeader.heightAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalTo: containerPhotoHeader.widthAnchor),
            
            containerPhotoHeader1.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            containerPhotoHeader1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerPhotoHeader1.widthAnchor.constraint(equalToConstant: 30),
            containerPhotoHeader1.heightAnchor.constraint(equalToConstant: 30),
            
            imagePhotoHeader1.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            imagePhotoHeader1.centerXAnchor.constraint(equalTo: containerPhotoHeader1.centerXAnchor),
            imagePhotoHeader1.heightAnchor.constraint(equalTo: containerPhotoHeader1.heightAnchor),
            imagePhotoHeader1.widthAnchor.constraint(equalTo: containerPhotoHeader1.widthAnchor),
            
            labelName.topAnchor.constraint(equalTo: containerPhotoHeader.topAnchor),
            labelName.leadingAnchor.constraint(equalTo: containerPhotoHeader.trailingAnchor, constant: 15),
            
            labelLastname.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5),
            labelLastname.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            stackview.centerYAnchor.constraint(equalTo: imagePhotoHeader.centerYAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            stackview.heightAnchor.constraint(equalToConstant: 40),
            stackview.widthAnchor.constraint(equalToConstant: 120),
            

        ])
        
        
    }



}
