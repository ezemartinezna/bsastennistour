//
//  InscriptionsVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit
import FirebaseDatabase

class InscriptionsVC: UIViewController,UITableViewDelegate,UITableViewDataSource, ZonasLlavesDelegate {
    
    var collapsedPoints : Bool = true
    var collapsedInfo : Bool = true
    var collapsedPlayers : Bool = true
    
    var collapsedZonas : Bool = true
    var collapsedLlaves : Bool = true

    var tourament = [Tourament]()
    
    let admin = UserDefaults.standard.string(forKey: "ADMIN")
    let dayTour = UserDefaults.standard.string(forKey: "dayTour") ?? ""
    let nameTour = UserDefaults.standard.string(forKey: "nameTour") ?? ""
    
    let uid = UserDefaults.standard.string(forKey: "uid") ?? "-"
    
    var maxPlayers : Int = 0
    var modelo : String = ""
    
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
        table.allowsSelection = true
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
    
    private let buttonAdminTour : UIButton = {
        let button = UIButton()
        button.setTitle("CERRAR INSCRIPCION", for: .normal)
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
        button.addTarget(self, action: #selector(closeTour), for: .touchUpInside)
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
        view.isUserInteractionEnabled = true
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
         pc.currentPageIndicatorTintColor = .black
         pc.pageIndicatorTintColor = .colorGray
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()
    
    let containerZonesView : UIView = {
        let view = UIView()
        view.isHidden = true
        view.isUserInteractionEnabled = true
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadZonas), name: NSNotification.Name(rawValue: "LoadZonaTour"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadLlaves), name: NSNotification.Name(rawValue: "LoadLlaveTour"), object: nil)
    }
    
    func setupBarItem() {
 
        let menuBarItem = UIBarButtonItem(customView: buttonMenu)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .colorCoal
        appearance.shadowColor = .colorCoal
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
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
        uViewScrollView.addSubview(buttonAdminTour)
        
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
        
        buttonAdminTour.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonAdminTour.topAnchor.constraint(equalTo: trophyImage.bottomAnchor,constant: 20).isActive = true
        buttonAdminTour.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -20).isActive = true
        buttonAdminTour.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonAdminTour.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //CUADRO
        topView4Llaves = uView4.topAnchor.constraint(equalTo: uView3.bottomAnchor,constant: 20)
        topView4Llaves?.isActive = true
        
        topView4BottomTable = uView4.topAnchor.constraint(equalTo: containerZonesView.bottomAnchor,constant: 20)
        topView4BottomTable?.isActive = false
    
        if admin == "YES-1" {
            trophyImage.isHidden = true
            buttonRegister.isHidden = true
            buttonRegister.isEnabled = false
        }else{
            buttonAdminTour.isHidden = true
            buttonAdminTour.isEnabled = false
        }
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
            let imageUrl = URL(string:tourament[0].players[indexPath.row].picture)
            myCell.imagePhotoHeader.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if admin == "YES-1" {
            if tableView == torneoInfoTable {
            let dialogMessage = UIAlertController(title: NSLocalizedString("Cambiar Datos", comment: ""), message: NSLocalizedString("\(tourament[0].stats[indexPath.row].title)", comment: ""), preferredStyle: .alert)
            dialogMessage.addTextField(configurationHandler: {(textField) in
                textField.text = NSLocalizedString("\(self.tourament[0].stats[indexPath.row].value)", comment: "")
            })
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let infoChanged = dialogMessage.textFields![0]
             
                self.ref = Database.database().reference().child("Torneos/\(self.dayTour)/\(self.nameTour)/Info/\(self.tourament[0].stats[indexPath.row].title)")
                self.ref.setValue(infoChanged.text){
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                      self.showAlert(title: "Error", message: error.localizedDescription)
                      return
                    } else {
                        self.tourament[0].stats[indexPath.row].value = infoChanged.text!
                        self.showAlert(title: "Se cambió con éxito", message: "Info cambiada correctamente")
                        self.torneoInfoTable.reloadData()
                    }
                }
            })
            let cancel = UIAlertAction(title: "Volver", style: .cancel) { (_) in
                print("Volver")
            }
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
                      
         self.present(dialogMessage, animated: true, completion: nil)

        }
        }
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
            if admin == "YES-1" && tourament[0].llave.count == 0 {
            buttonZonas.setImage(#imageLiteral(resourceName: "Icono - Más (Verde)"), for: .normal)
            buttonZonas.addTarget(self, action: #selector(addZona), for: .touchUpInside)
            }else{
            buttonZonas.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            }
            containerZonesView.isHidden = false
            topView4Llaves?.isActive = false
            topView4BottomTable?.isActive = true
            if !collapsedLlaves {
                buttonLlaves.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
                uViewContainerLlaves.isHidden = true
                collapsedLlaves = !collapsedLlaves
            }
        }

        collapsedZonas = !collapsedZonas
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        allZones.reloadData()
        
    }
    
    @objc func openCloseLlaves() {
        if !collapsedLlaves {
            buttonLlaves.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
            uViewContainerLlaves.isHidden = true
        }else{
            buttonLlaves.setImage(#imageLiteral(resourceName: "upArrowWhite"), for: .normal)
            uViewContainerLlaves.isHidden = false
            if !collapsedZonas {
                buttonZonas.setImage(#imageLiteral(resourceName: "downArrowWhite"), for: .normal)
                containerZonesView.isHidden = true
                topView4Llaves?.isActive = true
                topView4BottomTable?.isActive = false
                collapsedZonas = !collapsedZonas
            }
        }
        collapsedLlaves = !collapsedLlaves
        allLlaves.reloadData()
    }
    
    @objc func closeTour() {
        
        ref = Database.database().reference().child("Torneos/\(self.dayTour)/\(self.nameTour)/Info/Status")
        ref.setValue("Closed"){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              self.showAlert(title: "Error", message: error.localizedDescription)
              return
            } else {
              self.buttonAdminTour.alpha = 0.5
              self.buttonAdminTour.isEnabled = false
              self.showAlert(title: "\(self.nameTour)", message: "Se cierra la inscripción correctamente.")
            }
        }
        
    }
    
    @objc func registerTour() {
        
        ref = Database.database().reference().child("Users/\(uid)/")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                
                var fullName = "-"
                var rank = 0
                var points = 0
                var picture = "-"
                
                if let firstName = snapshot.childSnapshot(forPath: "firstName").value {
                    if let lastName = snapshot.childSnapshot(forPath: "lastName").value {
                        fullName = "\(firstName) \(lastName)"
                    }
                }
                
                if let rankValue = snapshot.childSnapshot(forPath: "rank").value as? Int {
                    rank = rankValue
                }
                
                if let pointValue = snapshot.childSnapshot(forPath: "points").value as? Int {
                    points = pointValue
                }
                
                if let pictureValue = snapshot.childSnapshot(forPath: "picture").value as? String {
                    picture = pictureValue
                }
                
                if fullName == "- -" {
                    self.showAlertWithOkAction(title: "Configure su Perfil", message: "Modifique su nombre y apellido.",index: 3)
                }else{
                
                    let savePlayer = ["fullName" : fullName,"picture" : picture,"rank" : rank, "points" : points] as [String : Any]
                
                    self.ref = Database.database().reference().child("Torneos/\(self.dayTour)/\(self.nameTour)/Players/\(self.uid)")
                self.ref.setValue(savePlayer){
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                      self.showAlert(title: "Error", message: error.localizedDescription)
                      return
                    } else {
                        self.tourament[0].players.append(PlayerStat(id: self.uid, fullName: fullName, points: points, rank: rank, picture: picture))
                        self.showAlert(title: "Torneo Inscripto", message: "Se registró correctamente.")
                        self.allUsersTable.reloadData()
                    }
                }
                }
                
            }
        })
        
        

        
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
    
    @objc func addZona() {
        
        self.buttonZonas.removeTarget(self, action: #selector(self.addZona), for: .touchUpInside)
        
        let dialogMessage = UIAlertController(title: NSLocalizedString("Zonas del Torneo \(nameTour)", comment: ""), message: NSLocalizedString("Ingrese a continuación", comment: ""), preferredStyle: .alert)
        dialogMessage.addTextField(configurationHandler: {(textField) in
                               textField.placeholder = NSLocalizedString("Cantidad de Zonas", comment: "")
        })
         dialogMessage.addTextField(configurationHandler: {(textField) in
                                textField.placeholder = NSLocalizedString("Maximo de Clasificados", comment: "")
         })
        dialogMessage.addTextField(configurationHandler: {(textField) in
                               textField.placeholder = NSLocalizedString("Cantidad de Sets", comment: "")
        })
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        
        let cantZona = dialogMessage.textFields![0]
        let maxClasi = dialogMessage.textFields![1]
        let cantSETS = dialogMessage.textFields![2]
         
         if cantZona.text != "" && maxClasi.text != "" && cantSETS.text != ""{
            
             let playerStats : [String : Any] = ["fullName" : "-","lose" : 0,"picture" : "perfilIcon","win" : 0,"points":0]
            
             var zonas : [String :
                               [String : [String : Any]]] = [:]
             var playersZonas : [String : [String : Any]] = [:]
             
            if let iCantZona = Int(cantZona.text!) {
                if let iMaxClasi = Int(maxClasi.text!) {
                    
                var total = self.maxPlayers / iCantZona
                    if self.modelo.contains("Double") == true {
                        total = total / 2
                    }
                for i in 1...iCantZona {
                    for f in 1...total {
                        if self.modelo.contains("Double") == true {
                            playersZonas.updateValue([self.randomString(length: 7):playerStats,self.randomString(length: 7):playerStats], forKey: "\(f)")
                        }else{
                            playersZonas.updateValue([self.randomString(length: 7):playerStats], forKey: "\(f)")
                        }
                    }
                    zonas.updateValue(playersZonas, forKey: "Zona \(i)")
                }
                var savellave : [String :
                                    [String :
                                            [String :
                                                    [String :
                                                        [String : [String : String]]]]]] = [:]
                    
                var SET : [String : String] = [:]
        
                let cantSet = Int(cantSETS.text!) ?? 1
            
                for i in 1...cantSet {
                    SET.updateValue("-", forKey: "\(i)")
                }
                
                let resultado = iCantZona * iMaxClasi
                switch resultado {
                case 2:
                    savellave = ["1Final" :
                                         ["Match1" :
                                             ["F1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "F2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ]
                    ]]
                case 4:
                    savellave = ["1Semifinal" :
                                         ["Match1" :
                                             ["S1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "S2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match2" :
                                             ["S3" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "S4":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                         ],
                                 "2Final" :
                                         ["Match1" :
                                             ["F1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "F2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ]
                    ]]
                case 8:
                    savellave = ["1Cuartos" :
                                         ["Match1" :
                                             ["C1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "C2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match2" :
                                             ["C3" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "C4":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match3" :
                                              ["C5" :
                                                  ["1q2w3e4r" :["SET":SET]],
                                               "C6":
                                                  ["1q2w3e4r" :["SET":SET]],
                                              ],
                                           "Match4" :
                                              ["C7" :
                                                  ["1q2w3e4r" :["SET":SET]],
                                               "C8":
                                                  ["1q2w3e4r" :["SET":SET]],
                                              ],
                                         ],
                                 "2Semifinal" :
                                         ["Match1" :
                                             ["S1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "S2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match2" :
                                             ["S3" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "S4":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                         ],
                                 "3Final" :
                                         ["Match1" :
                                             ["F1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "F2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ]
                    ]]
                case 16:
                    savellave = ["1Octavos" :
                                    ["Match1" :
                                        ["O1" :
                                            ["1q2w3e4r" :["SET":SET]],
                                         "O2":
                                            ["1q2w3e4r" :["SET":SET]],
                                        ],
                                     "Match2" :
                                        ["O3" :
                                            ["1q2w3e4r" :["SET":SET]],
                                         "O4":
                                            ["1q2w3e4r" :["SET":SET]],
                                        ],
                                     "Match3" :
                                         ["O5" :
                                             ["1q2w3e4r" :["SET":SET]],
                                          "O6":
                                             ["1q2w3e4r" :["SET":SET]],
                                         ],
                                      "Match4" :
                                         ["O7" :
                                             ["1q2w3e4r" :["SET":SET]],
                                          "O8":
                                             ["1q2w3e4r" :["SET":SET]],
                                         ],
                                      "Match5" :
                                          ["O9" :
                                              ["1q2w3e4r" :["SET":SET]],
                                           "O10":
                                              ["1q2w3e4r" :["SET":SET]],
                                          ],
                                       "Match6" :
                                          ["O11" :
                                              ["1q2w3e4r" :["SET":SET]],
                                           "O12":
                                              ["1q2w3e4r" :["SET":SET]],
                                          ],
                                       "Match7" :
                                           ["O13" :
                                               ["1q2w3e4r" :["SET":SET]],
                                            "O14":
                                               ["1q2w3e4r" :["SET":SET]],
                                           ],
                                        "Match8" :
                                           ["O15" :
                                               ["1q2w3e4r" :["SET":SET]],
                                            "O16":
                                               ["1q2w3e4r" :["SET":SET]],
                                           ],
                                    ],
                                 "2Cuartos" :
                                         ["Match1" :
                                             ["C1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "C2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match2" :
                                             ["C3" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "C4":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match3" :
                                              ["C5" :
                                                  ["1q2w3e4r" :["SET":SET]],
                                               "C6":
                                                  ["1q2w3e4r" :["SET":SET]],
                                              ],
                                           "Match4" :
                                              ["C7" :
                                                  ["1q2w3e4r" :["SET":SET]],
                                               "C8":
                                                  ["1q2w3e4r" :["SET":SET]],
                                              ],
                                         ],
                                 "3Semifinal" :
                                         ["Match1" :
                                             ["S1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "S2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                          "Match2" :
                                             ["S3" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "S4":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ],
                                         ],
                                 "4Final" :
                                         ["Match1" :
                                             ["F1" :
                                                 ["1q2w3e4r" :["SET":SET]],
                                              "F2":
                                                 ["1q2w3e4r" :["SET":SET]],
                                             ]
                    ]]
                default:
                    print("Sin Llave")
                }
                    
                    self.ref = Database.database().reference().child("Torneos/\(self.dayTour)/\(self.nameTour)/Llaves")
                    self.ref.setValue(savellave){
                                
                                (error:Error?, ref:DatabaseReference) in
                                if let error = error {
                                  self.showAlert(title: "Error", message: error.localizedDescription)
                                  return
                                } else {
                                    
                                    self.ref = Database.database().reference().child("Torneos/\(self.dayTour)/\(self.nameTour)/Zonas")
                                    self.ref.setValue(zonas){
                                        
                                        (error:Error?, ref:DatabaseReference) in
                                        if let error = error {
                                          self.showAlert(title: "Error", message: error.localizedDescription)
                                          return
                                        } else {
                                            self.loadTourament()
                                            self.showAlert(title: "Torneo Modificado", message: "Se modificó correctamente el torneo \(self.titleTorneo.text ?? "Testing Tour")")
                                        }
               
                                    }
               
                                }
                                
                            }
                    
                    
            }
                
            }
            
         }
        
        })
                     
        dialogMessage.addAction(ok)
                  
     self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @objc func loadTourament() {
        
        tourament.removeAll()
        
        ref = Database.database().reference().child("Torneos/\(dayTour)/\(nameTour)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                
                var stats = [TourStats]()
                var players = [PlayerStat]()
                var llaves = [Llaves]()
                var zonas = [Zonas]()
                var winpoints = [Points]()
                var winpointsOrder = [Points]()
                
                if let allTour = snapshot.children.allObjects as? [DataSnapshot] {
                    for tour in allTour {
                        
                        switch tour.key {
                        case "Info":
                            if let allStats = tour.children.allObjects as? [DataSnapshot] {
                                for stat in allStats {
                                    if stat.key == "Max" {
                                        let valueString = stat.value as? String ?? "0"
                                        self.maxPlayers = Int(valueString) ?? 0
                                    }
                                    if stat.key == "Status" {
                                        if stat.value as? String == "Closed" {
                                            self.buttonRegister.alpha = 0.5
                                            self.buttonRegister.isEnabled = false
                                            self.buttonAdminTour.isEnabled = false
                                            self.buttonAdminTour.alpha = 0.5
                                        }
                                    }
                                    if stat.key == "Modelo" {
                                        self.modelo = stat.value as? String ?? "Single Mixto"
                                    }
                                    stats.append(TourStats(title: stat.key, value: stat.value ?? ""))
                                }
                            }
                        case "Players":
                            if let allPlayers = tour.children.allObjects as? [DataSnapshot] {
                                for player in allPlayers {
                                    var fullName : String = ""
                                    var points : Int = 0
                                    var rank : Int = 0
                                    var picture : String = ""
                                    if let allDataPlayer = player.children.allObjects as? [DataSnapshot]{
                                        for dataPlayer in allDataPlayer {
                 
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
                                            
                       
                                        }
                                    }
                                    players.append(PlayerStat(id: player.key, fullName: fullName, points: points, rank: rank, picture: picture))
                                }
                            }
                        case "WinPoints":
                            if let allWinPoints = tour.children.allObjects as? [DataSnapshot] {
                                for points in allWinPoints {
                                    let numero = Int(points.key) ?? 0
                                    winpoints.append(Points(title: points.value as? String ?? "-", number: numero))
                                }
                                winpointsOrder = winpoints.sorted(by: {
                                    $0.number > $1.number
                                })
                            }
                        case "Zonas":
                            if let allZonas = tour.children.allObjects as? [DataSnapshot] {
                                for zona in allZonas {
                                    var numberZonas : [NumberZona] = []
                                    if let allNumbers = zona.children.allObjects as? [DataSnapshot]{
                                        var allPlayers : [ZonaUID] = []
                                        for numbers in allNumbers {
                                            if let allInfoPlayer = numbers.children.allObjects as? [DataSnapshot] {
                                                
                                                for info in allInfoPlayer {
                                                    var fullName : String = ""
                                                    var points : Int = 0
                                                    var lose : Int = 0
                                                    var win : Int = 0
                                                    var picture : String = ""
                                                    if let allData = info.children.allObjects as? [DataSnapshot] {
                                                        for data in allData {
                                                            if data.key == "fullName" {
                                                                fullName = data.value as? String ?? "-"
                                                            }
                                                            if data.key == "points" {
                                                                points = data.value as? Int ?? 0
                                                            }
                                                            if data.key == "lose" {
                                                                lose = data.value as? Int ?? 0
                                                            }
                                                            if data.key == "win" {
                                                                win = data.value as? Int ?? 0
                                                            }
                                                            if data.key == "picture" {
                                                                picture = data.value as? String ?? "-"
                                                            }
                                                        }
                                                    }
                                                    allPlayers.append(ZonaUID(uid: info.key, player: PlayerZona(fullName: fullName, picture: picture, win: win, lose: lose, points: points)))
                                                }
                                            }
                                            numberZonas.append(NumberZona(number: numbers.key, allPlayers: allPlayers))
                                            allPlayers.removeAll()
                                        }
                                    }
                                    let sortedZonas = numberZonas.sorted(by: {
                                        $0.allPlayers[0].player.points > $1.allPlayers[0].player.points
                                    })
                                    zonas.append(Zonas(name: zona.key, numberZona: sortedZonas))
                                    numberZonas.removeAll()
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
                    self.tourament.append(Tourament(name: self.nameTour, stats: stats, players: players, winPoints: winpointsOrder, llave: llaves, zone: zonas))
                }
                self.sortByPosition()
                self.torneoInfoTable.reloadData()
                self.allPointsTable.reloadData()
                self.allLlaves.reloadData()
                self.allZones.reloadData()
                self.pageControlZones.numberOfPages = self.tourament[0].zone.count
                self.pageControlLlaves.numberOfPages = self.tourament[0].llave.count
                
            }
        })
        
    }
    
    @objc func loadZonas() {
        
        tourament[0].zone.removeAll()
        
        ref = Database.database().reference().child("Torneos/\(dayTour)/\(nameTour)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                
                var zonas = [Zonas]()
                
                if let allTour = snapshot.children.allObjects as? [DataSnapshot] {
                    for tour in allTour {
                        
                        if tour.key == "Zonas" {
                            
                            if let allZonas = tour.children.allObjects as? [DataSnapshot] {
                                for zona in allZonas {
                                    var numberZonas : [NumberZona] = []
                                    if let allNumbers = zona.children.allObjects as? [DataSnapshot]{
                                        var allPlayers : [ZonaUID] = []
                                        for numbers in allNumbers {
                                            if let allInfoPlayer = numbers.children.allObjects as? [DataSnapshot] {
                                                
                                                for info in allInfoPlayer {
                                                    var fullName : String = ""
                                                    var points : Int = 0
                                                    var lose : Int = 0
                                                    var win : Int = 0
                                                    var picture : String = ""
                                                    if let allData = info.children.allObjects as? [DataSnapshot] {
                                                        for data in allData {
                                                            if data.key == "fullName" {
                                                                fullName = data.value as? String ?? "-"
                                                            }
                                                            if data.key == "points" {
                                                                points = data.value as? Int ?? 0
                                                            }
                                                            if data.key == "lose" {
                                                                lose = data.value as? Int ?? 0
                                                            }
                                                            if data.key == "win" {
                                                                win = data.value as? Int ?? 0
                                                            }
                                                            if data.key == "picture" {
                                                                picture = data.value as? String ?? "-"
                                                            }
                                                        }
                                                    }
                                                    allPlayers.append(ZonaUID(uid: info.key, player: PlayerZona(fullName: fullName, picture: picture, win: win, lose: lose, points: points)))
                                                }
                                            }
                                            numberZonas.append(NumberZona(number: numbers.key, allPlayers: allPlayers))
                                            allPlayers.removeAll()
                                        }
                                    }
                                    let sortedZonas = numberZonas.sorted(by: {
                                        $0.allPlayers[0].player.points > $1.allPlayers[0].player.points
                                    })
                                    zonas.append(Zonas(name: zona.key, numberZona: sortedZonas))
                                    numberZonas.removeAll()
                                }
                            }
                        }
                    }
                    self.tourament[0].zone.append(contentsOf: zonas)
                }
                self.allZones.reloadData()
            }
        })
        
    }
    
    @objc func loadLlaves() {
        
        tourament[0].llave.removeAll()
        
        ref = Database.database().reference().child("Torneos/\(dayTour)/\(nameTour)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                
                var llaves = [Llaves]()
                
                if let allTour = snapshot.children.allObjects as? [DataSnapshot] {
                    for tour in allTour {
                        
                        if tour.key == "Llaves" {
  
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

                    }
                    }
                    self.tourament[0].llave.append(contentsOf: llaves)
                }

                self.allLlaves.reloadData()
    
            }
        })
        
    }
    
    func ZonasCellTapped(position : String,index : Int,uid1: String, uid2: String) {
        
        let path = "Torneos/\(dayTour)/\(nameTour)/Zonas/\(tourament[0].zone[pageControlZones.currentPage].name)/\(position)/"
        let pathPlayers = "Torneos/\(dayTour)/\(nameTour)/Players/"
        
        UserDefaults.standard.set(path, forKey: "pathModified")
        UserDefaults.standard.set(uid1, forKey: "UID1Pass")
        UserDefaults.standard.set(uid2, forKey: "UID2Pass")
        UserDefaults.standard.set(index, forKey: "indexZone")
        UserDefaults.standard.set(pathPlayers,forKey: "pathPlayers")
        UserDefaults.standard.synchronize()
        
        let vc = AdminChangesZonasVC()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    func LlavesCellTapped(match: String) {
        
        let i = pageControlLlaves.currentPage + 1
        
        let path = "Torneos/\(dayTour)/\(nameTour)/Llaves/\(i)\(tourament[0].llave[pageControlLlaves.currentPage].name)/\(match)"
        let pathPlayers = "Torneos/\(dayTour)/\(nameTour)/Players/"
        
        UserDefaults.standard.set(path, forKey: "pathMatch")
        UserDefaults.standard.set(tourament[0].llave[pageControlLlaves.currentPage].name,forKey: "nameLlave")
        UserDefaults.standard.set(pathPlayers,forKey: "pathPlayers")
        UserDefaults.standard.synchronize()
        
        
        let vc = AdminChangesLlavesVC()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
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
            
            if tourament[0].llave.count == 0 {
                collectionView.setEmptyView(title: "Sin Llaves.", messageImage: #imageLiteral(resourceName: "Icono Torneo Información En Competencia"))
            }
            else {
                returnInt = tourament[0].llave.count
                collectionView.restore()
            }
    
        }
        if collectionView == allZones {
            
            if tourament[0].zone.count == 0 {
                collectionView.setEmptyView(title: "Sin Zonas.", messageImage: #imageLiteral(resourceName: "Icono Torneo Información Próximamente"))
            }else{
                returnInt = tourament[0].zone.count
                collectionView.restore()
            }
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
            cell.delegate = self
            returnCell = cell
        }
        
        if collectionView == allZones {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ZonesCVCell

            cell.labelTitle.text = tourament[0].zone[indexPath.row].name
            cell.updateCellWith(row: tourament[0].zone[indexPath.row].numberZona, max: tourament[0].llave.count * tourament[0].llave.count, double: modelo.contains("Double"))
            
            cell.delegate = self
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
