//
//  InscriptionsVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit

class InscriptionsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
 
    var allNames = [Users]()
    var allData = [AllParticipants]()
    var allInfo = [String]()
    var allTitles = ["Fecha","Horario","Sede","Ubicacion","Modalidad","Precio","Partidos Asegurados"]
    var allPointsName = ["Campeon","SubCampeon","Semifinales","Cuartos","Partido Ganado","Inscripcion"]
    var allPoints = ["120","60","30","15","10","5"]
    var collapsedPoints : Bool = false
    var collapsedInfo : Bool = true
    
    let buttonMenu : UIButton = {
         let button = UIButton(type: .custom)
         button.frame = CGRect(x: 0.0,y: 0.0, width: 40, height: 40)
         let origImage = UIImage(named: "leftArrowWhite")
         let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
         button.setImage(tintedImage, for: .normal)
         button.tintColor = .white
         return button
     }()

    let titleTorneo : UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "nameTour")?.uppercased()
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 25)!
        label.textColor = .white
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTorneo2 : UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "placeTour")?.uppercased()
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Bold", size: 25)!
        label.textColor = .white
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let infoButton : UIButton = {
        let button = UIButton()
        button.setTitle("INFORMACION", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPop
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let cuadroButton : UIButton = {
        let button = UIButton()
        button.setTitle("CUADRO", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(cuadroAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton2 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPaper
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.autoresizingMask = .flexibleHeight
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.isExclusiveTouch = true
        view.canCancelContentTouches = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let scrollView1: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.autoresizingMask = .flexibleHeight
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.isHidden = true
        view.isExclusiveTouch = true
        view.canCancelContentTouches = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let uViewScrollView : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uViewScrollView1 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView0 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView1 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView2 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView3 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView4 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView5 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.colorCoal.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
 
    private let trophyImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "trophy")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let torneoInfoTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .darkGray
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TorneoInfoCell.self, forCellReuseIdentifier: "secondCell")
        table.rowHeight = 30
        table.allowsSelection = false
        table.isHidden = true
       return table
    }()
    
    
    private let allUsersTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .white
        table.separatorColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(InscriptionsCell.self, forCellReuseIdentifier: "firstCell")
        table.rowHeight = 120
//        table.sectionHeaderHeight = 30
        table.allowsSelection = true
        table.isHidden = true
       return table
    }()
    
    private let allPointsTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .darkGray
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PointsCell.self, forCellReuseIdentifier: "thirdCell")
        table.rowHeight = 30
//        table.sectionHeaderHeight = 30
        table.allowsSelection = false
        table.isHidden = true
       return table
    }()
    
    
    let labelParticipants: UILabel = {
          let label = UILabel()
          label.text = "JUGADORES"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPuntuacion: UILabel = {
          let label = UILabel()
          label.text = "PUNTUACIONES"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelDatos: UILabel = {
          let label = UILabel()
          label.text = "DATOS"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelZonas: UILabel = {
          let label = UILabel()
          label.text = "ZONAS"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLlaves: UILabel = {
          let label = UILabel()
          label.text = "LLAVES"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelFinal: UILabel = {
          let label = UILabel()
          label.text = "FINAL"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let buttonPlusMinus : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return button
    }()
    
    let buttonPlusMinus1 : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExpandClose1), for: .touchUpInside)
        return button
    }()
    
    let buttonPlusMinus2 : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleExpandClose2), for: .touchUpInside)
        return button
    }()
    
    let buttonZonas : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
    //    button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return button
    }()
    
    let buttonLlaves : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
   //     button.addTarget(self, action: #selector(handleExpandClose1), for: .touchUpInside)
        return button
    }()
    
    let buttonFinal : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
  //      button.addTarget(self, action: #selector(handleExpandClose2), for: .touchUpInside)
        return button
    }()
    
    private let buttonRegister : UIButton = {
        let button = UIButton()
        button.setTitle("INSCRIBIRSE", for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        button.layer.backgroundColor = UIColor.colorPop.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(registerTour), for: .touchUpInside)
        return button
    }()
    
    var topAnchorView : NSLayoutConstraint?
    var topAnchorTable : NSLayoutConstraint?
    
    var topAnchorView1 : NSLayoutConstraint?
    var topAnchorTable1 : NSLayoutConstraint?
    
    var topAnchorView2 : NSLayoutConstraint?
    var topAnchorView3 : NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

         allNames.append(Users(name: "Mariano",lastname: "BALARINO",imageprofile: "person1",score: "12 - 4 - 0",position: "1ER LUGAR",points: "2081 PTS"))
         allNames.append(Users(name: "Martin",lastname: "RIOSECO",imageprofile: "person2",score: "11 - 5 - 0",position: "2DO LUGAR",points: "1834 PTS"))
         allNames.append(Users(name: "Javier",lastname: "BELVEDERE",imageprofile: "person3",score: "9 - 7 - 0",position: "3ER LUGAR",points: "1788 PTS"))
         allNames.append(Users(name: "Ezequiel",lastname: "MARTINEZ",imageprofile: "person4",score: "8 - 8 - 0",position: "4TO LUGAR",points: "1549 PTS"))

         allData = [AllParticipants(allUsers: allNames, collapsed : false, maxParticipants: 16)]
        
        let data1 = UserDefaults.standard.string(forKey: "dateTour")!
        allInfo.append(data1)
        allInfo.append("12:00PM")
        allInfo.append("Club Mitre")
        allInfo.append("Ver Ubicacion")
        allInfo.append("Single Mixto")
        allInfo.append("1200")
        allInfo.append("4")
        setupBarItem()
        setupLayout()
    }
    
    func setupBarItem() {
        
        self.tabBarController?.tabBar.items?[0].title = "Torneo"
        let imageName = "tournament"
        let image = UIImage(named: imageName)
        let image2 = image?.imageResized(to: CGSize(width: 35, height: 35))
        image2?.withTintColor(.white)
        self.tabBarController?.tabBar.items?[0].selectedImage = image2?.withRenderingMode(.alwaysOriginal)
 
        let menuBarItem = UIBarButtonItem(customView: buttonMenu)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
      //  self.navigationController?.navigationBar.barTintColor = .colorCoal
      //  self.navigationController?.navigationBar.isTranslucent = false
        
        buttonMenu.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }

    func setupLayout() {
        
        view.backgroundColor = .mainGray
        view.addSubview(viewContainer)
        
        viewContainer.addSubview(titleTorneo)
        viewContainer.addSubview(titleTorneo2)
        viewContainer.addSubview(uViewBackgroundLeft)
        viewContainer.addSubview(uViewBackgroundRight)
        view.addSubview(infoButton)
        uViewBackgroundLeft.addSubview(lineButton1)
        view.addSubview(cuadroButton)
        uViewBackgroundRight.addSubview(lineButton2)
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(uViewScrollView)
        view.addSubview(scrollView1)
        scrollView1.delegate = self
        scrollView1.addSubview(uViewScrollView1)
        
        uViewScrollView.addSubview(uView0)
        uView0.addSubview(labelDatos)
        uViewScrollView.addSubview(buttonPlusMinus2)
        uViewScrollView.addSubview(torneoInfoTable)
        
        uViewScrollView.addSubview(uView1)
        uView1.addSubview(labelParticipants)
        uViewScrollView.addSubview(buttonPlusMinus)
        uViewScrollView.addSubview(allUsersTable)
        
        uViewScrollView.addSubview(uView2)
        uView2.addSubview(labelPuntuacion)
        uViewScrollView.addSubview(buttonPlusMinus1)
        uViewScrollView.addSubview(allPointsTable)
        
        uViewScrollView.addSubview(trophyImage)
        uViewScrollView.addSubview(buttonRegister)
        
        uViewScrollView1.addSubview(uView3)
        uViewScrollView1.addSubview(uView4)
        uViewScrollView1.addSubview(uView5)
        uView3.addSubview(labelZonas)
        uView4.addSubview(labelLlaves)
        uView5.addSubview(labelFinal)
        uViewScrollView1.addSubview(buttonZonas)
        uViewScrollView1.addSubview(buttonLlaves)
        uViewScrollView1.addSubview(buttonFinal)

        //CONSTRAINTS
        
        NSLayoutConstraint.activate([
        
            
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.heightAnchor.constraint(equalToConstant: 180),
            
            titleTorneo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            titleTorneo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            
            titleTorneo2.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            titleTorneo2.topAnchor.constraint(equalTo: titleTorneo.bottomAnchor, constant: 5),
            
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
            
            infoButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor),
            infoButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            infoButton.heightAnchor.constraint(equalToConstant: 15),
            infoButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor),
            
            lineButton2.leadingAnchor.constraint(equalTo: uViewBackgroundRight.leadingAnchor, constant: 20),
            lineButton2.trailingAnchor.constraint(equalTo: uViewBackgroundRight.trailingAnchor, constant: -20),
            lineButton2.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            lineButton2.heightAnchor.constraint(equalToConstant: 3),
            
            cuadroButton.centerXAnchor.constraint(equalTo: uViewBackgroundRight.centerXAnchor),
            cuadroButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10),
            cuadroButton.heightAnchor.constraint(equalToConstant: 15),
            cuadroButton.widthAnchor.constraint(equalTo: uViewBackgroundRight.widthAnchor),
  
            scrollView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView1.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uViewScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            uViewScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            uViewScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            uViewScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            uViewScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            uView0.topAnchor.constraint(equalTo: uViewScrollView.topAnchor,constant: 20),
            uView0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uView0.heightAnchor.constraint(equalToConstant: 60),
            
            labelDatos.centerYAnchor.constraint(equalTo: uView0.centerYAnchor),
            labelDatos.leadingAnchor.constraint(equalTo: uView0.leadingAnchor, constant: 30),
            
            buttonPlusMinus2.heightAnchor.constraint(equalToConstant: 25),
            buttonPlusMinus2.widthAnchor.constraint(equalToConstant: 25),
            buttonPlusMinus2.centerYAnchor.constraint(equalTo: uView0.centerYAnchor),
            buttonPlusMinus2.trailingAnchor.constraint(equalTo: uView0.trailingAnchor, constant: -25),
            
            torneoInfoTable.topAnchor.constraint(equalTo: uView0.bottomAnchor),
            torneoInfoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            torneoInfoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            torneoInfoTable.heightAnchor.constraint(equalToConstant: 220),
            
            uViewScrollView1.centerXAnchor.constraint(equalTo: scrollView1.centerXAnchor),
            uViewScrollView1.topAnchor.constraint(equalTo: scrollView1.topAnchor),
            uViewScrollView1.leadingAnchor.constraint(equalTo: scrollView1.leadingAnchor),
            uViewScrollView1.trailingAnchor.constraint(equalTo: scrollView1.trailingAnchor),
            uViewScrollView1.bottomAnchor.constraint(equalTo: scrollView1.bottomAnchor),
            
            uView3.topAnchor.constraint(equalTo: uViewScrollView1.topAnchor,constant: 20),
            uView3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uView3.heightAnchor.constraint(equalToConstant: 60),
            
            uView4.topAnchor.constraint(equalTo: uView3.bottomAnchor,constant: 20),
            uView4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uView4.heightAnchor.constraint(equalToConstant: 60),
            
            uView5.topAnchor.constraint(equalTo: uView4.bottomAnchor,constant: 20),
            uView5.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView5.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            uView5.bottomAnchor.constraint(equalTo: uViewScrollView1.bottomAnchor,constant: -50),
            uView5.heightAnchor.constraint(equalToConstant: 60),
            
            labelZonas.centerYAnchor.constraint(equalTo: uView3.centerYAnchor),
            labelZonas.leadingAnchor.constraint(equalTo: uView3.leadingAnchor, constant: 30),
            
            labelLlaves.centerYAnchor.constraint(equalTo: uView4.centerYAnchor),
            labelLlaves.leadingAnchor.constraint(equalTo: uView4.leadingAnchor, constant: 30),
            
            labelFinal.centerYAnchor.constraint(equalTo: uView5.centerYAnchor),
            labelFinal.leadingAnchor.constraint(equalTo: uView5.leadingAnchor, constant: 30),
            
            buttonZonas.heightAnchor.constraint(equalToConstant: 25),
            buttonZonas.widthAnchor.constraint(equalToConstant: 25),
            buttonZonas.centerYAnchor.constraint(equalTo: uView3.centerYAnchor),
            buttonZonas.trailingAnchor.constraint(equalTo: uView3.trailingAnchor, constant: -25),
            
            buttonLlaves.heightAnchor.constraint(equalToConstant: 25),
            buttonLlaves.widthAnchor.constraint(equalToConstant: 25),
            buttonLlaves.centerYAnchor.constraint(equalTo: uView4.centerYAnchor),
            buttonLlaves.trailingAnchor.constraint(equalTo: uView4.trailingAnchor, constant: -25),
            
            buttonFinal.heightAnchor.constraint(equalToConstant: 25),
            buttonFinal.widthAnchor.constraint(equalToConstant: 25),
            buttonFinal.centerYAnchor.constraint(equalTo: uView5.centerYAnchor),
            buttonFinal.trailingAnchor.constraint(equalTo: uView5.trailingAnchor, constant: -25),
            
        ])
        
        torneoInfoTable.delegate = self
        torneoInfoTable.dataSource = self
        
        topAnchorView1 = uView1.topAnchor.constraint(equalTo: uView0.bottomAnchor, constant: 20)
        topAnchorView1?.isActive = true
        topAnchorTable1 = uView1.topAnchor.constraint(equalTo: torneoInfoTable.bottomAnchor, constant: 20)
        topAnchorTable1?.isActive = false
        uView1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uView1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uView1.heightAnchor.constraint(equalToConstant: 60).isActive = true
     
        labelParticipants.centerYAnchor.constraint(equalTo: uView1.centerYAnchor).isActive = true
        labelParticipants.leadingAnchor.constraint(equalTo: uView1.leadingAnchor, constant: 30).isActive = true
        buttonPlusMinus.heightAnchor.constraint(equalToConstant: 25).isActive = true
        buttonPlusMinus.widthAnchor.constraint(equalToConstant: 25).isActive = true
        buttonPlusMinus.centerYAnchor.constraint(equalTo: uView1.centerYAnchor).isActive = true
        buttonPlusMinus.trailingAnchor.constraint(equalTo: uView1.trailingAnchor, constant: -25).isActive = true
        
//        labelParticipants.text = "Participantes \(allNames.count)/\(allData[0].maxParticipants)"
        
        allUsersTable.delegate = self
        allUsersTable.dataSource = self

        allUsersTable.topAnchor.constraint(equalTo: uView1.bottomAnchor).isActive = true
        allUsersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        allUsersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        allUsersTable.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topAnchorView = uView2.topAnchor.constraint(equalTo: uView1.bottomAnchor, constant: 20)
        topAnchorView?.isActive = true
        
        topAnchorTable = uView2.topAnchor.constraint(equalTo: allUsersTable.bottomAnchor, constant: 20)
        topAnchorTable?.isActive = false
        
        uView2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uView2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uView2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        labelPuntuacion.centerYAnchor.constraint(equalTo: uView2.centerYAnchor).isActive = true
        labelPuntuacion.leadingAnchor.constraint(equalTo: uView2.leadingAnchor, constant: 30).isActive = true
        buttonPlusMinus1.heightAnchor.constraint(equalToConstant: 25).isActive = true
        buttonPlusMinus1.widthAnchor.constraint(equalToConstant: 25).isActive = true
        buttonPlusMinus1.centerYAnchor.constraint(equalTo: uView2.centerYAnchor).isActive = true
        buttonPlusMinus1.trailingAnchor.constraint(equalTo: uView2.trailingAnchor, constant: -25).isActive = true
        
        allPointsTable.delegate = self
        allPointsTable.dataSource = self
        
        allPointsTable.topAnchor.constraint(equalTo: uView2.bottomAnchor).isActive = true
        allPointsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        allPointsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        allPointsTable.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topAnchorView2 = trophyImage.topAnchor.constraint(equalTo: uView2.bottomAnchor, constant: 20)
        topAnchorView2?.isActive = true
        
        topAnchorView3 = trophyImage.topAnchor.constraint(equalTo: allPointsTable.bottomAnchor, constant: 20)
        topAnchorView3?.isActive = false
        
        trophyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trophyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        trophyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true

        buttonRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonRegister.topAnchor.constraint(equalTo: trophyImage.bottomAnchor,constant: 20).isActive = true
        buttonRegister.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -20).isActive = true
        buttonRegister.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonRegister.widthAnchor.constraint(equalToConstant: 200).isActive = true
        

        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countData = 0 as Int
        if tableView == allUsersTable {
            if allData[section].collapsed {
                countData = 0
            }else{
                countData = allData[section].allUsers.count
            }

        }
        if tableView == torneoInfoTable{
            if collapsedInfo {
                countData = 0
            }else {
                countData = allTitles.count
            }
        }
        
        if tableView == allPointsTable {

                countData = allPointsName.count
            
        }
      return countData
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        if tableView == allUsersTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! InscriptionsCell
            myCell.labelName.text = allNames[indexPath.row].name
            myCell.labelLastname.text = allNames[indexPath.row].lastname
            myCell.labelPoints.text = allNames[indexPath.row].points
            myCell.labelPosition.text = allNames[indexPath.row].position
            myCell.labelScore.text = allNames[indexPath.row].score
            myCell.imagePhotoHeader.image = UIImage(named: allNames[indexPath.row].imageProfile)


            returnCell = myCell
        }
        
        if tableView == torneoInfoTable{
            let myCell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! TorneoInfoCell

            myCell.labelTitle1.text = allTitles[indexPath.row]
            myCell.labelTitle2.text = allInfo[indexPath.row]
            returnCell = myCell
        }
        
        if tableView == allPointsTable{
            let myCell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as! PointsCell
            myCell.labelPoints.text = allPointsName[indexPath.row] + " - " + allPoints[indexPath.row] + "pts"
 
            returnCell = myCell
        }
        
        return returnCell

    }
    

    @objc func handleExpandClose() {

 
        var indexPaths = [IndexPath]()
           
        for row in allData[0].allUsers.indices {
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
   
        let isExpanded = allData[0].collapsed
        allData[0].collapsed = !isExpanded
             
        if !isExpanded {
            buttonPlusMinus.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            allUsersTable.isHidden = true
            allUsersTable.deleteRows(at: indexPaths, with: .fade)
            topAnchorView?.isActive = true
            topAnchorTable?.isActive = false
        } else {
            buttonPlusMinus.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            allUsersTable.isHidden = false
            allUsersTable.insertRows(at: indexPaths, with: .fade)
            topAnchorView?.isActive = false
            topAnchorTable?.isActive = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)

        allUsersTable.reloadData()
    }
    
    @objc func handleExpandClose2() {

 
        var indexPaths = [IndexPath]()
           
        for row in allInfo.indices {
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
   
        let isExpanded = collapsedInfo
        collapsedInfo = !isExpanded
             
        if !isExpanded {
            buttonPlusMinus2.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            torneoInfoTable.isHidden = true
            torneoInfoTable.deleteRows(at: indexPaths, with: .fade)
            topAnchorView1?.isActive = true
            topAnchorTable1?.isActive = false
        } else {
            buttonPlusMinus2.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            torneoInfoTable.isHidden = false
            torneoInfoTable.insertRows(at: indexPaths, with: .fade)
            topAnchorView1?.isActive = false
            topAnchorTable1?.isActive = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.view.layoutIfNeeded()

        }, completion: nil)

        torneoInfoTable.reloadData()
    }
    
    @objc func handleExpandClose1() {

      
        if !collapsedPoints {
            
            buttonPlusMinus1.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            allPointsTable.isHidden = false
            topAnchorView3?.isActive = true
            topAnchorView2?.isActive = false
            
        } else {
            
            buttonPlusMinus1.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            allPointsTable.isHidden = true
            topAnchorView3?.isActive = false
            topAnchorView2?.isActive = true
      
        }

        collapsedPoints = !collapsedPoints
        allPointsTable.reloadData()
        
    }
    
    @objc func registerTour() {
        
        
    }
    
    @objc func backPressed() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func infoAction() {
        
        infoButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        cuadroButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        scrollView.isHidden = false
        scrollView1.isHidden = true
        
    }
    
    @objc func cuadroAction() {
        
        infoButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        cuadroButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        scrollView1.isHidden = false
        
    }
    

   
    


}



