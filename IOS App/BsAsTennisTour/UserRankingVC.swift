//
//  UserRankingVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 28/11/2020.
//

import UIKit
import HGCircularSlider

class UserRankingVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var allTrophys = ["Torneo Relampago", "Torneo Invierno ", "Torneo Roger"]
    var allPositions = ["1","2","3"]
    
    var maxexp = 600
    var cantlevels = 6
    var totalexp = 0
    
    var allExperienceNames = ["Año Entrenamiento Academy","Torneos Ganados","Participacion Torneo","Participacion Torneo","Bonificacion"]
    var allExperience = [80,60,40,40,10]
    
    var rankingPosition = "5"
    var rankingPoints = "80"
    
    var leftSelected = 0 as Int
    var rightSelected = 1 as Int
    var doubleHand = 0 as Int
    var oneHand = 1 as Int
    
    
    let titleMain : UILabel = {
        let label = UILabel()
        label.text = "Jugador"
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
    
    let titleName : UILabel = {
        let label = UILabel()
        label.text = "Ezequiel"
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
    
    let titleLastName : UILabel = {
        let label = UILabel()
        label.text = "Martinez"
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
        label.textColor = .colorPop
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 45)
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
        circle.diskColor = .colorMint
        circle.trackColor = .colorGray
        circle.trackFillColor = .colorPop
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
    
    private let scrollView1: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .mainGray
        view.autoresizingMask = .flexibleHeight
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.isExclusiveTouch = true
        view.isHidden = true
        view.canCancelContentTouches = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainGray.withAlphaComponent(0.7)
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
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
    
    private let infoButton : UIButton = {
        let button = UIButton()
        button.setTitle("MIS LOGROS", for: .normal)
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
    
    private let datosButton : UIButton = {
        let button = UIButton()
        button.setTitle("MIS DATOS", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(datosAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton2 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPaper
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    let imageCameraView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 13
        view.clipsToBounds = true
        return view
    }()
    
    
    let imageCamera : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "camera")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
     let containerPhotoHeader : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowOpacity = 0.9
            view.backgroundColor = .clear
            return view
        }()
    
    let imagePhotoHeader: UIImageView = {
           let imageView = UIImageView()
           imageView.image = #imageLiteral(resourceName: "person4")
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
       }()
    
    private let uView21 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.grayWhite.cgColor
        
        uView.layer.masksToBounds = false
        uView.addBorder(.top, color: .lightGray, thickness: 2)
        uView.addBorder(.bottom, color: .lightGray, thickness: 2)
        uView.addBorder(.left, color: .lightGray, thickness: 2)
        uView.addBorder(.right, color: .lightGray, thickness: 1)
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let imageLeft : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-hand-unsel"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressLeftButton), for: .touchUpInside)
        return button
    }()
    
    private let imageRight : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left-hand-select"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressRightButton), for: .touchUpInside)
        return button
    }()
    
    private let labelHabil: UILabel = {
          let label = UILabel()
          label.text = "Mano Hábil"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 18)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelIZQ: UILabel = {
          let label = UILabel()
          label.text = "IZQ"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelDER: UILabel = {
          let label = UILabel()
          label.text = "DER"
          label.textColor = .colorMint
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let uView3 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.blackLight.cgColor
        uView.layer.masksToBounds = false
        uView.addBorder(.top, color: .lightGray, thickness: 2)
        uView.addBorder(.bottom, color: .lightGray, thickness: 2)
        uView.addBorder(.left, color: .lightGray, thickness: 1)
        uView.addBorder(.right, color: .lightGray, thickness: 2)
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView4 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.grayWhite.cgColor
        uView.layer.masksToBounds = false
        uView.addBorder(.top, color: .lightGray, thickness: 2)
        uView.addBorder(.bottom, color: .lightGray, thickness: 2)
        uView.addBorder(.left, color: .lightGray, thickness: 2)
        uView.addBorder(.right, color: .lightGray, thickness: 1)
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView5 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.blackLight.cgColor
        uView.layer.masksToBounds = false
        uView.addBorder(.top, color: .lightGray, thickness: 2)
        uView.addBorder(.bottom, color: .lightGray, thickness: 2)
        uView.addBorder(.left, color: .lightGray, thickness: 1)
        uView.addBorder(.right, color: .lightGray, thickness: 2)
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let imageDoubleHand : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "backhand-two"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressDoubleHand), for: .touchUpInside)
        return button
    }()
    
    private let imageOneHand : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "backhand=one-white"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressOneHand), for: .touchUpInside)
        return button
    }()
    
    private let labelBackhand : UILabel = {
          let label = UILabel()
          label.text = "Tipo Revés"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 18)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTwoHands: UILabel = {
          let label = UILabel()
          label.text = "DOS Manos"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelOneHands: UILabel = {
          let label = UILabel()
          label.text = "UNA Mano"
          label.textColor = .colorMint
          label.font = .boldSystemFont(ofSize: 16)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelAltura: UILabel = {
          let label = UILabel()
          label.text = "Altura"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 18)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelGender: UILabel = {
          let label = UILabel()
          label.text = "Genero"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 18)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelEmail: UILabel = {
          let label = UILabel()
          label.text = "Email"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 18)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let txtAltura: UITextField = {
          let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(string: "Altura", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(1.0)])
            text.textColor = .white
            text.textAlignment = .center
            text.backgroundColor = .darkGray
            text.layer.cornerRadius = 20
            text.layer.borderWidth = 3
            text.layer.borderColor = UIColor.lightGray.cgColor
            text.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
            text.layer.shadowOffset = CGSize(width: 0, height: 0)
            text.layer.shadowOpacity = 1
            text.layer.shadowRadius = 20
            text.layer.masksToBounds = false
            text.translatesAutoresizingMaskIntoConstraints = false
          return text
      }()
    
    let txtGender: UITextField = {
          let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(string: "Genero", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(1.0)])
            text.textColor = .white
            text.textAlignment = .center
            text.backgroundColor = .darkGray
            text.layer.cornerRadius = 20
            text.layer.borderWidth = 3
            text.layer.borderColor = UIColor.lightGray.cgColor
            text.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
            text.layer.shadowOffset = CGSize(width: 0, height: 0)
            text.layer.shadowOpacity = 1
            text.layer.shadowRadius = 20
            text.layer.masksToBounds = false
            text.translatesAutoresizingMaskIntoConstraints = false
          return text
      }()
    
    let txtEmail: UITextField = {
          let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(1.0)])
            text.textColor = .white
            text.textAlignment = .center
            text.backgroundColor = .darkGray
            text.layer.cornerRadius = 20
            text.layer.borderWidth = 3
            text.layer.borderColor = UIColor.lightGray.cgColor
            text.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
            text.layer.shadowOffset = CGSize(width: 0, height: 0)
            text.layer.shadowOpacity = 1
            text.layer.shadowRadius = 20
            text.layer.masksToBounds = false
            text.translatesAutoresizingMaskIntoConstraints = false
          return text
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
        uView1.addSubview(titleName)
        uView1.addSubview(titleLastName)
        
        uView1.addSubview(containerPhotoHeader)
        containerPhotoHeader.addSubview(imagePhotoHeader)
        uView1.addSubview(imageCameraView)
        imageCameraView.addSubview(imageCamera)
        
        view.addSubview(uView2)
        uView2.addSubview(circularExp)
        uView2.addSubview(labelNivel)
        uView1.addSubview(infoButton)
        uView1.addSubview(lineButton1)
        uView1.addSubview(datosButton)
        uView1.addSubview(lineButton2)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView1)
        scrollView1.addSubview(viewContainer)
        
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
        
        uViewLeftTable3.addSubview(labelRankingPosition)
        uViewRightTable3.addSubview(labelRankingPoints)
        uViewRightTable3.addSubview(labelRankPuntos)
        uViewLeftTable3.addSubview(labelRankPosicion)
        
        viewContainer.addSubview(labelHabil)
        viewContainer.addSubview(uView21)
        viewContainer.addSubview(uView3)
        viewContainer.addSubview(labelIZQ)
        viewContainer.addSubview(labelDER)
        
        viewContainer.addSubview(labelBackhand)
        viewContainer.addSubview(uView4)
        viewContainer.addSubview(uView5)
        viewContainer.addSubview(labelTwoHands)
        viewContainer.addSubview(labelOneHands)
        
        uView21.addSubview(imageLeft)
        uView3.addSubview(imageRight)
        uView4.addSubview(imageDoubleHand)
        uView5.addSubview(imageOneHand)
        
        viewContainer.addSubview(labelGender)
        viewContainer.addSubview(labelAltura)
        viewContainer.addSubview(labelEmail)
        viewContainer.addSubview(txtGender)
        viewContainer.addSubview(txtAltura)
        viewContainer.addSubview(txtEmail)
        
        //CONSTRAINTS
        NSLayoutConstraint.activate([
        
            uViewLeft.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            uViewLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uViewLeft.topAnchor.constraint(equalTo: view.topAnchor),
            
            uViewRight.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            uViewRight.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uViewRight.topAnchor.constraint(equalTo: view.topAnchor),
            
            uView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uView1.heightAnchor.constraint(equalToConstant: 180),
            
            uViewLeft.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            uViewLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uViewLeft.topAnchor.constraint(equalTo: view.topAnchor),
            
            titleName.centerYAnchor.constraint(equalTo: uView1.centerYAnchor,constant: -15),
            titleName.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            titleLastName.centerYAnchor.constraint(equalTo: uView1.centerYAnchor,constant: 15),
            titleLastName.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: uView1.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: uView1.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: uView1.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: uView1.bottomAnchor),
            
            lineButton1.leadingAnchor.constraint(equalTo: uViewLeft.leadingAnchor, constant: 30),
            lineButton1.trailingAnchor.constraint(equalTo: uViewLeft.trailingAnchor, constant: -30),
            lineButton1.bottomAnchor.constraint(equalTo: uView1.bottomAnchor),
            lineButton1.heightAnchor.constraint(equalToConstant: 3),
            
            infoButton.centerXAnchor.constraint(equalTo: uViewLeft.centerXAnchor),
            infoButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            infoButton.heightAnchor.constraint(equalToConstant: 15),
            infoButton.widthAnchor.constraint(equalTo: uViewLeft.widthAnchor),
            
            lineButton2.leadingAnchor.constraint(equalTo: uViewRight.leadingAnchor, constant: 30),
            lineButton2.trailingAnchor.constraint(equalTo: uViewRight.trailingAnchor, constant: -30),
            lineButton2.bottomAnchor.constraint(equalTo: uView1.bottomAnchor),
            lineButton2.heightAnchor.constraint(equalToConstant: 3),
            
            datosButton.centerXAnchor.constraint(equalTo: uViewRight.centerXAnchor),
            datosButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10),
            datosButton.heightAnchor.constraint(equalToConstant: 15),
            datosButton.widthAnchor.constraint(equalTo: uViewRight.widthAnchor),
            
            containerPhotoHeader.centerYAnchor.constraint(equalTo: uView1.centerYAnchor),
            containerPhotoHeader.centerXAnchor.constraint(equalTo: uViewLeft.centerXAnchor),
            containerPhotoHeader.heightAnchor.constraint(equalTo: uView1.heightAnchor,multiplier: 0.5),
            containerPhotoHeader.widthAnchor.constraint(equalTo: uView1.heightAnchor,multiplier: 0.5),
            
            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.heightAnchor.constraint(equalTo: containerPhotoHeader.heightAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalTo: containerPhotoHeader.widthAnchor),
            
            imageCameraView.widthAnchor.constraint(equalTo: imagePhotoHeader.widthAnchor,multiplier: 0.25),
            imageCameraView.heightAnchor.constraint(equalTo: imagePhotoHeader.heightAnchor,multiplier: 0.25),
            imageCameraView.trailingAnchor.constraint(equalTo: imagePhotoHeader.trailingAnchor, constant: -5),
            imageCameraView.bottomAnchor.constraint(equalTo: imagePhotoHeader.bottomAnchor),
           
            
            imageCamera.heightAnchor.constraint(equalTo: imageCameraView.heightAnchor),
            imageCamera.widthAnchor.constraint(equalTo: imageCameraView.widthAnchor),
            imageCamera.centerXAnchor.constraint(equalTo: imageCameraView.centerXAnchor),
            imageCamera.centerYAnchor.constraint(equalTo: imageCameraView.centerYAnchor, constant: -1),
            
            uView2.centerYAnchor.constraint(equalTo: uView1.bottomAnchor),
            uView2.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            uView2.heightAnchor.constraint(equalToConstant: 100),
            uView2.widthAnchor.constraint(equalToConstant: 100),
            
            circularExp.topAnchor.constraint(equalTo: uView2.topAnchor),
            circularExp.leadingAnchor.constraint(equalTo: uView2.leadingAnchor),
            circularExp.trailingAnchor.constraint(equalTo: uView2.trailingAnchor),
            circularExp.bottomAnchor.constraint(equalTo: uView2.bottomAnchor),
            
    //        labelProxLevel.topAnchor.constraint(equalTo: circularExp.bottomAnchor),
    //        labelProxLevel.centerXAnchor.constraint(equalTo: circularExp.centerXAnchor),
            
            labelNivel.centerXAnchor.constraint(equalTo: uView2.centerXAnchor),
            labelNivel.centerYAnchor.constraint(equalTo: uView2.centerYAnchor),
            
//            labelLevel.topAnchor.constraint(equalTo: uView1.bottomAnchor, constant: 10),
//            labelLevel.centerXAnchor.constraint(equalTo: uViewLeft.centerXAnchor),
//            labelLevel.heightAnchor.constraint(equalToConstant: 30),
            
            //ALL SCROLLVIEW
            
            scrollView.topAnchor.constraint(equalTo: circularExp.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView1.topAnchor.constraint(equalTo: circularExp.bottomAnchor, constant: 20),
            scrollView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            
            viewContainer.centerXAnchor.constraint(equalTo: scrollView1.centerXAnchor),
            viewContainer.topAnchor.constraint(equalTo: scrollView1.topAnchor, constant: 8),
            viewContainer.leadingAnchor.constraint(equalTo: scrollView1.leadingAnchor, constant: 8),
            viewContainer.trailingAnchor.constraint(equalTo: scrollView1.trailingAnchor, constant: -8),
            viewContainer.bottomAnchor.constraint(equalTo: scrollView1.bottomAnchor, constant: -8),
            
            //INSIDE SCROLLVIEW
            
            uViewTable1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            uViewTable1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            uViewTable1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            uViewTable1.heightAnchor.constraint(equalToConstant: 220),
            
            labelTrophys.topAnchor.constraint(equalTo: uViewTable1.topAnchor, constant: 10),
            labelTrophys.leadingAnchor.constraint(equalTo: uViewTable1.leadingAnchor, constant: 10),
            labelTrophys.heightAnchor.constraint(equalToConstant: 30),
            
            uViewLineTable1.topAnchor.constraint(equalTo: labelTrophys.bottomAnchor,constant: 5),
            uViewLineTable1.leadingAnchor.constraint(equalTo: uViewTable1.leadingAnchor),
            uViewLineTable1.trailingAnchor.constraint(equalTo: uViewTable1.trailingAnchor),
            uViewLineTable1.heightAnchor.constraint(equalToConstant: 1),
            
            allTrophysTable.topAnchor.constraint(equalTo: uViewLineTable1.bottomAnchor,constant: 5),
            allTrophysTable.leadingAnchor.constraint(equalTo: uViewTable1.leadingAnchor),
            allTrophysTable.trailingAnchor.constraint(equalTo: uViewTable1.trailingAnchor),
            allTrophysTable.bottomAnchor.constraint(equalTo: uViewTable1.bottomAnchor),
            
            uViewTable2.topAnchor.constraint(equalTo: uViewTable1.bottomAnchor,constant: 20),
            uViewTable2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            uViewTable2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            uViewTable2.heightAnchor.constraint(equalToConstant: 220),
            
            labelExperience.topAnchor.constraint(equalTo: uViewTable2.topAnchor, constant: 10),
            labelExperience.leadingAnchor.constraint(equalTo: uViewTable2.leadingAnchor, constant: 10),
            labelExperience.heightAnchor.constraint(equalToConstant: 30),

            uViewLineTable2.topAnchor.constraint(equalTo: labelExperience.bottomAnchor,constant: 5),
            uViewLineTable2.leadingAnchor.constraint(equalTo: uViewTable2.leadingAnchor),
            uViewLineTable2.trailingAnchor.constraint(equalTo: uViewTable2.trailingAnchor),
            uViewLineTable2.heightAnchor.constraint(equalToConstant: 1),
            
            allExpTable.topAnchor.constraint(equalTo: uViewLineTable2.bottomAnchor,constant: 5),
            allExpTable.leadingAnchor.constraint(equalTo: uViewTable2.leadingAnchor),
            allExpTable.trailingAnchor.constraint(equalTo: uViewTable2.trailingAnchor),
            allExpTable.bottomAnchor.constraint(equalTo: uViewTable2.bottomAnchor),
            
            labelTotalExp.topAnchor.constraint(equalTo: uViewTable2.topAnchor,constant: 10),
            labelTotalExp.trailingAnchor.constraint(equalTo: uViewTable2.trailingAnchor,constant: -20),
            labelTotalExp.heightAnchor.constraint(equalToConstant: 25),

            uViewTable3.topAnchor.constraint(equalTo: uViewTable2.bottomAnchor,constant: 20),
            uViewTable3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            uViewTable3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            uViewTable3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            uViewTable3.heightAnchor.constraint(equalToConstant: 220),
            
            labelStats.topAnchor.constraint(equalTo: uViewTable3.topAnchor, constant: 10),
            labelStats.leadingAnchor.constraint(equalTo: uViewTable3.leadingAnchor, constant: 10),
            labelStats.heightAnchor.constraint(equalToConstant: 30),
            
            uViewLineTable3.topAnchor.constraint(equalTo: labelStats.bottomAnchor,constant: 5),
            uViewLineTable3.leadingAnchor.constraint(equalTo: uViewTable3.leadingAnchor),
            uViewLineTable3.trailingAnchor.constraint(equalTo: uViewTable3.trailingAnchor),
            uViewLineTable3.heightAnchor.constraint(equalToConstant: 1),
            
            uViewLineTable3Vertical.centerXAnchor.constraint(equalTo: uViewTable3.centerXAnchor),
            uViewLineTable3Vertical.topAnchor.constraint(equalTo: uViewLineTable3.bottomAnchor),
            uViewLineTable3Vertical.bottomAnchor.constraint(equalTo: uViewTable3.bottomAnchor),
            uViewLineTable3Vertical.widthAnchor.constraint(equalToConstant: 1),
            
            uViewLeftTable3.topAnchor.constraint(equalTo: uViewLineTable3.bottomAnchor),
            uViewLeftTable3.leadingAnchor.constraint(equalTo: uViewTable3.leadingAnchor),
            uViewLeftTable3.trailingAnchor.constraint(equalTo: uViewLineTable3Vertical.trailingAnchor),
            uViewLeftTable3.bottomAnchor.constraint(equalTo: uViewTable3.bottomAnchor),
            
            uViewRightTable3.topAnchor.constraint(equalTo: uViewLineTable3.bottomAnchor),
            uViewRightTable3.leadingAnchor.constraint(equalTo: uViewLineTable3Vertical.leadingAnchor),
            uViewRightTable3.trailingAnchor.constraint(equalTo: uViewTable3.trailingAnchor),
            uViewRightTable3.bottomAnchor.constraint(equalTo: uViewTable3.bottomAnchor),
            
            labelRankingPosition.widthAnchor.constraint(equalTo: uViewLeftTable3.widthAnchor),
            labelRankingPosition.centerXAnchor.constraint(equalTo: uViewLeftTable3.centerXAnchor),
            labelRankingPosition.centerYAnchor.constraint(equalTo: uViewLeftTable3.centerYAnchor),
            
            labelRankPosicion.widthAnchor.constraint(equalTo: uViewLeftTable3.widthAnchor),
            labelRankPosicion.centerXAnchor.constraint(equalTo: uViewLeftTable3.centerXAnchor),
            labelRankPosicion.bottomAnchor.constraint(equalTo: labelRankingPosition.topAnchor, constant: 10),

            labelRankingPoints.widthAnchor.constraint(equalTo: uViewRightTable3.widthAnchor),
            labelRankingPoints.centerXAnchor.constraint(equalTo: uViewRightTable3.centerXAnchor),
            labelRankingPoints.centerYAnchor.constraint(equalTo: uViewRightTable3.centerYAnchor),
            
            labelRankPuntos.bottomAnchor.constraint(equalTo: labelRankingPoints.topAnchor, constant: 10),
            labelRankPuntos.widthAnchor.constraint(equalTo: uViewRightTable3.widthAnchor),
            labelRankPuntos.centerXAnchor.constraint(equalTo: uViewRightTable3.centerXAnchor),
            
            
            //INSIDE SCROLLVIEW1
            
            labelHabil.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelHabil.topAnchor.constraint(equalTo: viewContainer.topAnchor,constant: 10),
            
            uView21.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView21.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView21.topAnchor.constraint(equalTo: labelHabil.bottomAnchor, constant: 5),
            uView21.trailingAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            uView3.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView3.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView3.topAnchor.constraint(equalTo: labelHabil.bottomAnchor, constant: 5),
            uView3.leadingAnchor.constraint(equalTo: uView21.trailingAnchor),
            
            imageLeft.centerXAnchor.constraint(equalTo: uView21.centerXAnchor),
            imageLeft.centerYAnchor.constraint(equalTo: uView21.centerYAnchor),
            imageLeft.widthAnchor.constraint(equalTo: uView21.widthAnchor, multiplier: 0.65),
            imageLeft.heightAnchor.constraint(equalTo: uView21.heightAnchor, multiplier: 0.65),
            
            imageRight.centerXAnchor.constraint(equalTo: uView3.centerXAnchor),
            imageRight.centerYAnchor.constraint(equalTo: uView3.centerYAnchor),
            imageRight.widthAnchor.constraint(equalTo: uView3.widthAnchor, multiplier: 0.65),
            imageRight.heightAnchor.constraint(equalTo: uView3.heightAnchor, multiplier: 0.65),
            
            labelIZQ.topAnchor.constraint(equalTo: uView21.topAnchor, constant: 5),
            labelIZQ.leadingAnchor.constraint(equalTo: uView21.leadingAnchor, constant: 5),
            labelDER.topAnchor.constraint(equalTo: uView3.topAnchor, constant: 5),
            labelDER.trailingAnchor.constraint(equalTo: uView3.trailingAnchor, constant: -5),
            
            labelBackhand.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelBackhand.topAnchor.constraint(equalTo: uView3.bottomAnchor, constant: 10),
            
            uView4.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView4.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView4.topAnchor.constraint(equalTo: labelBackhand.bottomAnchor, constant: 5),
            uView4.trailingAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            uView5.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView5.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.30),
            uView5.topAnchor.constraint(equalTo: labelBackhand.bottomAnchor, constant: 5),
            uView5.leadingAnchor.constraint(equalTo: uView4.trailingAnchor),
            
            imageDoubleHand.centerXAnchor.constraint(equalTo: uView4.centerXAnchor),
            imageDoubleHand.centerYAnchor.constraint(equalTo: uView4.centerYAnchor),
            imageDoubleHand.widthAnchor.constraint(equalTo: uView4.widthAnchor, multiplier: 0.65),
            imageDoubleHand.heightAnchor.constraint(equalTo: uView4.heightAnchor, multiplier: 0.65),
            
            imageOneHand.centerXAnchor.constraint(equalTo: uView5.centerXAnchor),
            imageOneHand.centerYAnchor.constraint(equalTo: uView5.centerYAnchor),
            imageOneHand.widthAnchor.constraint(equalTo: uView5.widthAnchor, multiplier: 0.65),
            imageOneHand.heightAnchor.constraint(equalTo: uView5.heightAnchor, multiplier: 0.65),
            
            labelTwoHands.topAnchor.constraint(equalTo: uView4.topAnchor, constant: 5),
            labelTwoHands.leadingAnchor.constraint(equalTo: uView4.leadingAnchor, constant: 5),
            labelOneHands.topAnchor.constraint(equalTo: uView5.topAnchor, constant: 5),
            labelOneHands.trailingAnchor.constraint(equalTo: uView5.trailingAnchor, constant: -5),
            
            labelGender.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelGender.topAnchor.constraint(equalTo: uView4.bottomAnchor, constant: 10),

            txtGender.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 5),
            txtGender.leadingAnchor.constraint(equalTo: uView4.leadingAnchor),
            txtGender.trailingAnchor.constraint(equalTo: uView5.trailingAnchor),
            txtGender.heightAnchor.constraint(equalToConstant: 40),

            labelAltura.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelAltura.topAnchor.constraint(equalTo: txtGender.bottomAnchor, constant: 10),

            txtAltura.topAnchor.constraint(equalTo: labelAltura.bottomAnchor, constant: 5),
            txtAltura.leadingAnchor.constraint(equalTo: uView4.leadingAnchor),
            txtAltura.trailingAnchor.constraint(equalTo: uView5.trailingAnchor),
            txtAltura.heightAnchor.constraint(equalToConstant: 40),

            labelEmail.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelEmail.topAnchor.constraint(equalTo: txtAltura.bottomAnchor, constant: 10),

            txtEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 5),
            txtEmail.leadingAnchor.constraint(equalTo: uView4.leadingAnchor),
            txtEmail.trailingAnchor.constraint(equalTo: uView5.trailingAnchor),
            txtEmail.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor,constant: -15),
            txtEmail.heightAnchor.constraint(equalToConstant: 40),

        
        
        ])

       
        scrollView.delegate = self
        scrollView1.delegate = self
        allTrophysTable.delegate = self
        allTrophysTable.dataSource = self
        allExpTable.delegate = self
        allExpTable.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.PhotoProfileChange))
        imageCameraView.addGestureRecognizer(tap)

    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      containerPhotoHeader.layer.cornerRadius = containerPhotoHeader.frame.height / 2.0
      imagePhotoHeader.layer.cornerRadius = imagePhotoHeader.frame.height / 2.0
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
                myCell.imageTrophy.image = #imageLiteral(resourceName: "Pelota Oro")
            }
            if allPositions[indexPath.row] == "2" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "Pelota Plata")
            }
            if allPositions[indexPath.row] == "3" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "Pelota Bronce")
            }
            if allPositions[indexPath.row] == "4" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "Pelota Resto")
            }
            if allPositions[indexPath.row] == "5" {
                myCell.imageTrophy.image = #imageLiteral(resourceName: "Pelota Plata Negativo")
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
        
        totalexp = allExperience.reduce(0, +)

        let difference = maxexp / cantlevels
        circularExp.maximumValue = CGFloat(difference)
        
        let nivel = Int(totalexp / difference) + 1
        labelNivel.text = "\(nivel)"
        
        let expNivel = totalexp - ((nivel - 1) * difference)
        circularExp.endPointValue = CGFloat(expNivel)
        
        let restExp = difference - expNivel
        let expSum = difference * nivel
        
        labelProxLevel.text = "Next +\(restExp)Exp"
        labelTotalExp.text = "\(totalexp)/\(expSum)Exp"
        
        if totalexp == maxexp {
            labelNivel.textColor = .mainOrange
            circularExp.trackColor = .mainOrange
        }
   
    }
    
    func calculateRanking() {
        
        labelRankingPosition.text = "#\(rankingPosition)"
        labelRankingPoints.text = "\(rankingPoints)"
        
    }
    
    @objc func PhotoProfileChange(){
          let myImagePicker = UIImagePickerController()
          myImagePicker.delegate = self
          myImagePicker.allowsEditing = true
          myImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                
          self.present(myImagePicker, animated: true, completion: nil)
         
      }
      
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
      {
          
          let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
          
          imagePhotoHeader.image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
          self.dismiss(animated: true, completion: nil)
          
       
          
         uploadImagePic()
          
          
      }
  
      func uploadImagePic(){
        
        print(123)
        
      }
    
    @objc func infoAction() {
        
        infoButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        datosButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        scrollView.isHidden = false
        scrollView1.isHidden = true
        
    }
    
    @objc func datosAction() {
        
        infoButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        datosButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        scrollView1.isHidden = false
        
    }
    
    @objc func pressLeftButton() {
        
        if leftSelected == 0 {
            
            leftSelected = 1
            rightSelected = 0
            imageLeft.setImage(#imageLiteral(resourceName: "right-hand-select"), for: .normal)
            uView21.backgroundColor = .blackLight
            labelIZQ.textColor = .colorMint
            imageRight.setImage(#imageLiteral(resourceName: "left-hand-unsel"), for: .normal)
            uView3.backgroundColor = .grayWhite
            labelDER.textColor = .darkGray
            
        }
        
    }
    
    @objc func pressRightButton() {
        
        if rightSelected == 0 {
            leftSelected = 0
            rightSelected = 1
            imageLeft.setImage(#imageLiteral(resourceName: "right-hand-unsel"), for: .normal)
            uView21.backgroundColor = .grayWhite
            labelDER.textColor = .colorMint
            imageRight.setImage(#imageLiteral(resourceName: "left-hand-select"), for: .normal)
            uView3.backgroundColor = .blackLight
            labelIZQ.textColor = .darkGray
            
        }
        
    }
    
    @objc func pressDoubleHand() {
        
        if doubleHand == 0 {
            
            doubleHand = 1
            oneHand = 0
            imageDoubleHand.setImage(#imageLiteral(resourceName: "backhand-two-white"), for: .normal)
            uView4.backgroundColor = .blackLight
            labelTwoHands.textColor = .colorMint
            imageOneHand.setImage(#imageLiteral(resourceName: "backhand-one"), for: .normal)
            uView5.backgroundColor = .grayWhite
            labelOneHands.textColor = .darkGray
            
        }
        
    }
    
    @objc func pressOneHand() {
        
        if oneHand == 0 {
       
            doubleHand = 0
            oneHand = 1
            imageDoubleHand.setImage(#imageLiteral(resourceName: "backhand-two"), for: .normal)
            uView4.backgroundColor = .grayWhite
            labelTwoHands.textColor = .darkGray
            imageOneHand.setImage(#imageLiteral(resourceName: "backhand=one-white"), for: .normal)
            uView5.backgroundColor = .blackLight
            labelOneHands.textColor = .colorMint
            
        }
        
    }


}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
