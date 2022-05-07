//
//  MatchesVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 15/05/2021.
//

import UIKit
import FirebaseDatabase

class MatchesVC: UIViewController {
    
    var nextMatches : [Match] = []
    var myMatches : [Match] = []
    let admin = UserDefaults.standard.string(forKey: "ADMIN")
    
    var ref: DatabaseReference!
    
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
    
    private let buttonShowMoreNext : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "arrow-down.png")
    
        button.setImage(UIImage(named: "arrow-down.png"), for: .normal)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.setTitle("AGREGAR MAS PARTIDOS", for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.colorGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(moreGamesNext), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarItemLoad()
        setupLayout()
        loadMatchesPrev()
        NotificationCenter.default.addObserver(self, selector: #selector(loadMatchesNext), name: NSNotification.Name(rawValue: "LoadMatchTour"), object: nil)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.post(name: Notification.Name("LoadMatchTour"), object: nil)
    }
    
    func navBarItemLoad(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .colorCoal
        appearance.shadowColor = .colorCoal
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
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
        uViewScrollView.addSubview(buttonShowMoreNext)
        buttonShowMoreNext.imageEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
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
            allMatchesNextTB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
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
            allMatchesPrevTB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -70),
            
            buttonShowMoreNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            buttonShowMoreNext.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor, constant: 20),
            buttonShowMoreNext.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor, constant: -20),
            buttonShowMoreNext.heightAnchor.constraint(equalToConstant: 40),

    
        ])


        
    }
    
    @objc func loadMatchesNext() {
        
        nextMatches.removeAll()
        
        ref = Database.database().reference().child("Matchs/")
        ref.observeSingleEvent(of: .value, with: { [self] (snapshot) in
            
            if snapshot.exists() {
                let today = Date()
                if let allData = snapshot.children.allObjects as? [DataSnapshot] {
                    for data in allData {
                        let dateTour = self.convertStringToDate(dateString: data.key)
                        let dateArg = self.changeDateToArg(dateString: data.key)
                        if dateTour <= today {
                            if let allNames = data.children.allObjects as? [DataSnapshot] {
                                for names in allNames {
                                    if let allZonas = names.children.allObjects as? [DataSnapshot] {
                                        for zona in allZonas {
                                            if let allMatches = zona.children.allObjects as? [DataSnapshot] {
                                                for match in allMatches {
                                                    var addPlayer : [PlayerLlave] = []
                                                    if let allPlayers = match.children.allObjects as? [DataSnapshot] {
                                                        for player in allPlayers {
                                                            var fullName : String = "-"
                                                            var win : Bool = false
                                                            var picture : String = "perfilIcon"
                                                            var SETS : [String] = []
                                                            if let allInfo = player.children.allObjects as? [DataSnapshot] {
                                                                for info in allInfo {
                                                                    
                                                                    if info.key == "fullName" {
                                                                        fullName = info.value as? String ?? "-"
                                                                    }
                                                                    
                                                                    if info.key == "win" {
                                                                        win = info.value as? Bool ?? false
                                                                    }
                                                                    
                                                                    if info.key == "picture" {
                                                                        picture = info.value as? String ?? "-"
                                                                    }
                                                                    
                                                                    if info.key == "SET" {
                                                                        if let allSETS = info.children.allObjects as? [DataSnapshot] {
                                                                            for set in allSETS {
                                                                                SETS.append(set.value as? String ?? "0")
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            addPlayer.append(PlayerLlave(match: zona.key, id: match.key, fullName: fullName, picture: picture, win: win, set: SETS))
                                                        }
                                                    }
                                                    if !addPlayer.isEmpty {
                                                        nextMatches.append(Match(name: names.key, day: dateArg, player1: addPlayer[0], player2: addPlayer[1]))
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.allMatchesNextTB.reloadData()
        })
    }
    
    func loadMatchesPrev() {
        
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
    
    
    @objc func moreGamesNext() {
        
        buttonShowMoreNext.isHidden = true
        allMatchesNextTB.reloadData()
    }

}

extension MatchesVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0
        
        if tableView == allMatchesNextTB {
            countTable = nextMatches.count
        }

        if tableView == allMatchesPrevTB {
            countTable = myMatches.count
        }
        return countTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        
        if tableView == allMatchesNextTB {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MatchesTableCell

            var detail : String = ""
            let zonaOrLlave = nextMatches[indexPath.row].player1.match
            if zonaOrLlave.contains("Zona") {
                detail = "Zona de Grupos - \(zonaOrLlave)"
            }else{
                detail = "Llaves - \(zonaOrLlave)"
            }
            
            let (firstname1,lastname1) = NameDivisor(fullName: nextMatches[indexPath.row].player1.fullName)
            let (firstname2,lastname2) = NameDivisor(fullName: nextMatches[indexPath.row].player2.fullName)
            
            let imageUrl1 = URL(string:nextMatches[indexPath.row].player1.picture)
            let imageUrl2 = URL(string:nextMatches[indexPath.row].player2.picture)

            myCell.labelTorneo.text = nextMatches[indexPath.row].name
            myCell.labelDate.text = nextMatches[indexPath.row].day
            myCell.labelDatails.text = detail
            myCell.labelName.text = firstname1
            myCell.labelLastname.text = lastname1
            myCell.labelName1.text = firstname2
            myCell.labelLastname1.text = lastname2
            myCell.imagePhotoHeader.sd_setImage(with: imageUrl1, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
            myCell.imagePhotoHeader1.sd_setImage(with: imageUrl2, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
            myCell.imageBallPlayer1.isHidden = !nextMatches[indexPath.row].player1.win
            myCell.imageBallPlayer2.isHidden = !nextMatches[indexPath.row].player2.win
            
            let dataArray = nextMatches[indexPath.row].player1.set
            myCell.updateCellWith(row: dataArray)
            
            let dataArray1 = nextMatches[indexPath.row].player2.set
            myCell.updateCellWith1(row: dataArray1)
            
            returnCell = myCell
        }
        
        if tableView == allMatchesPrevTB {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MatchesTableCell

            var detail : String = ""
            let zonaOrLlave = myMatches[indexPath.row].player1.match
            if zonaOrLlave.contains("ZONA") {
                detail = "Zona de Grupos - \(zonaOrLlave)"
            }else{
                detail = "Llaves - \(zonaOrLlave)"
            }
            
            let (firstname1,lastname1) = NameDivisor(fullName: myMatches[indexPath.row].player1.fullName)
            let (firstname2,lastname2) = NameDivisor(fullName: myMatches[indexPath.row].player2.fullName)
            
            let imageUrl1 = URL(string:myMatches[indexPath.row].player1.picture)
            let imageUrl2 = URL(string:myMatches[indexPath.row].player2.picture)

            myCell.labelTorneo.text = myMatches[indexPath.row].name
            myCell.labelDate.text = myMatches[indexPath.row].day
            myCell.labelDatails.text = detail
            myCell.labelName.text = firstname1
            myCell.labelLastname.text = lastname1
            myCell.labelName1.text = firstname2
            myCell.labelLastname1.text = lastname2
            myCell.imagePhotoHeader.sd_setImage(with: imageUrl1, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
            myCell.imagePhotoHeader1.sd_setImage(with: imageUrl2, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
            myCell.imageBallPlayer1.isHidden = !myMatches[indexPath.row].player1.win
            myCell.imageBallPlayer2.isHidden = !myMatches[indexPath.row].player2.win
            
            let dataArray = myMatches[indexPath.row].player1.set
            myCell.updateCellWith(row: dataArray)
            
            let dataArray1 = myMatches[indexPath.row].player2.set
            myCell.updateCellWith1(row: dataArray1)
            
            returnCell = myCell
        }
        

        return returnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if admin == "YES-1" {
            if tableView == allMatchesNextTB {
                
                let dayUS = changeDateToUS(dateString: nextMatches[indexPath.row].day)
                
                let path = "Matchs/\(dayUS)/\(nextMatches[indexPath.row].name)/\(nextMatches[indexPath.row].player1.match)/\(nextMatches[indexPath.row].player1.id)"
                let pathPlayers = "Torneos/\(dayUS)/\(nextMatches[indexPath.row].name)/Players/"
                
                UserDefaults.standard.set(path, forKey: "pathMatch")
                UserDefaults.standard.set(nextMatches[indexPath.row].player1.match,forKey: "nameLlave")
                UserDefaults.standard.set(pathPlayers,forKey: "pathPlayers")
                UserDefaults.standard.synchronize()
                
                
                let vc = AdminChangesMatchsVC()
                vc.modalPresentationStyle = .pageSheet
                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
    
    
}
