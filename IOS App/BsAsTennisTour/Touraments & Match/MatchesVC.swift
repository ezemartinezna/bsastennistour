//
//  MatchesVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 15/05/2021.
//

import UIKit

class MatchesVC: UIViewController {

    var matchesNext : [AllMatches] = []
    var matchesPrev : [AllMatches] = []
    
    let titleTorneo : UILabel = {
        let label = UILabel()
        label.text = "PARTIDOS"
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Bold", size: 25)!
        label.textColor = .white
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageTrophy : UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "zona-torneo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorCoal
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewBackgroundLeft : UIView = {
        let uView = UIView()
        uView.backgroundColor = .clear
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uViewBackgroundRight : UIView = {
        let uView = UIView()
        uView.backgroundColor = .clear
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let nextMatchButton : UIButton = {
        let button = UIButton()
        button.setTitle("PROXIMOS PARTIDOS", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPop
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let historyMatchButton : UIButton = {
        let button = UIButton()
        button.setTitle("PARTIDOS JUGADOS", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton2 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPaper
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let uViewScrollView : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let imageBackground : UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Cancha Background")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageBackground1 : UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Cancha Background")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let uViewScrollView1 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        uView.isHidden = true
        return uView
    }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.text = "PROXIMOS PARTIDOS"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTitle2: UILabel = {
          let label = UILabel()
            label.text = "PARTIDOS JUGADOS"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    ///PROXIMOS PARTIDOS
    
    private let allMatchesPrevTB: UITableView = {
       let table = UITableView()
        table.backgroundColor = .clear
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MatchesTableCell.self, forCellReuseIdentifier: "MyCell")
        table.rowHeight = 200
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.allowsSelection = true
       return table
    }()
    
    ///PARTIDOS JUGADOS
    
    private let allMatchesNextTB: UITableView = {
       let table = UITableView()
        table.backgroundColor = .clear
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MatchesTableCell.self, forCellReuseIdentifier: "MyCell")
        table.rowHeight = 200
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.allowsSelection = true
       return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        loadMatchesNext()
        loadMatchesPrev()

    }
    

    func setupLayout() {
        
        view.backgroundColor = .mainGray
        view.addSubview(viewContainer)
        
        viewContainer.addSubview(titleTorneo)
        viewContainer.addSubview(imageTrophy)
        viewContainer.addSubview(uViewBackgroundLeft)
        viewContainer.addSubview(uViewBackgroundRight)
        view.addSubview(nextMatchButton)
        uViewBackgroundLeft.addSubview(lineButton1)
        view.addSubview(historyMatchButton)
        uViewBackgroundRight.addSubview(lineButton2)
        
        view.addSubview(uViewScrollView)

        view.addSubview(uViewScrollView1)
        
        //PROXIMOS PARTIDOS
        uViewScrollView.addSubview(imageBackground)
        uViewScrollView.addSubview(labelTitle)
        uViewScrollView.addSubview(allMatchesNextTB)
        allMatchesNextTB.dataSource = self
        allMatchesNextTB.delegate = self
 
        //PARTIDOS JUGADOS
        uViewScrollView1.addSubview(imageBackground1)
        uViewScrollView1.addSubview(labelTitle2)
        uViewScrollView1.addSubview(allMatchesPrevTB)
        allMatchesPrevTB.dataSource = self
        allMatchesPrevTB.delegate = self


        
        NSLayoutConstraint.activate([
        
            viewContainer.heightAnchor.constraint(equalToConstant: 200),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleTorneo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            titleTorneo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            
            imageTrophy.topAnchor.constraint(equalTo: titleTorneo.bottomAnchor, constant: 10),
            imageTrophy.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageTrophy.widthAnchor.constraint(equalToConstant: 60),
            imageTrophy.heightAnchor.constraint(equalToConstant: 60),
            
            uViewBackgroundLeft.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.5),
            uViewBackgroundLeft.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            uViewBackgroundLeft.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            
            uViewBackgroundRight.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.5),
            uViewBackgroundRight.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            uViewBackgroundRight.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            
            lineButton1.leadingAnchor.constraint(equalTo: uViewBackgroundLeft.leadingAnchor, constant: 20),
            lineButton1.trailingAnchor.constraint(equalTo: uViewBackgroundLeft.trailingAnchor, constant: -20),
            lineButton1.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            lineButton1.heightAnchor.constraint(equalToConstant: 3),
            
            nextMatchButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor),
            nextMatchButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            nextMatchButton.heightAnchor.constraint(equalToConstant: 15),
            nextMatchButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor),
            
            lineButton2.leadingAnchor.constraint(equalTo: uViewBackgroundRight.leadingAnchor, constant: 20),
            lineButton2.trailingAnchor.constraint(equalTo: uViewBackgroundRight.trailingAnchor, constant: -20),
            lineButton2.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            lineButton2.heightAnchor.constraint(equalToConstant: 3),
            
            historyMatchButton.centerXAnchor.constraint(equalTo: uViewBackgroundRight.centerXAnchor),
            historyMatchButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10),
            historyMatchButton.heightAnchor.constraint(equalToConstant: 15),
            historyMatchButton.widthAnchor.constraint(equalTo: uViewBackgroundRight.widthAnchor),
            
            //PROXIMOS PARTIDOS
            uViewScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uViewScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            uViewScrollView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            uViewScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageBackground.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: uViewScrollView.topAnchor, constant: 20),
            labelTitle.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor, constant: 20),
            
            allMatchesNextTB.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15),
            allMatchesNextTB.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor),
            allMatchesNextTB.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor),
            allMatchesNextTB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            
            //PARTIDOS JUGADOS
            uViewScrollView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uViewScrollView1.widthAnchor.constraint(equalTo: view.widthAnchor),
            uViewScrollView1.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            uViewScrollView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageBackground1.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor),
            imageBackground1.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor),
            imageBackground1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            labelTitle2.topAnchor.constraint(equalTo: uViewScrollView1.topAnchor, constant: 20),
            labelTitle2.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor, constant: 20),
            
            allMatchesPrevTB.topAnchor.constraint(equalTo: labelTitle2.bottomAnchor, constant: 15),
            allMatchesPrevTB.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor),
            allMatchesPrevTB.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor),
            allMatchesPrevTB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

    
        ])


        
    }
    
    func loadMatchesNext() {
        
        let participant1 = MatchParticipant(firstName: "Mariano", lastName: "Balarino", profilePicture: "person1", points: ["-","-","-"])
        let participant2 = MatchParticipant(firstName: "Ezequiel", lastName: "Martinez", profilePicture: "person2", points: ["-","-","-"])
        
        matchesNext.append(AllMatches(nameTour: "Torneo Club Mitre", dateTour: "21-09-2021", detailTour: "Zona de Grupos - Grupo A - Jornada 1 de 3", participant: [participant1,participant2]))
        
        allMatchesNextTB.reloadData()
        
    }
    
    func loadMatchesPrev() {
        
        let participant1 = MatchParticipant(firstName: "Javier", lastName: "Belvedere", profilePicture: "person3", points: ["3","6","4"])
        
        let participant2 = MatchParticipant(firstName: "Ezequiel", lastName: "Martinez", profilePicture: "person2", points: ["6","2","6"])
        
        let participant3 = MatchParticipant(firstName: "Jonatan", lastName: "Dalinger", profilePicture: "person4", points: ["8","6","8"])
        
        matchesPrev.append(AllMatches(nameTour: "Torneo Club Devoto", dateTour: "20-05-2021", detailTour: "Zona de Grupos - Grupo B - Jornada 1 de 3", participant: [participant1,participant2]))
        
        matchesPrev.append(AllMatches(nameTour: "Torneo Club Agronomia", dateTour: "21-05-2021", detailTour: "Zona de Grupos - Grupo B - Jornada 2 de 3", participant: [participant2,participant3]))
        
        allMatchesPrevTB.reloadData()
        
    }
    

    @objc func nextAction() {
        
        nextMatchButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        historyMatchButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        uViewScrollView.isHidden = false
        uViewScrollView1.isHidden = true
        
    }
    
    @objc func historyAction() {
        
        nextMatchButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        historyMatchButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        uViewScrollView.isHidden = true
        uViewScrollView1.isHidden = false
        
    }

}

extension MatchesVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0
        
        if tableView == allMatchesNextTB {
            countTable = matchesNext.count
        }

        if tableView == allMatchesPrevTB {
            countTable = matchesPrev.count
        }
        return countTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        
        if tableView == allMatchesNextTB {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MatchesTableCell

            myCell.labelTorneo.text = matchesNext[indexPath.row].nameTour
            myCell.labelDate.text = matchesNext[indexPath.row].dateTour
            myCell.labelDatails.text = matchesNext[indexPath.row].detailTour
            myCell.labelName.text = matchesNext[indexPath.row].participant[0].firstName
            myCell.labelLastname.text = matchesNext[indexPath.row].participant[0].lastName
            myCell.labelName1.text = matchesNext[indexPath.row].participant[1].firstName
            myCell.labelLastname1.text = matchesNext[indexPath.row].participant[1].lastName
            myCell.imagePhotoHeader.image = UIImage(named: matchesNext[indexPath.row].participant[0].profilePicture)
            myCell.imagePhotoHeader1.image = UIImage(named: matchesNext[indexPath.row].participant[1].profilePicture)
            
            let dataArray = matchesNext[indexPath.row].participant[0].points
            myCell.updateCellWith(row: dataArray)
            
            let dataArray1 = matchesNext[indexPath.row].participant[1].points
            myCell.updateCellWith1(row: dataArray1)
            
            returnCell = myCell
        }
        
        if tableView == allMatchesPrevTB {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MatchesTableCell

            myCell.labelTorneo.text = matchesPrev[indexPath.row].nameTour
            myCell.labelDate.text = matchesPrev[indexPath.row].dateTour
            myCell.labelDatails.text = matchesPrev[indexPath.row].detailTour
            myCell.labelName.text = matchesPrev[indexPath.row].participant[0].firstName
            myCell.labelLastname.text = matchesPrev[indexPath.row].participant[0].lastName
            myCell.labelName1.text = matchesPrev[indexPath.row].participant[1].firstName
            myCell.labelLastname1.text = matchesPrev[indexPath.row].participant[1].lastName
            myCell.imagePhotoHeader.image = UIImage(named: matchesPrev[indexPath.row].participant[0].profilePicture)
            myCell.imagePhotoHeader1.image = UIImage(named: matchesPrev[indexPath.row].participant[1].profilePicture)
            
            let dataArray = matchesPrev[indexPath.row].participant[0].points
            myCell.updateCellWith(row: dataArray)
            
            let dataArray1 = matchesPrev[indexPath.row].participant[1].points
            myCell.updateCellWith1(row: dataArray1)
            
            returnCell = myCell
        }
        

        return returnCell
    }
    
    
}
