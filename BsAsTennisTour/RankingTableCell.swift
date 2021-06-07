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
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.9
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelName: UILabel = {
          let label = UILabel()
          label.textColor = .mainGray
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPosition: UILabel = {
          let label = UILabel()
          label.textColor = .mainGray
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelRank: UILabel = {
          let label = UILabel()
          label.textColor = .mainGray
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let tourImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "trophy")
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        
        contentView.backgroundColor = .mainGray

        addSubview(viewContainer)
        viewContainer.addSubview(labelName)
        viewContainer.addSubview(labelPosition)
        viewContainer.addSubview(labelRank)
        viewContainer.addSubview(tourImage)
        
        viewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        
        tourImage.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        tourImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tourImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        tourImage.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 10).isActive = true
        
        labelPosition.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        labelPosition.heightAnchor.constraint(equalToConstant: 25).isActive = true
        labelPosition.widthAnchor.constraint(equalToConstant: 25).isActive = true
        labelPosition.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 10).isActive = true

        labelName.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: labelPosition.trailingAnchor, constant: 20).isActive = true
        
        labelRank.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        labelRank.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20).isActive = true

        
        
    }

}
