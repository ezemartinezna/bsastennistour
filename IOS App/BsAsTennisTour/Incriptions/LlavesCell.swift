//
//  LlavesCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 23/07/2021.
//

import UIKit

class LlavesCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var admin = UserDefaults.standard.string(forKey: "ADMIN")
    
    weak var delegate:ZonasLlavesDelegate?

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
       return table
    }()

    
    var llaves = Llaves(name: "", types: [Match(name: "", player1: PlayerLlave(match: "", id: "", fullName: "", picture: "", win: false, set: ["0"]), player2: PlayerLlave(match: "", id: "", fullName: "", picture: "", win: false, set: ["0"]))])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        addSubview(labelTitle)
        addSubview(allParticipants)
        allParticipants.delegate = self
        allParticipants.dataSource = self
        
        if admin == "YES-1" {
            allParticipants.allowsSelection = true
        }else{
            allParticipants.allowsSelection = false
        }
        
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
        return llaves.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LlavesTableViewCell
    

            
        cell.labelFullName.text = llaves.types[indexPath.row].player1.fullName
        cell.labelPosition.text = llaves.types[indexPath.row].player1.match
        cell.imagePhotoHeader.image = UIImage(named: llaves.types[indexPath.row].player1.picture)
        let imageUrl1 = URL(string:llaves.types[indexPath.row].player1.picture)
        cell.imagePhotoHeader.sd_setImage(with: imageUrl1, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
        
        if llaves.types[indexPath.row].player1.win {
            cell.imageBallPlayer1.isHidden = false
        }else{
            cell.imageBallPlayer1.isHidden = true
        }
        
        cell.updatePlayer1(row: llaves.types[indexPath.row].player1.set)
        
        
        cell.labelFullName1.text = llaves.types[indexPath.row].player2.fullName
        cell.labelPosition1.text = llaves.types[indexPath.row].player2.match
        let imageUrl2 = URL(string:llaves.types[indexPath.row].player2.picture)
        cell.imagePhotoHeader1.sd_setImage(with: imageUrl2, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
        
        if llaves.types[indexPath.row].player2.win {
            cell.imageBallPlayer2.isHidden = false
        }else{
            cell.imageBallPlayer2.isHidden = true
        }
            
        cell.updatePlayer2(row: llaves.types[indexPath.row].player2.set)
 
        if llaves.name == "Octavos" {
            cell.labelDatails.text = "C\(indexPath.row + 1) - Octavos de Final - Partido \(indexPath.row + 1) - Cuartos \(indexPath.row + 1)"
        }
        
        if llaves.name == "Cuartos" {
            cell.labelDatails.text = "S\(indexPath.row + 1) - Cuartos de Final - Partido \(indexPath.row + 1) - Semifinalista \(indexPath.row + 1)"
        }
        if llaves.name == "Semifinal" {
            cell.labelDatails.text = "F\(indexPath.row + 1) - Semifinal - Partido \(indexPath.row + 1) - Finalistas \(indexPath.row + 1)"
        }
        if llaves.name == "Final" {
            cell.labelDatails.text = "Campeón - Partido Final - Final del Torneo"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.LlavesCellTapped(match: llaves.types[indexPath.row].name)
    }
    
}

extension LlavesCell {
    func updateCellWith(row: Llaves) {
        self.llaves = row
        self.allParticipants.reloadData()
    }
}
