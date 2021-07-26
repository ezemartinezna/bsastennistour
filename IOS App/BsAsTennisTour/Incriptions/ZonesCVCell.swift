//
//  ZonesCVCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 26/07/2021.
//

import UIKit

class ZonesCVCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    let labelTitle: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelWin: UILabel = {
          let label = UILabel()
          label.textColor = .colorCoal
          label.text = "Ganados"
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLost: UILabel = {
          let label = UILabel()
          label.text = "Perdidos"
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPoints: UILabel = {
          let label = UILabel()
          label.text = "Puntos"
          label.textColor = .colorCoal
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let allParticipants: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ZonesTVCell.self, forCellReuseIdentifier: "MyCell")
        table.rowHeight = 60
        table.backgroundColor = .white
        table.separatorColor = .lightGray
        table.allowsSelection = false
       return table
    }()
    
    var allPlayers : [PlayerZona] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
       
        addSubview(labelTitle)
        addSubview(labelWin)
        addSubview(labelLost)
        addSubview(labelPoints)
        addSubview(allParticipants)
        allParticipants.delegate = self
        allParticipants.dataSource = self
        
        NSLayoutConstraint.activate([
            
            labelTitle.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            
            labelPoints.centerYAnchor.constraint(equalTo: labelTitle.centerYAnchor),
            labelPoints.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            
            labelLost.centerYAnchor.constraint(equalTo: labelTitle.centerYAnchor),
            labelLost.trailingAnchor.constraint(equalTo: labelPoints.leadingAnchor,constant: -5),
            
            labelWin.centerYAnchor.constraint(equalTo: labelTitle.centerYAnchor),
            labelWin.trailingAnchor.constraint(equalTo: labelLost.leadingAnchor,constant: -5),
            
            allParticipants.leadingAnchor.constraint(equalTo: leadingAnchor),
            allParticipants.trailingAnchor.constraint(equalTo: trailingAnchor),
            allParticipants.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
            allParticipants.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ZonesTVCell
    
        let (firstname,lastname) = NameDivisor(fullName: allPlayers[indexPath.row].fullName)
        cell.labelName.text = firstname
        cell.labelLastname.text = lastname
        cell.labelWins.text = "\(allPlayers[indexPath.row].win)"
        cell.labelLosts.text = "\(allPlayers[indexPath.row].lose)"
        cell.labelPositionPoints.text = "\(allPlayers[indexPath.row].points)"
        cell.imagePhotoHeader.image = UIImage(named: allPlayers[indexPath.row].picture)

        
        return cell
    }
    
}



extension ZonesCVCell {
    func updateCellWith(row: [PlayerZona]) {
        self.allPlayers = row
        self.allParticipants.reloadData()
    }
    
    func NameDivisor(fullName : String) -> (firstName: String,lastname : String) {
        
        var firstname = ""
        var lastname = ""
        
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            firstname = components.removeFirst()
            lastname = components.joined(separator: " ")
        }
    return(firstname,lastname)
    }
    
}
