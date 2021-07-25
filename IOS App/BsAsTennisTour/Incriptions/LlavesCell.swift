//
//  LlavesCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 23/07/2021.
//

import UIKit

class LlavesCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {

    let labelTitle: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let allParticipants: UITableView = {
       let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(LlavesTableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.rowHeight = 150
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.allowsSelection = false
       return table
    }()

    
    var llaves = Llaves(name: "", types: [PlayerLlave(match: "", id: "", fullName: "", picture: "", win: false, set: [0:0])])

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
       
        addSubview(labelTitle)
        addSubview(allParticipants)
        allParticipants.delegate = self
        allParticipants.dataSource = self
        
        NSLayoutConstraint.activate([
            
            labelTitle.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            allParticipants.leadingAnchor.constraint(equalTo: leadingAnchor),
            allParticipants.trailingAnchor.constraint(equalTo: trailingAnchor),
            allParticipants.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 30),
            allParticipants.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return llaves.types.count / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LlavesTableViewCell
    
        cell.labelFullName.text = llaves.types[indexPath.row].fullName
        cell.labelFullName1.text = llaves.types[indexPath.row + 1].fullName
        cell.labelPosition.text = llaves.types[indexPath.row].match
        cell.labelPosition1.text = llaves.types[indexPath.row + 1].match
        cell.imagePhotoHeader.image = UIImage(named: llaves.types[indexPath.row].picture)
        cell.imagePhotoHeader1.image = UIImage(named: llaves.types[indexPath.row + 1].picture)
        
        if llaves.name == "CUARTOS" {
            cell.labelDatails.text = "S\(indexPath.row + 1) - Cuartos de Final - Partido \(indexPath.row + 1) - Semifinalista \(indexPath.row + 1)"
        }
        if llaves.name == "SEMIFINAL" {
            cell.labelDatails.text = "F\(indexPath.row + 1) - Semifinal - Partido \(indexPath.row + 1) - Finalistas \(indexPath.row + 1)"
        }
        if llaves.name == "FINAL" {
            cell.labelDatails.text = "Campeón - Partido Final - Final del Torneo"
        }
        
        return cell
    }
    
}



extension LlavesCell {
    func updateCellWith(row: Llaves) {
        self.llaves = row
        self.allParticipants.reloadData()
    }
}
