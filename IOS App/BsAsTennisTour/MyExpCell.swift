//
//  MyExpCell.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 07/12/2020.
//

import UIKit

class MyExpCell: UITableViewCell {

    let labelName: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 14)
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
        
        contentView.backgroundColor = .lightGray

        addSubview(labelName)

        labelName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelName.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        
        
    }


}
