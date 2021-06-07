//
//  TorneoInfoCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 26/11/2020.
//

import UIKit

class TorneoInfoCell: UITableViewCell {
    
    let labelTitle1: UILabel = {
          let label = UILabel()
          label.textColor = .white
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelTitle2: UILabel = {
          let label = UILabel()
          label.textColor = .lightGray
          label.font = .boldSystemFont(ofSize: 16)
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
        
        contentView.backgroundColor = .darkGray
        addSubview(labelTitle1)
        addSubview(labelTitle2)

        labelTitle1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelTitle1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        labelTitle2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelTitle2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        
        
    }



}
