//
//  UserRankingVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 28/11/2020.
//

import UIKit
import HGCircularSlider
import SDWebImage
import FirebaseDatabase
import FirebaseStorage
import SwiftyPickerPopover

class UserRankingVC: UIViewController, UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let uid = UserDefaults.standard.string(forKey: "uid") ?? "-"
    
    var allTrophys = ["Torneo Relampago", "Torneo Invierno ", "Torneo Roger"]
    var allPositions = ["1","2","3"]
    
    var maxexp : Int = 1000
    var cantlevels : Int = 10
    var totalexp = 0
    
    var allExperienceNames : [String] = []
    var allExperience : [Int] = []
    
    var rankingPosition : Int = 0
    var rankingPoints : Int = 0
    
    var leftSelected = 1 as Int
    var rightSelected = 0 as Int
    var doubleHand = 1 as Int
    var oneHand = 0 as Int
    
    var ref: DatabaseReference!
    
    let titleName : UILabel = {
        let label = UILabel()
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
    
    private let uView1 : UIView = {
        let view = UIView()
        view.backgroundColor = .colorCoal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.backgroundColor = .colorPaper
        view.isUserInteractionEnabled = true
        view.isOpaque = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewContainer2: UIView = {
        let view = UIView()
        view.backgroundColor = .colorSage
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
    
    let labelNoRanking : UILabel = {
        let label = UILabel()
        label.text = "Sin puntos"
        label.textColor = .mainFacebook
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
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
    
    private let buttonEdit : UIButton  = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pencil_icon_white"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(editName), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
           imageView.image = #imageLiteral(resourceName: "perfilIcon")
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
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
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorPaper
         label.textAlignment = .left
         label.text = "Mano Habil"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
      }()
    
    private let labelIZQ: UILabel = {
          let label = UILabel()
          label.text = "IZQ"
          label.textColor = .colorPop
          label.font = .boldSystemFont(ofSize: 9)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelDER: UILabel = {
          let label = UILabel()
          label.text = "DER"
          label.textColor = .colorMint
          label.font = .boldSystemFont(ofSize: 9)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let uView21 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.grayWhite.cgColor
        uView.layer.cornerRadius = 10
        uView.layer.borderWidth = 2.5
        uView.layer.borderColor = UIColor.colorPop.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView3 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.blackLight.cgColor
        uView.layer.cornerRadius = 10
        uView.layer.borderWidth = 2.5
        uView.layer.borderColor = UIColor.blackLight.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView4 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.grayWhite.cgColor
        uView.layer.cornerRadius = 10
        uView.layer.borderWidth = 2.5
        uView.layer.borderColor = UIColor.colorPop.cgColor
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uView5 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.blackLight.cgColor
        uView.layer.cornerRadius = 10
        uView.layer.borderWidth = 2.5
        uView.layer.borderColor = UIColor.blackLight.cgColor
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
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorPaper
         label.textAlignment = .left
         label.text = "Tipo de Reves"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
      }()
    
    private let labelTwoHands: UILabel = {
          let label = UILabel()
          label.text = "DOS"
          label.textColor = .colorPop
          label.font = .boldSystemFont(ofSize: 9)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelOneHands: UILabel = {
          let label = UILabel()
          label.text = "UNA"
          label.textColor = .colorMint
          label.font = .boldSystemFont(ofSize: 9)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelGender : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Genero"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textGender : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineGender : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelHeight : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Altura"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textHeight : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineHeight : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelAge : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Edad"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textAge : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineAge : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarItemLoad()
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadUserData), name: NSNotification.Name(rawValue: "LoadUserData"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.post(name: Notification.Name("LoadUserData"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func navBarItemLoad(){
        view.backgroundColor = .mainGray
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .colorCoal
        appearance.shadowColor = .colorCoal
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance

    }
    
    func setupLayout() {
        
        view.addSubview(uView1)
        view.addSubview(uViewLeft)
        view.addSubview(uViewRight)
        
        uView1.addSubview(titleName)
        uView1.addSubview(titleLastName)
        
        uView1.addSubview(containerPhotoHeader)
        containerPhotoHeader.addSubview(imagePhotoHeader)
        uView1.addSubview(imageCameraView)
        imageCameraView.addSubview(imageCamera)
        uView1.addSubview(buttonEdit)
        
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
        uViewTable3.addSubview(labelNoRanking)
        
        uViewLeftTable3.addSubview(labelRankingPosition)
        uViewRightTable3.addSubview(labelRankingPoints)
        uViewRightTable3.addSubview(labelRankPuntos)
        uViewLeftTable3.addSubview(labelRankPosicion)
        
        viewContainer.addSubview(viewContainer2)
        viewContainer2.addSubview(labelHabil)
        viewContainer2.addSubview(uView21)
        viewContainer2.addSubview(uView3)
        viewContainer2.addSubview(labelIZQ)
        viewContainer2.addSubview(labelDER)
        
        viewContainer2.addSubview(labelBackhand)
        viewContainer2.addSubview(uView4)
        viewContainer2.addSubview(uView5)
        viewContainer2.addSubview(labelTwoHands)
        viewContainer2.addSubview(labelOneHands)
        
        uView21.addSubview(imageLeft)
        uView3.addSubview(imageRight)
        uView4.addSubview(imageDoubleHand)
        uView5.addSubview(imageOneHand)
        
        viewContainer.addSubview(labelGender)
        viewContainer.addSubview(textGender)
        viewContainer.addSubview(lineGender)
        viewContainer.addSubview(labelHeight)
        viewContainer.addSubview(textHeight)
        viewContainer.addSubview(lineHeight)
        viewContainer.addSubview(labelAge)
        viewContainer.addSubview(textAge)
        viewContainer.addSubview(lineAge)
        
        textGender.delegate = self
        textHeight.delegate = self
        textAge.delegate = self
        
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
            
            buttonEdit.centerYAnchor.constraint(equalTo: titleLastName.topAnchor),
            buttonEdit.widthAnchor.constraint(equalToConstant: 20),
            buttonEdit.heightAnchor.constraint(equalToConstant: 20),
            buttonEdit.centerXAnchor.constraint(equalTo: uViewRight.centerXAnchor,constant: -20),
            
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
            
            containerPhotoHeader.centerYAnchor.constraint(equalTo: uView1.centerYAnchor,constant: -35),
            containerPhotoHeader.centerXAnchor.constraint(equalTo: uViewLeft.centerXAnchor),
            containerPhotoHeader.heightAnchor.constraint(equalTo: uView1.heightAnchor,multiplier: 0.5),
            containerPhotoHeader.widthAnchor.constraint(equalTo: uView1.heightAnchor,multiplier: 0.5),
            
            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.heightAnchor.constraint(equalTo: containerPhotoHeader.heightAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalTo: containerPhotoHeader.widthAnchor),
            
            titleName.topAnchor.constraint(equalTo: containerPhotoHeader.topAnchor,constant: 15),
            titleName.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            titleLastName.topAnchor.constraint(equalTo: titleName.bottomAnchor,constant: 5),
            titleLastName.centerXAnchor.constraint(equalTo: uView1.centerXAnchor),
            
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
            
            labelNoRanking.centerXAnchor.constraint(equalTo: uViewTable3.centerXAnchor),
            labelNoRanking.centerYAnchor.constraint(equalTo: uViewTable3.centerYAnchor,constant: 15),

            
            //INSIDE SCROLLVIEW1
            
            viewContainer2.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            viewContainer2.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            viewContainer2.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            viewContainer2.heightAnchor.constraint(equalToConstant: 150),
            
            labelHabil.topAnchor.constraint(equalTo: viewContainer.topAnchor,constant: 20),
            labelHabil.centerXAnchor.constraint(equalTo: uViewLeft.centerXAnchor),
            
            uView21.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView21.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView21.topAnchor.constraint(equalTo: labelHabil.bottomAnchor, constant: 15),
            uView21.trailingAnchor.constraint(equalTo: labelHabil.centerXAnchor),
            
            uView3.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView3.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView3.topAnchor.constraint(equalTo: labelHabil.bottomAnchor, constant: 15),
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
            
            labelBackhand.centerXAnchor.constraint(equalTo: uViewRight.centerXAnchor),
            labelBackhand.topAnchor.constraint(equalTo: viewContainer.topAnchor,constant: 20),
            
            uView4.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView4.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView4.topAnchor.constraint(equalTo: labelBackhand.bottomAnchor, constant: 15),
            uView4.trailingAnchor.constraint(equalTo: labelBackhand.centerXAnchor),
            
            uView5.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView5.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.18),
            uView5.topAnchor.constraint(equalTo: labelBackhand.bottomAnchor, constant: 15),
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
            
            labelGender.topAnchor.constraint(equalTo: viewContainer2.bottomAnchor, constant: 10),
            labelGender.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 40),
            labelGender.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor,constant: -40),
            
            textGender.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 5),
            textGender.leadingAnchor.constraint(equalTo: labelGender.leadingAnchor),
            textGender.trailingAnchor.constraint(equalTo: labelGender.trailingAnchor),
            textGender.heightAnchor.constraint(equalToConstant: 30),

            lineGender.topAnchor.constraint(equalTo: textGender.bottomAnchor, constant: 5),
            lineGender.leadingAnchor.constraint(equalTo: labelGender.leadingAnchor),
            lineGender.trailingAnchor.constraint(equalTo: labelGender.trailingAnchor),
            lineGender.heightAnchor.constraint(equalToConstant: 2),
            
            labelHeight.topAnchor.constraint(equalTo: lineGender.bottomAnchor, constant: 10),
            labelHeight.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 40),
            labelHeight.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor,constant: -40),
            
            textHeight.topAnchor.constraint(equalTo: labelHeight.bottomAnchor, constant: 5),
            textHeight.leadingAnchor.constraint(equalTo: labelHeight.leadingAnchor),
            textHeight.trailingAnchor.constraint(equalTo: labelHeight.trailingAnchor),
            textHeight.heightAnchor.constraint(equalToConstant: 30),

            lineHeight.topAnchor.constraint(equalTo: textHeight.bottomAnchor, constant: 5),
            lineHeight.leadingAnchor.constraint(equalTo: labelHeight.leadingAnchor),
            lineHeight.trailingAnchor.constraint(equalTo: labelHeight.trailingAnchor),
            lineHeight.heightAnchor.constraint(equalToConstant: 2),

            labelAge.topAnchor.constraint(equalTo: lineHeight.bottomAnchor, constant: 10),
            labelAge.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 40),
            labelAge.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor,constant: -40),
            
            textAge.topAnchor.constraint(equalTo: labelAge.bottomAnchor, constant: 5),
            textAge.leadingAnchor.constraint(equalTo: labelAge.leadingAnchor),
            textAge.trailingAnchor.constraint(equalTo: labelAge.trailingAnchor),
            textAge.heightAnchor.constraint(equalToConstant: 30),

            lineAge.topAnchor.constraint(equalTo: textAge.bottomAnchor, constant: 5),
            lineAge.leadingAnchor.constraint(equalTo: labelAge.leadingAnchor),
            lineAge.trailingAnchor.constraint(equalTo: labelAge.trailingAnchor),
            lineAge.heightAnchor.constraint(equalToConstant: 2),
            lineAge.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -20)

        
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textGender {
            labelGender.textColor = .colorMint
            lineGender.backgroundColor = .colorMint
            pickGender()
        }
        
        if textField == textHeight {
            labelHeight.textColor = .colorMint
            lineHeight.backgroundColor = .colorMint
            pickHeight()
        }
        
        if textField == textAge {
            labelAge.textColor = .colorMint
            lineAge.backgroundColor = .colorMint
            pickAge()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textGender {
            labelGender.textColor = .gray
            lineGender.backgroundColor = .colorCoal
        }
        if textField == textHeight {
            labelHeight.textColor = .gray
            lineHeight.backgroundColor = .colorCoal
        }
        if textField == textAge {
            labelAge.textColor = .gray
            lineAge.backgroundColor = .colorCoal
        }
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
        
        ref = Database.database().reference().child("AdminExp/")
        ref.observeSingleEvent(of: .value, with: { [self] (snapshot) in
            
            if snapshot.exists() {
                if let maxExp = snapshot.childSnapshot(forPath: "MaxExp").value as? Int {
                    self.maxexp = maxExp
                }
                if let maxLevel = snapshot.childSnapshot(forPath: "MaxLevel").value as? Int {
                    self.cantlevels = maxLevel
                }
                
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
        })

       
   
    }
    
    func calculateRanking() {
        
        if rankingPoints != 0 && rankingPosition != 0 {
            uViewLineTable3Vertical.isHidden = false
            labelRankPosicion.isHidden = false
            labelRankingPosition.isHidden = false
            labelRankPuntos.isHidden = false
            labelRankingPoints.isHidden = false
            labelNoRanking.isHidden = true
            
            labelRankingPosition.text = "#\(rankingPosition)"
            labelRankingPoints.text = "\(rankingPoints)"
        }else{
            uViewLineTable3Vertical.isHidden = true
            labelRankPosicion.isHidden = true
            labelRankingPosition.isHidden = true
            labelRankPuntos.isHidden = true
            labelRankingPoints.isHidden = true
            labelNoRanking.isHidden = false
        }
        
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
        
        var data = NSData()
        data = imagePhotoHeader.image!.jpegData(compressionQuality: 0.8)! as NSData
        
        let filePath = "/images/\(uid)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        let storageRef = Storage.storage().reference().child(filePath)
        storageRef.putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }else{
          
                storageRef.downloadURL { (url, error) in
                    
                    if let error = error {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                        return
                        
                    } else {
                        let urlStr:String = (url?.absoluteString) ?? ""
                        
                        self.ref = Database.database().reference().child("Users/\(self.uid)")

                       let user = ["picture" : urlStr]

                       self.ref.updateChildValues(user as [AnyHashable : Any]){
                                  (error:Error?, ref:DatabaseReference) in
                                  if let error = error {
                                    self.showAlert(title: "Error", message: error.localizedDescription)
                                  } else {

                                    self.loadUserData()
                                  }
                               }

                    }
            }
        }

    }
        
      }
    
    @objc func editName() {
        
        let vc = UserChangeName()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true, completion: nil)
        
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
    
    @objc func pressLeftButton(pressed : Bool) {
        
        if leftSelected == 0 {

            leftSelected = 1
            rightSelected = 0
            imageLeft.setImage(#imageLiteral(resourceName: "right-hand-unsel"), for: .normal)
            uView21.backgroundColor = .grayWhite
            uView21.layer.borderColor = UIColor.colorPop.cgColor
            labelIZQ.textColor = .colorPop
            imageRight.setImage(#imageLiteral(resourceName: "left-hand-select"), for: .normal)
            uView3.backgroundColor = .blackLight
            uView3.layer.borderColor = UIColor.blackLight.cgColor
            labelDER.textColor = .colorMint
            
            if pressed {
                ref = Database.database().reference().child("Users/\(self.uid)/hand")
                ref.setValue("left")
            }
            
        }
        
    }
    
    @objc func pressRightButton(pressed : Bool) {
        
        if rightSelected == 0 {
            leftSelected = 0
            rightSelected = 1
            imageLeft.setImage(#imageLiteral(resourceName: "right-hand-select"), for: .normal)
            uView21.backgroundColor = .blackLight
            uView21.layer.borderColor = UIColor.blackLight.cgColor
            labelDER.textColor = .colorPop
            imageRight.setImage(#imageLiteral(resourceName: "left-hand-unsel"), for: .normal)
            uView3.backgroundColor = .grayWhite
            uView3.layer.borderColor = UIColor.colorPop.cgColor
            labelIZQ.textColor = .colorMint
            
            if pressed {
                ref = Database.database().reference().child("Users/\(self.uid)/hand")
                ref.setValue("right")
            }
            
        }
        
    }
    
    @objc func pressDoubleHand(pressed : Bool) {
        
        if doubleHand == 0 {
            
            doubleHand = 1
            oneHand = 0
            imageDoubleHand.setImage(#imageLiteral(resourceName: "backhand-two"), for: .normal)
            uView4.backgroundColor = .grayWhite
            uView4.layer.borderColor = UIColor.colorPop.cgColor
            labelTwoHands.textColor = .colorPop
            imageOneHand.setImage(#imageLiteral(resourceName: "backhand=one-white"), for: .normal)
            uView5.backgroundColor = .blackLight
            uView5.layer.borderColor = UIColor.blackLight.cgColor
            labelOneHands.textColor = .colorMint
            
            if pressed {
                ref = Database.database().reference().child("Users/\(self.uid)/reves")
                ref.setValue("double")
            }
            
        }
        
    }
    
    @objc func pressOneHand(pressed : Bool) {
        
        if oneHand == 0 {
       
            doubleHand = 0
            oneHand = 1
            imageDoubleHand.setImage(#imageLiteral(resourceName: "backhand-two-white"), for: .normal)
            uView4.backgroundColor = .blackLight
            uView4.layer.borderColor = UIColor.blackLight.cgColor
            labelTwoHands.textColor = .colorMint
            imageOneHand.setImage(#imageLiteral(resourceName: "backhand-one"), for: .normal)
            uView5.backgroundColor = .grayWhite
            uView5.layer.borderColor = UIColor.colorPop.cgColor
            labelOneHands.textColor = .colorPop
            
            if pressed {
                ref = Database.database().reference().child("Users/\(self.uid)/reves")
                ref.setValue("onehand")
            }
            
        }
        
    }
    
    @objc func loadUserData() {
        
        allExperience.removeAll()
        allExperienceNames.removeAll()
        
        ref = Database.database().reference().child("Users/\(uid)/")
        ref.observeSingleEvent(of: .value, with: { [self] (snapshot) in
            
            if snapshot.exists() {
                
                
                if let allData = snapshot.children.allObjects as? [DataSnapshot] {
                    for data in allData {
                        
                        switch data.key {
                        case "Experience":
                            if let allExp = data.children.allObjects as? [DataSnapshot] {
                                for exp in allExp {
                                    self.allExperienceNames.append(exp.key)
                                    self.allExperience.append(exp.value as? Int ?? 0)
                                }
                            }
                        case "firstName":
                            self.titleName.text = data.value as? String ?? "-"
                        case "lastName":
                            self.titleLastName.text = data.value as? String ?? "-"
                        case "picture":
                            let imageUrl = URL(string:data.value as? String ?? "-")
                            self.imagePhotoHeader.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "perfilIcon"))
                        case "rank":
                            self.rankingPosition = data.value as? Int ?? 0
                        case "points":
                            self.rankingPoints = data.value as? Int ?? 0
                        case "hand":
                            if data.value as? String ?? "-" == "left" {
                                pressLeftButton(pressed: false)
                            } else if data.value as? String ?? "-" == "right" {
                                pressRightButton(pressed: false)
                            }
                        case "reves":
                            if data.value as? String ?? "-" == "onehand" {
                                pressOneHand(pressed: false)
                            } else if data.value as? String ?? "-" == "double" {
                                pressDoubleHand(pressed: false)
                            }
                        case "gender":
                            self.textGender.text = data.value as? String ?? ""
                        case "height":
                            self.textHeight.text = data.value as? String ?? ""
                        case "age" :
                            self.textAge.text = data.value as? String ?? "-"
                            
                        default:
                            print("LoadUser")
                        }
          
                    }
                }
                calculateExperience()
                calculateRanking()
                self.allExpTable.reloadData()
   
           }
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    func pickGender() {
        
        StringPickerPopover(title: "Genero", choices: ["Masculino","Femenino"])
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textGender.text = selectedString
                    self.textGender.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textGender.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textGender, baseViewController: self)
        
    }
    
    func pickHeight() {
        
        var allHeights : [String] = []
        for n in 150...210 {
            allHeights.append("\(n)")
        }
        
        StringPickerPopover(title: "Altura en Cm", choices: allHeights)
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textHeight.text = selectedString
                    self.textHeight.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textHeight.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textHeight, baseViewController: self)
        
    }
    
    func pickAge() {
        
        var allAges : [String] = []
        for n in 18...60 {
            allAges.append("\(n)")
        }
        
        StringPickerPopover(title: "Altura en Cm", choices: allAges)
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textAge.text = selectedString
                    self.textAge.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textAge.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textAge, baseViewController: self)
        
    }


}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
