//
//  TorneosTableCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit

class TorneosTableCell: UITableViewCell {
    
    let viewContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.9
        view.backgroundColor = .mainGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelName: UILabel = {
          let label = UILabel()
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 17)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelDate: UILabel = {
          let label = UILabel()
          label.textColor = .darkGray
          label.font = .italicSystemFont(ofSize: 18)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let tourImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "tournament")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let calendarImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "calendar")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let lineSeparator : UIView = {
        let view = UIView()
        view.backgroundColor = .mainGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // Clear old data to prepare the cell for being reused.
    }
    
    func setupLayout() {
        
        contentView.backgroundColor = .mainGray
        addSubview(viewContainer)
        
        viewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        viewContainer.addSubview(tourImage)
        viewContainer.addSubview(calendarImage)
        viewContainer.addSubview(labelName)
        viewContainer.addSubview(labelDate)
        viewContainer.addSubview(lineSeparator)
        
        lineSeparator.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        lineSeparator.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        lineSeparator.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        lineSeparator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        labelName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelName.centerYAnchor.constraint(equalTo: lineSeparator.centerYAnchor, constant: -20).isActive = true
        
        tourImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tourImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        tourImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        tourImage.centerYAnchor.constraint(equalTo: labelName.centerYAnchor).isActive = true

        
        
        labelDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelDate.centerYAnchor.constraint(equalTo: lineSeparator.centerYAnchor, constant: 20).isActive = true
        
        calendarImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        calendarImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        calendarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        calendarImage.centerYAnchor.constraint(equalTo: labelDate.centerYAnchor).isActive = true
        
        
    }

}
