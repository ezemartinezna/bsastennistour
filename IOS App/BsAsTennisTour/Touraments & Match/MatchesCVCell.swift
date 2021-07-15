//
//  MatchesCVCell1.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 06/06/2021.
//

import UIKit

class MatchesCVCell: UICollectionViewCell {
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelTitle : UILabel = {
      let title = UILabel()
        title.font = UIFont(name: "Helvetica Bold", size: 14)!
        title.textColor = .colorPaper
        title.translatesAutoresizingMaskIntoConstraints = false
      return title
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
       
        addSubview(viewContainer)
        viewContainer.addSubview(labelTitle)
        
        NSLayoutConstraint.activate([
            
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            
            labelTitle.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            
            
        
        ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
