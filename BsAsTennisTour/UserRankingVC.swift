//
//  UserRankingVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 28/11/2020.
//

import UIKit
import HGCircularSlider

class UserRankingVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate {
    
    var allTrophys = ["Torneo Relampago", "Torneo Invierno ", "Torneo Roger"]
    var allPositions = ["1","2","3"]
    
    var maxexp = 600
    var cantlevels = 6
    var totalexp = 230
    
    var allExperienceNames = ["Año Entrenamiento Academy","Torneos Ganados","Participacion Torneo","Participacion Torneo","Bonificacion"]
    var allExperience = ["80","60","40","40","10"]
    
    var rankingPosition = "5"
    var rankingPoints = "80"
    
    
    let titleMain : UILabel = {
        let label = UILabel()
        label.text = "Mis Estadisticas"
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleNameUser : UILabel = {
        let label = UILabel()
        label.text = "Ezequiel Martinez"
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileIcon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "statsIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let uView1 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "tenisStats-2")
        image.alpha = 0.9
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let uView2 : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 60
        view.layer.shadowRadius = 60
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewLeft : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewRight : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelLevel : UILabel = {
        let label = UILabel()
        label.text = "Nivel"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelNivel : UILabel = {
        let label = UILabel()
        label.textColor = .mainFacebook
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0 // or 1
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelProxLevel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let circularExp : CircularSlider = {
        let circle = CircularSlider()
        circle.minimumValue = 0.0
        circle.diskColor = .mainGreen
        circle.trackColor = .lightGray
        circle.trackFillColor = .mainFacebook
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.lineWidth = 7
        circle.backgroundColor = UIColor.white.withAlphaComponent(0)
        circle.isOpaque = false
        circle.thumbLineWidth = 0
        circle.thumbRadius = 0
        return circle
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .mainGray
        view.autoresizingMask = .flexibleHeight
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.isExclusiveTouch = true
        view.canCancelContentTouches = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGray
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let uViewTable1 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewLineTable1 : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allTrophysTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .lightGray
        table.separatorColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyTrophysCell.self, forCellReuseIdentifier: "cellTable")
        table.rowHeight = 40
        table.allowsSelection = false
       return table
    }()
    
    let labelTrophys : UILabel = {
        let label = UILabel()
        label.text = "Mis Trofeos"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let allExpTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .lightGray
        table.separatorColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyExpCell.self, forCellReuseIdentifier: "cellTable")
        table.rowHeight = 40
        table.allowsSelection = false
       return table
    }()

    
    private let uViewTable2 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewLineTable2 : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelExperience : UILabel = {
        let label = UILabel()
        label.text = "Mi Experiencia"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTotalExp : UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let uViewTable3 : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewLineTable3 : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewLineTable3Vertical : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelStats : UILabel = {
        let label = UILabel()
        label.text = "Mi Ranking"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let uViewLeftTable3 : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let uViewRightTable3 : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelRankingPosition : UILabel = {
        let label = UILabel()
        label.textColor = .mainFacebook
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0 // or 1
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelRankingPoints : UILabel = {
        let label = UILabel()
        label.textColor = .mainFacebook
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0 // or 1
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelRankPosicion: UILabel = {
          let label = UILabel()
          label.text = "Posicion"
          label.textAlignment = .center
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 14)
          label.adjustsFontSizeToFitWidth = true
          label.minimumScaleFactor = 0.2
          label.numberOfLines = 0 // or 1
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelRankPuntos: UILabel = {
          let label = UILabel()
          label.text = "Puntos"
          label.textAlignment = .center
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 14)
          label.adjustsFontSizeToFitWidth = true
          label.minimumScaleFactor = 0.2
          label.numberOfLines = 0 // or 1
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarItemLoad()
        setupLayout()
        calculateExperience()
        calculateRanking()
    }
    

   
    func navBarItemLoad(){
        view.backgroundColor = .mainGray
        let vw = UIView()
        vw.isUserInteractionEnabled = true
        vw.addSubview(titleMain)
        
        let menuBarItem = UIBarButtonItem(customView: profileIcon)
   
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
       
        vw.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = vw
            
        titleMain.centerXAnchor.constraint(equalTo: vw.centerXAnchor).isActive = true
        titleMain.centerYAnchor.constraint(equalTo: vw.centerYAnchor).isActive = true
    }
    
    func setupLayout() {
        
        view.addSubview(uView1)
        view.addSubview(uViewLeft)
        view.addSubview(uViewRight)
        uView1.addSubview(backgroundImage)
        uView1.addSubview(titleNameUser)
        view.addSubview(uView2)
        uView2.addSubview(circularExp)
        uView2.addSubview(labelProxLevel)
        uView2.addSubview(labelNivel)
        view.addSubview(labelLevel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(uViewTable1)
        contentView.addSubview(uViewTable2)
        contentView.addSubview(uViewTable3)
        
        uViewTable1.addSubview(allTrophysTable)
        uViewTable1.addSubview(uViewLineTable1)
        uViewTable1.addSubview(labelTrophys)
        
        uViewTable2.addSubview(allExpTable)
        uViewTable2.addSubview(uViewLineTable2)
        uViewTable2.addSubview(labelExperience)
        uViewTable2.addSubview(labelTotalExp)
        
        uViewTable3.addSubview(uViewLineTable3)
        uViewTable3.addSubview(labelStats)
        uViewTable3.addSubview(uViewLeftTable3)
        uViewTable3.addSubview(uViewRightTable3)
        uViewTable3.addSubview(uViewLineTable3Vertical)

        uViewLeft.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        uViewLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uViewLeft.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        uViewRight.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        uViewRight.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uViewRight.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        uView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        uView1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uView1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uView1.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        uViewLeft.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        uViewLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uViewLeft.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        titleNameUser.centerYAnchor.constraint(equalTo: uView1.centerYAnchor).isActive = true
        titleNameUser.centerXAnchor.constraint(equalTo: uView1.centerXAnchor).isActive = true
        
        backgroundImage.topAnchor.constraint(equalTo: uView1.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: uView1.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: uView1.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: uView1.bottomAnchor).isActive = true
        
        uView2.centerYAnchor.constraint(equalTo: uView1.bottomAnchor).isActive = true
        uView2.centerXAnchor.constraint(equalTo: uViewRight.centerXAnchor).isActive = true
        uView2.heightAnchor.constraint(equalToConstant: 140).isActive = true
        uView2.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        circularExp.topAnchor.constraint(equalTo: uView2.topAnchor).isActive = true
        circularExp.leadingAnchor.constraint(equalTo: uView2.leadingAnchor).isActive = true
        circularExp.trailingAnchor.constraint(equalTo: uView2.trailingAnchor).isActive = true
        circularExp.bottomAnchor.constraint(equalTo: uView2.bottomAnchor).isActive = true
        
        labelProxLevel.topAnchor.constraint(equalTo: circularExp.bottomAnchor).isActive = true
        labelProxLevel.centerXAnchor.constraint(equalTo: circularExp.centerXAnchor).isActive = true
        
        labelNivel.centerXAnchor.constraint(equalTo: uView2.centerXAnchor).isActive = true
        labelNivel.centerYAnchor.constraint(equalTo: uView2.centerYAnchor).isActive = true
        
        labelLevel.topAnchor.constraint(equalTo: uView1.bottomAnchor, constant: 10).isActive = true
        labelLevel.centerXAnchor.constraint(equalTo: uViewLeft.centerXAnchor).isActive = true
        labelLevel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        scrollView.delegate = self
        scrollView.topAnchor.constraint(equalTo: circularExp.bottomAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        
        uViewTable1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        uViewTable1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        uViewTable1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        uViewTable1.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        labelTrophys.topAnchor.constraint(equalTo: uViewTable1.topAnchor, constant: 10).isActive = true
        labelTrophys.leadingAnchor.constraint(equalTo: uViewTable1.leadingAnchor, constant: 10).isActive = true
        labelTrophys.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        uViewLineTable1.topAnchor.constraint(equalTo: labelTrophys.bottomAnchor,constant: 5).isActive = true
        uViewLineTable1.leadingAnchor.constraint(equalTo: uViewTable1.leadingAnchor).isActive = true
        uViewLineTable1.trailingAnchor.constraint(equalTo: uViewTable1.trailingAnchor).isActive = true
        uViewLineTable1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        allTrophysTable.delegate = self
        allTrophysTable.dataSource = self
        
        allTrophysTable.topAnchor.constraint(equalTo: uViewLineTable1.bottomAnchor,constant: 5).isActive = true
        allTrophysTable.leadingAnchor.constraint(equalTo: uViewTable1.leadingAnchor).isActive = true
        allTrophysTable.trailingAnchor.constraint(equalTo: uViewTable1.trailingAnchor).isActive = true
        allTrophysTable.bottomAnchor.constraint(equalTo: uViewTable1.bottomAnchor).isActive = true
        
        uViewTable2.topAnchor.constraint(equalTo: uViewTable1.bottomAnchor,constant: 20).isActive = true
        uViewTable2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        uViewTable2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        uViewTable2.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        labelExperience.topAnchor.constraint(equalTo: uViewTable2.topAnchor, constant: 10).isActive = true
        labelExperience.leadingAnchor.constraint(equalTo: uViewTable2.leadingAnchor, constant: 10).isActive = true
        labelExperience.heightAnchor.constraint(equalToConstant: 30).isActive = true

        uViewLineTable2.topAnchor.constraint(equalTo: labelExperience.bottomAnchor,constant: 5).isActive = true
        uViewLineTable2.leadingAnchor.constraint(equalTo: uViewTable2.leadingAnchor).isActive = true
        uViewLineTable2.trailingAnchor.constraint(equalTo: uViewTable2.trailingAnchor).isActive = true
        uViewLineTable2.heightAnchor.constraint(equalToConstant: 1).isActive = true

        allExpTable.delegate = self
        allExpTable.dataSource = self

        allExpTable.topAnchor.constraint(equalTo: uViewLineTable2.bottomAnchor,constant: 5).isActive = true
        allExpTable.leadingAnchor.constraint(equalTo: uViewTable2.leadingAnchor).isActive = true
        allExpTable.trailingAnchor.constraint(equalTo: uViewTable2.trailingAnchor).isActive = true
        allExpTable.bottomAnchor.constraint(equalTo: uViewTable2.bottomAnchor).isActive = true
        
        labelTotalExp.topAnchor.constraint(equalTo: uViewTable2.topAnchor,constant: 10).isActive = true
        labelTotalExp.trailingAnchor.constraint(equalTo: uViewTable2.trailingAnchor,constant: -20).isActive = true
        labelTotalExp.heightAnchor.constraint(equalToConstant: 25).isActive = true

        uViewTable3.topAnchor.constraint(equalTo: uViewTable2.bottomAnchor,constant: 20).isActive = true
        uViewTable3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        uViewTable3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        uViewTable3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        uViewTable3.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        labelStats.topAnchor.constraint(equalTo: uViewTable3.topAnchor, constant: 10).isActive = true
        labelStats.leadingAnchor.constraint(equalTo: uViewTable3.leadingAnchor, constant: 10).isActive = true
        labelStats.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        uViewLineTable3.topAnchor.constraint(equalTo: labelStats.bottomAnchor,constant: 5).isActive = true
        uViewLineTable3.leadingAnchor.constraint(equalTo: uViewTable3.leadingAnchor).isActive = true
        uViewLineTable3.trailingAnchor.constraint(equalTo: uViewTable3.trailingAnchor).isActive = true
        uViewLineTable3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        uViewLineTable3Vertical.centerXAnchor.constraint(equalTo: uViewTable3.centerXAnchor).isActive = true
        uViewLineTable3Vertical.topAnchor.constraint(equalTo: uViewLineTable3.bottomAnchor).isActive = true
        uViewLineTable3Vertical.bottomAnchor.constraint(equalTo: uViewTable3.bottomAnchor).isActive = true
        uViewLineTable3Vertical.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        uViewLeftTable3.topAnchor.constraint(equalTo: uViewLineTable3.bottomAnchor).isActive = true
        uViewLeftTable3.leadingAnchor.constraint(equalTo: uViewTable3.leadingAnchor).isActive = true
        uViewLeftTable3.trailingAnchor.constraint(equalTo: uViewLineTable3Vertical.trailingAnchor).isActive = true
        uViewLeftTable3.bottomAnchor.constraint(equalTo: uViewTable3.bottomAnchor).isActive = true
        
        uViewRightTable3.topAnchor.constraint(equalTo: uViewLineTable3.bottomAnchor).isActive = true
        uViewRightTable3.leadingAnchor.constraint(equalTo: uViewLineTable3Vertical.leadingAnchor).isActive = true
        uViewRightTable3.trailingAnchor.constraint(equalTo: uViewTable3.trailingAnchor).isActive = true
        uViewRightTable3.bottomAnchor.constraint(equalTo: uViewTable3.bottomAnchor).isActive = true
        
        uViewLeftTable3.addSubview(labelRankingPosition)
        uViewRightTable3.addSubview(labelRankingPoints)
        uViewRightTable3.addSubview(labelRankPuntos)
        uViewLeftTable3.addSubview(labelRankPosicion)
        
        labelRankingPosition.widthAnchor.constraint(equalTo: uViewLeftTable3.widthAnchor).isActive = true
        labelRankingPosition.centerXAnchor.constraint(equalTo: uViewLeftTable3.centerXAnchor).isActive = true
        labelRankingPosition.centerYAnchor.constraint(equalTo: uViewLeftTable3.centerYAnchor).isActive = true
        
        labelRankPosicion.widthAnchor.constraint(equalTo: uViewLeftTable3.widthAnchor).isActive = true
        labelRankPosicion.centerXAnchor.constraint(equalTo: uViewLeftTable3.centerXAnchor).isActive = true
        labelRankPosicion.bottomAnchor.constraint(equalTo: labelRankingPosition.topAnchor, constant: 10).isActive = true

        labelRankingPoints.widthAnchor.constraint(equalTo: uViewRightTable3.widthAnchor).isActive = true
        labelRankingPoints.centerXAnchor.constraint(equalTo: uViewRightTable3.centerXAnchor).isActive = true
        labelRankingPoints.centerYAnchor.constraint(equalTo: uViewRightTable3.centerYAnchor).isActive = true
        
        labelRankPuntos.bottomAnchor.constraint(equalTo: labelRankingPoints.topAnchor, constant: 10).isActive = true
        labelRankPuntos.widthAnchor.constraint(equalTo: uViewRightTable3.widthAnchor).isActive = true
        labelRankPuntos.centerXAnchor.constraint(equalTo: uViewRightTable3.centerXAnchor).isActive = true




    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countCells = 0
        
        if tableView == allTrophysTable {
            countCells = allTrophys.count
        }
        if tableView == allExpTable {
            countCells = allExperience.count
        }
       
        return countCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        
        if tableView == allTrophysTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! MyTrophysCell
            myCell.labelName.text = allPositions[indexPath.row] + "° - " + allTrophys[indexPath.row]
            if allPositions[indexPath.row] == "1" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "medal1")
            }
            if allPositions[indexPath.row] == "2" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "medal2")
            }
            if allPositions[indexPath.row] == "3" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "medal3")
            }
            returnCell = myCell
        }
        
        if tableView == allExpTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! MyExpCell
            myCell.labelName.text = "\(allExperienceNames[indexPath.row]) - \(allExperience[indexPath.row])exp"
            returnCell = myCell
        }
        
    
        return returnCell
    }
    

    func calculateExperience() {

        let difference = maxexp / cantlevels
        circularExp.maximumValue = CGFloat(difference)
        
        let nivel = Int(totalexp / difference) + 1
        labelNivel.text = "\(nivel)"
        
        let expNivel = totalexp - ((nivel - 1) * difference)
        circularExp.endPointValue = CGFloat(expNivel)
        
        let restExp = difference - expNivel
        
        labelProxLevel.text = "Next +\(restExp)Exp"
        labelTotalExp.text = "\(totalexp)Exp"
        
        if totalexp == maxexp {
            labelNivel.textColor = .mainOrange
            circularExp.trackColor = .mainOrange
        }
   
    }
    
    func calculateRanking() {
        
        labelRankingPosition.text = "#\(rankingPosition)"
        labelRankingPoints.text = "\(rankingPoints)"
        
    }


}
