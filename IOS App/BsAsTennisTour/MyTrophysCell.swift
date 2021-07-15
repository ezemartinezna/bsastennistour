//
//  MyTrophysCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 05/12/2020.
//

import UIKit

class MyTrophysCell: UITableViewCell {
    
    let labelName: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let imageTrophy: UIImageView = {
        let image = UIImageView()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // Clear old data to prepare the cell for being reused.
    }
    
    func setupLayout() {
        
        contentView.backgroundColor = .lightGray
        contentView.addSubview(labelName)
        contentView.addSubview(imageTrophy)
        
        labelName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelName.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
          
        imageTrophy.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageTrophy.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageTrophy.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageTrophy.trailingAnchor.constraint(equalTo: labelName.leadingAnchor,constant: 40).isActive = true

   

        
        
    }

}
