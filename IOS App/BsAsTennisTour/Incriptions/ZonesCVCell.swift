//
//  ZonesCVCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 26/07/2021.
//

import UIKit

class ZonesCVCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var admin = UserDefaults.standard.string(forKey: "ADMIN")
    
    weak var delegate:ZonasLlavesDelegate?
    
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
          label.text = "Gan."
          label.textAlignment = .center
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLost: UILabel = {
          let label = UILabel()
          label.text = "Per."
          label.textColor = .colorCoal
          label.textAlignment = .center
          label.font = UIFont(name: "Helvetica Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPoints: UILabel = {
          let label = UILabel()
          label.text = "Pts"
          label.textColor = .colorCoal
          label.textAlignment = .center
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
       return table
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
    
    var allPlayers : [PlayerZona] = []
    var maxCant : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = .colorMint
        addSubview(labelTitle)
        addSubview(stackview)
        stackview.addArrangedSubview(labelWin)
        stackview.addArrangedSubview(labelLost)
        stackview.addArrangedSubview(labelPoints)
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
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            
            stackview.centerYAnchor.constraint(equalTo: labelTitle.centerYAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            stackview.heightAnchor.constraint(equalToConstant: 40),
            stackview.widthAnchor.constraint(equalToConstant: 120),
            

            
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
    
        let index = indexPath.row + 1
        if index <= maxCant {
            cell.containerView.backgroundColor = .colorMint
        }else{
            cell.containerView.backgroundColor = .white
        }
        let (firstname,lastname) = NameDivisor(fullName: allPlayers[indexPath.row].fullName)
        cell.labelName.text = firstname
        cell.labelLastname.text = lastname
        cell.labelWins.text = "\(allPlayers[indexPath.row].win)"
        cell.labelLosts.text = "\(allPlayers[indexPath.row].lose)"
        cell.labelPositionPoints.text = "\(allPlayers[indexPath.row].points)"
        cell.imagePhotoHeader.image = UIImage(named: allPlayers[indexPath.row].picture)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        delegate?.ZonasCellTapped(position: allPlayers[indexPath.row].key, index: indexPath.row)


    }
    
}



extension ZonesCVCell {
    func updateCellWith(row: [PlayerZona], max : Int) {
        self.allPlayers = row
        self.maxCant = max
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
