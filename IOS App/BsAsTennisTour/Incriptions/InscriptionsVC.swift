//
//  InscriptionsVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit
import FirebaseDatabase

class InscriptionsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var collapsedPoints : Bool = true
    var collapsedInfo : Bool = true
    var collapsedPlayers : Bool = true
    
    var collapsedZonas : Bool = true
    var collapsedLlaves : Bool = true

    var tourament = [Tourament]()
    
    var ref: DatabaseReference!
    
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
    
    private let uViewScrollView : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let containerViewCuadro : UIView = {
        let uView = UIView()
        uView.isHidden = true
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
 
    private let trophyImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icono Torneo Información Inscribirse")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let torneoInfoTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .white
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TorneoInfoCell.self, forCellReuseIdentifier: "secondCell")
        table.rowHeight = 50
        table.allowsSelection = false
        table.isHidden = true
       return table
    }()
    
    
    private let allUsersTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .white
        table.separatorColor = .colorGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(InscriptionsCell.self, forCellReuseIdentifier: "firstCell")
        table.rowHeight = 60
        table.sectionHeaderHeight = 60
        table.allowsSelection = true
        table.isHidden = true
       return table
    }()
    
    private let allPointsTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .white
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TorneoInfoCell.self, forCellReuseIdentifier: "thirdCell")
        table.rowHeight = 50
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
        button.addTarget(self, action: #selector(openCloseZonas), for: .touchUpInside)
        return button
    }()
    
    let buttonLlaves : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openCloseLlaves), for: .touchUpInside)
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
    
    private let buttonFilterName : UIButton = {
        let button = UIButton()
        button.setTitle("NOMBRE", for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 11)
        button.layer.backgroundColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(sortByName), for: .touchUpInside)
        return button
    }()
    
    private let buttonFilterRank : UIButton = {
        let button = UIButton()
        button.setTitle("RANKING", for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 11)
        button.layer.backgroundColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.colorPop.cgColor
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(sortByPosition), for: .touchUpInside)
        return button
    }()
    
    let uViewContainerLlaves : UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var allLlaves: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .white
           collectionView.register(LlavesCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    private lazy var pageControlLlaves: UIPageControl = {
         let pc = UIPageControl()
         pc.currentPage = 0
//         pc.numberOfPages = tourament[0].llave.count
         pc.currentPageIndicatorTintColor = .black
         pc.pageIndicatorTintColor = .colorGray
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()
    
    let containerZonesView : UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var allZones: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .white
           collectionView.register(ZonesCVCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    private lazy var pageControlZones: UIPageControl = {
         let pc = UIPageControl()
         pc.currentPage = 0
//         pc.numberOfPages = tourament[0].zone.count
         pc.currentPageIndicatorTintColor = .black
         pc.pageIndicatorTintColor = .colorGray
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()
    
    var topAnchorView : NSLayoutConstraint?
    var topAnchorTable : NSLayoutConstraint?
    
    var topAnchorView1 : NSLayoutConstraint?
    var topAnchorTable1 : NSLayoutConstraint?
    
    var topAnchorView2 : NSLayoutConstraint?
    var topAnchorView3 : NSLayoutConstraint?
    
    var topView4Llaves : NSLayoutConstraint?
    var topView4BottomTable : NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
        setupLayout()
        loadTourament()
    }
    
    func setupBarItem() {
 
        let menuBarItem = UIBarButtonItem(customView: buttonMenu)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
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
        view.addSubview(containerViewCuadro)
        
        //DATOS
        uViewScrollView.addSubview(uView0)
        uView0.addSubview(labelDatos)
        uViewScrollView.addSubview(buttonPlusMinus2)
        uViewScrollView.addSubview(torneoInfoTable)
        
        //PARTICIPANTES
        uViewScrollView.addSubview(uView1)
        uView1.addSubview(labelParticipants)
        uViewScrollView.addSubview(buttonPlusMinus)
        uViewScrollView.addSubview(allUsersTable)
        
        //PUNTUACION
        uViewScrollView.addSubview(uView2)
        uView2.addSubview(labelPuntuacion)
        uViewScrollView.addSubview(buttonPlusMinus1)
        uViewScrollView.addSubview(allPointsTable)
        
        uViewScrollView.addSubview(trophyImage)
        uViewScrollView.addSubview(buttonRegister)
        
        //CUADRO
        containerViewCuadro.addSubview(uView3)
        containerViewCuadro.addSubview(uView4)
    
        
        uView3.addSubview(labelZonas)
        uView4.addSubview(labelLlaves)

        containerViewCuadro.addSubview(buttonZonas)
        containerViewCuadro.addSubview(containerZonesView)
        containerZonesView.addSubview(allZones)
        containerZonesView.addSubview(pageControlZones)
        
        
        containerViewCuadro.addSubview(buttonLlaves)
        
        containerViewCuadro.addSubview(uViewContainerLlaves)
        uViewContainerLlaves.addSubview(allLlaves)
        uViewContainerLlaves.addSubview(pageControlLlaves)

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
            torneoInfoTable.heightAnchor.constraint(equalToConstant: 300),
            
            containerViewCuadro.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            containerViewCuadro.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerViewCuadro.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerViewCuadro.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uView3.topAnchor.constraint(equalTo: containerViewCuadro.topAnchor,constant: 20),
            uView3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uView3.heightAnchor.constraint(equalToConstant: 60),
            
            labelZonas.centerYAnchor.constraint(equalTo: uView3.centerYAnchor),
            labelZonas.leadingAnchor.constraint(equalTo: uView3.leadingAnchor, constant: 30),
            
            buttonZonas.heightAnchor.constraint(equalToConstant: 25),
            buttonZonas.widthAnchor.constraint(equalToConstant: 25),
            buttonZonas.centerYAnchor.constraint(equalTo: uView3.centerYAnchor),
            buttonZonas.trailingAnchor.constraint(equalTo: uView3.trailingAnchor, constant: -25),
            
            containerZonesView.topAnchor.constraint(equalTo: uView3.bottomAnchor),
            containerZonesView.leadingAnchor.constraint(equalTo: containerViewCuadro.leadingAnchor),
            containerZonesView.trailingAnchor.constraint(equalTo: containerViewCuadro.trailingAnchor),
            containerZonesView.heightAnchor.constraint(equalToConstant: 300),
            
            allZones.topAnchor.constraint(equalTo: containerZonesView.topAnchor),
            allZones.leadingAnchor.constraint(equalTo: containerZonesView.leadingAnchor),
            allZones.trailingAnchor.constraint(equalTo: containerZonesView.trailingAnchor),
            allZones.bottomAnchor.constraint(equalTo: containerZonesView.bottomAnchor),
            
            pageControlZones.centerXAnchor.constraint(equalTo: containerZonesView.centerXAnchor),
            pageControlZones.topAnchor.constraint(equalTo: containerZonesView.bottomAnchor,constant: -25),
            
            uView4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uView4.heightAnchor.constraint(equalToConstant: 60),
            
            labelLlaves.centerYAnchor.constraint(equalTo: uView4.centerYAnchor),
            labelLlaves.leadingAnchor.constraint(equalTo: uView4.leadingAnchor, constant: 30),

            buttonLlaves.heightAnchor.constraint(equalToConstant: 25),
            buttonLlaves.widthAnchor.constraint(equalToConstant: 25),
            buttonLlaves.centerYAnchor.constraint(equalTo: uView4.centerYAnchor),
            buttonLlaves.trailingAnchor.constraint(equalTo: uView4.trailingAnchor, constant: -25),
            
            uViewContainerLlaves.topAnchor.constraint(equalTo: uView4.bottomAnchor),
            uViewContainerLlaves.leadingAnchor.constraint(equalTo: containerViewCuadro.leadingAnchor),
            uViewContainerLlaves.trailingAnchor.constraint(equalTo: containerViewCuadro.trailingAnchor),
            uViewContainerLlaves.bottomAnchor.constraint(equalTo: containerViewCuadro.bottomAnchor),

            allLlaves.topAnchor.constraint(equalTo: uViewContainerLlaves.topAnchor),
            allLlaves.leadingAnchor.constraint(equalTo: uViewContainerLlaves.leadingAnchor),
            allLlaves.trailingAnchor.constraint(equalTo: uViewContainerLlaves.trailingAnchor),
            allLlaves.bottomAnchor.constraint(equalTo: uViewContainerLlaves.bottomAnchor),

            pageControlLlaves.centerXAnchor.constraint(equalTo: uViewContainerLlaves.centerXAnchor),
            pageControlLlaves.topAnchor.constraint(equalTo: uViewContainerLlaves.topAnchor,constant: 35)
            
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
        allPointsTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        topAnchorView2 = trophyImage.topAnchor.constraint(equalTo: uView2.bottomAnchor, constant: 20)
        topAnchorView2?.isActive = true
        
        topAnchorView3 = trophyImage.topAnchor.constraint(equalTo: allPointsTable.bottomAnchor, constant: 20)
        topAnchorView3?.isActive = false
        
        trophyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trophyImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        trophyImage.heightAnchor.constraint(equalToConstant: 60).isActive = true

        buttonRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonRegister.topAnchor.constraint(equalTo: trophyImage.bottomAnchor,constant: 20).isActive = true
        buttonRegister.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -20).isActive = true
        buttonRegister.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonRegister.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //CUADRO
        topView4Llaves = uView4.topAnchor.constraint(equalTo: uView3.bottomAnchor,constant: 20)
        topView4Llaves?.isActive = true
        
        topView4BottomTable = uView4.topAnchor.constraint(equalTo: containerZonesView.bottomAnchor,constant: 20)
        topView4BottomTable?.isActive = false
    
        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countData = 0 as Int
        
        if tourament.count != 0 {

        if tableView == allUsersTable {
            countData = tourament[0].players.count
        }
        if tableView == torneoInfoTable{
            countData = tourament[0].stats.count
        }
        
        if tableView == allPointsTable {
            countData = tourament[0].winPoints.count
        }
            
        }
      return countData
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        if tableView == allUsersTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! InscriptionsCell
            
            let (firstname,lastname) = NameDivisor(fullName: tourament[0].players[indexPath.row].fullName)
            
            myCell.labelName.text = firstname
            myCell.labelLastname.text = lastname
            myCell.labelPosition.text = "\(tourament[0].players[indexPath.row].rank)"
            myCell.imagePhotoHeader.image = UIImage(named: tourament[0].players[indexPath.row].picture)


            returnCell = myCell
        }
        
        if tableView == torneoInfoTable{
            let myCell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! TorneoInfoCell

            myCell.labelTitle1.text = tourament[0].stats[indexPath.row].title
            myCell.labelTitle2.text = "\(tourament[0].stats[indexPath.row].value)"
            returnCell = myCell
        }
        
        if tableView == allPointsTable{
            let myCell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as! TorneoInfoCell
            myCell.labelTitle1.text = tourament[0].winPoints[indexPath.row].title
            myCell.labelTitle2.text = "\(tourament[0].winPoints[indexPath.row].number) pts"
    
 
            returnCell = myCell
        }
        
        return returnCell

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerVw = UIView()
        containerVw.backgroundColor = .white
        if tableView == allUsersTable {

        containerVw.addSubview(buttonFilterName)
        containerVw.addSubview(buttonFilterRank)
        
        buttonFilterName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonFilterName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonFilterRank.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonFilterRank.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonFilterRank.centerYAnchor.constraint(equalTo: containerVw.centerYAnchor).isActive = true
        buttonFilterName.centerYAnchor.constraint(equalTo: containerVw.centerYAnchor).isActive = true
        buttonFilterRank.centerXAnchor.constraint(equalTo: containerVw.centerXAnchor, constant: 80).isActive = true
        buttonFilterName.centerXAnchor.constraint(equalTo: containerVw.centerXAnchor ,constant: -80).isActive = true
       
        }
        return containerVw
    }
    

    @objc func handleExpandClose() {
   
        if !collapsedPlayers{
            buttonPlusMinus.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            allUsersTable.isHidden = true
            topAnchorView?.isActive = true
            topAnchorTable?.isActive = false
        } else {
            buttonPlusMinus.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            allUsersTable.isHidden = false
            topAnchorView?.isActive = false
            topAnchorTable?.isActive = true
        }
        
        collapsedPlayers = !collapsedPlayers
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)

//        allUsersTable.reloadData()
    }
    
    @objc func handleExpandClose2() {
             
        if !collapsedInfo {
            buttonPlusMinus2.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            torneoInfoTable.isHidden = true
            topAnchorView1?.isActive = true
            topAnchorTable1?.isActive = false
        } else {
            buttonPlusMinus2.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            torneoInfoTable.isHidden = false
            topAnchorView1?.isActive = false
            topAnchorTable1?.isActive = true
        }
        
        collapsedInfo = !collapsedInfo
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.view.layoutIfNeeded()

        }, completion: nil)

//        torneoInfoTable.reloadData()
    }
    
    @objc func handleExpandClose1() {

      
        if !collapsedPoints {
            buttonPlusMinus1.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            allPointsTable.isHidden = true
            topAnchorView3?.isActive = false
            topAnchorView2?.isActive = true
            
        } else {
            buttonPlusMinus1.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            allPointsTable.isHidden = false
            topAnchorView3?.isActive = true
            topAnchorView2?.isActive = false
      
        }

        collapsedPoints = !collapsedPoints
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
//        allPointsTable.reloadData()
        
    }
    
    @objc func openCloseZonas() {
        
        if !collapsedZonas {
            buttonZonas.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            containerZonesView.isHidden = true
            topView4Llaves?.isActive = true
            topView4BottomTable?.isActive = false
            
        } else {
            buttonZonas.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            containerZonesView.isHidden = false
            topView4Llaves?.isActive = false
            topView4BottomTable?.isActive = true
      
        }

        collapsedZonas = !collapsedZonas
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
//        allZones.reloadData()
        
    }
    
    @objc func openCloseLlaves() {
        
        if !collapsedLlaves {
            buttonLlaves.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            uViewContainerLlaves.isHidden = true
        }else{
            buttonLlaves.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            uViewContainerLlaves.isHidden = false
        }
        collapsedLlaves = !collapsedLlaves
        
    }
    
    @objc func registerTour() {
        
        print("INSCRIPTO")
        
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
        containerViewCuadro.isHidden = true
        
    }
    
    @objc func cuadroAction() {
        
        infoButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        cuadroButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        containerViewCuadro.isHidden = false
        
    }
    
    @objc func sortByName() {
        
        buttonFilterName.layer.borderColor = UIColor.black.cgColor
        buttonFilterName.setTitleColor(.white, for: .normal)
        buttonFilterName.layer.backgroundColor = UIColor.black.cgColor

        buttonFilterRank.layer.borderColor = UIColor.colorPop.cgColor
        buttonFilterRank.layer.backgroundColor = UIColor.white.cgColor
        buttonFilterRank.setTitleColor(.colorPop, for: .normal)
        
        let sortedUsers2 = tourament[0].players.sorted(by: {
            $0.fullName < $1.fullName
        })
        tourament[0].players.removeAll()
        tourament[0].players.append(contentsOf: sortedUsers2)
        
        allUsersTable.reloadData()
        
        
    }

    @objc func sortByPosition() {
        
        buttonFilterRank.layer.borderColor = UIColor.black.cgColor
        buttonFilterRank.setTitleColor(.white, for: .normal)
        buttonFilterRank.layer.backgroundColor = UIColor.black.cgColor

        buttonFilterName.layer.borderColor = UIColor.colorPop.cgColor
        buttonFilterName.layer.backgroundColor = UIColor.white.cgColor
        buttonFilterName.setTitleColor(.colorPop, for: .normal)
        
        let sortedUsers2 = tourament[0].players.sorted(by: {
            $0.rank < $1.rank
        })
        tourament[0].players.removeAll()
        tourament[0].players.append(contentsOf: sortedUsers2)
        
        allUsersTable.reloadData()
        
    }
    
    func loadTourament() {
        
        let dayTour = UserDefaults.standard.string(forKey: "dayTour") ?? ""
        let nameTour = UserDefaults.standard.string(forKey: "nameTour") ?? ""
        ref = Database.database().reference().child("Torneos/\(dayTour)/\(nameTour)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                
                var stats = [TourStats]()
                var players = [PlayerStat]()
                var llaves = [Llaves]()
                var zonas = [Zonas]()
                var winpoints = [Points]()
                
                if let allTour = snapshot.children.allObjects as? [DataSnapshot] {
                    for tour in allTour {
                        
                        switch tour.key {
                        case "Info":
                            if let allStats = tour.children.allObjects as? [DataSnapshot] {
                                for stat in allStats {
                                    stats.append(TourStats(title: stat.key, value: stat.value ?? ""))
                                }
                            }
                        case "Players":
                            if let allPlayers = tour.children.allObjects as? [DataSnapshot] {
                                for player in allPlayers {
                                    if let allDataPlayer = player.children.allObjects as? [DataSnapshot]{
                                        for dataPlayer in allDataPlayer {
                                            var fullName : String = ""
                                            var points : Int = 0
                                            var rank : Int = 0
                                            var picture : String = ""
                                            if dataPlayer.key == "fullName" {
                                                fullName = dataPlayer.value as? String ?? "-"
                                            }
                                            if dataPlayer.key == "points" {
                                                points = dataPlayer.value as? Int ?? 0
                                            }
                                            if dataPlayer.key == "rank" {
                                                rank = dataPlayer.value as? Int ?? 0
                                            }
                                            if dataPlayer.key == "picture" {
                                                picture = dataPlayer.value as? String ?? "-"
                                            }
                                            
                                            players.append(PlayerStat(id: player.key, fullName: fullName, points: points, rank: rank, picture: picture))
                                        }
                                    }
                                  
                                }
                            }
                        case "WinPoints":
                            if let allWinPoints = tour.children.allObjects as? [DataSnapshot] {
                                for points in allWinPoints {
                                    let indexInt = points.key.indexes(of: "-", str: points.key)
                                    
                                    winpoints.append(Points(title: points.value as? String ?? "-", number: points.key.substring(from: indexInt + 1)))
                                }
                            }
                        case "Zonas":
                            if let allZonas = tour.children.allObjects as? [DataSnapshot] {
                                for zona in allZonas {
                                    var arrayPlayers : [PlayerZona] = []
                                    if let allPlayers = zona.children.allObjects as? [DataSnapshot]{
                                        for player in allPlayers {
                                            if let allInfoPlayer = player.children.allObjects as? [DataSnapshot] {
                                                
                                                var fullName : String = ""
                                                var points : Int = 0
                                                var lose : Int = 0
                                                var win : Int = 0
                                                var picture : String = ""
                                                
                                                for info in allInfoPlayer {
                                                    if info.key == "fullName" {
                                                        fullName = info.value as? String ?? "-"
                                                    }
                                                    if info.key == "points" {
                                                        points = info.value as? Int ?? 0
                                                    }
                                                    if info.key == "lose" {
                                                        lose = info.value as? Int ?? 0
                                                    }
                                                    if info.key == "win" {
                                                        win = info.value as? Int ?? 0
                                                    }
                                                    if info.key == "picture" {
                                                        picture = info.value as? String ?? "-"
                                                    }
                                                }
                                                arrayPlayers.append(PlayerZona(id: player.key, fullName: fullName, picture: picture, win: win, lose: lose, points: points))
                                            }
                                        }
                                    }
                                    zonas.append(Zonas(name: zona.key, types: arrayPlayers))
                                }
                            }
                        case "Llaves":
                            if let allLlaves = tour.children.allObjects as? [DataSnapshot] {
                                for llave in allLlaves {
                                    
                                    var arrayMatch : [Match] = []
                                    
                                    if let allMatches = llave.children.allObjects as? [DataSnapshot] {
                                        for match in allMatches {
                                            
                                            var arrayPlayer : [PlayerLlave] = []
                                            
                                            if let positions = match.children.allObjects as? [DataSnapshot] {
                                                for position in positions {
                                                    
                                                    var fullName : String = "-"
                                                    var win : Bool = false
                                                    var picture : String = "perfilIcon"
                                                    var SETS : [String] = []
                                                    
                                                    if let allPlayer = position.children.allObjects as? [DataSnapshot] {
                                                        for player in allPlayer {
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
                                                            arrayPlayer.append(PlayerLlave(match: position.key, id: player.key, fullName: fullName, picture: picture, win: win, set: SETS))
                                                        }
                                                    }
                                                }
                                            }
                                            arrayMatch.append(Match(name: match.key, player1: arrayPlayer[0], player2: arrayPlayer[1]))
                                
                                        }
                                    }
                                    llaves.append(Llaves(name: llave.key.substring(from: 1), types: arrayMatch))
                                }
                            }
  
                        default:
                            print("error")
                        }

                    }
                    self.tourament.append(Tourament(name: nameTour, stats: stats, players: players, winPoints: winpoints, llave: llaves, zone: zonas))
                }
                self.sortByPosition()
                self.torneoInfoTable.reloadData()
                self.allUsersTable.reloadData()
                self.allPointsTable.reloadData()
                self.allZones.reloadData()
                self.allLlaves.reloadData()
                
            }
        })
        
        
    }
    


}

extension InscriptionsVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == allLlaves {
   
         let x = targetContentOffset.pointee.x
         pageControlLlaves.currentPage = Int(x / uViewContainerLlaves.bounds.width)

        }
        
        if scrollView == allZones {
   
         let x = targetContentOffset.pointee.x
         pageControlZones.currentPage = Int(x / containerZonesView.bounds.width)

        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var sizeCollection = CGSize(width: 10, height: 10)
        if collectionView == allLlaves {
            sizeCollection = CGSize(width: uViewContainerLlaves.bounds.width, height: uViewContainerLlaves.bounds.height)
        }
        if collectionView == allZones {
            sizeCollection = CGSize(width: containerZonesView.bounds.width, height: containerZonesView.bounds.height)
        }
        return sizeCollection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var returnInt = 0
        
        if tourament.count != 0 {
        if collectionView == allLlaves {
            returnInt = tourament[0].llave.count
        }
        if collectionView == allZones {
            returnInt = tourament[0].zone.count
        }
        }
        
        return returnInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var returnCell = UICollectionViewCell()
        
        if collectionView == allLlaves {
          
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! LlavesCell
            
            cell.labelTitle.text = "\(tourament[0].llave[indexPath.row].name)"
            cell.updateCellWith(row: tourament[0].llave[indexPath.row])
            
            returnCell = cell
        }
        
        if collectionView == allZones {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ZonesCVCell

            cell.labelTitle.text = tourament[0].zone[indexPath.row].name
            cell.updateCellWith(row: tourament[0].zone[indexPath.row].types)
            returnCell = cell
        }
        
        return returnCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
