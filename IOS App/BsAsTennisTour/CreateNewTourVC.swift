//
//  CreateNewTourVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 01/08/2021.
//

import UIKit
import FirebaseDatabase

class CreateNewTourVC: UIViewController, UIScrollViewDelegate {
    
    var ref: DatabaseReference!
    var ref1: DatabaseReference!
    var ref2: DatabaseReference!
    
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
        label.text = UserDefaults.standard.string(forKey: "AdminNewTour")?.uppercased()
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 25)!
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
    
    private let labelFecha : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Fecha"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textFecha : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaFecha : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelHorario : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Horario"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textHorario : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaHorario : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelModelo : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Modelo"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textModelo : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaModelo : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelMax : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Maximo de Jugadores"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textMax : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaMax : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelMatch : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Partidos Asegurados"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textMatch : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaMatch : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelSede : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Sede"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textSede : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaSede : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelCantSet : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "SETS"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textCantSet : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineaCantSet : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelLlaves : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Llaves"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textLlaves : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineLlaves : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelZonas : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Zonas"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textZonas : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineZonas : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let buttonConfirm : UIButton = {
        let button = UIButton()
        button.setTitle("CONFIRMAR", for: .normal)
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
        button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
        setupLayout()
        
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
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(uViewScrollView)
        
        uViewScrollView.addSubview(labelFecha)
        uViewScrollView.addSubview(textFecha)
        uViewScrollView.addSubview(lineaFecha)
        uViewScrollView.addSubview(labelHorario)
        uViewScrollView.addSubview(textHorario)
        uViewScrollView.addSubview(lineaHorario)
        uViewScrollView.addSubview(labelModelo)
        uViewScrollView.addSubview(textModelo)
        uViewScrollView.addSubview(lineaModelo)
        uViewScrollView.addSubview(labelSede)
        uViewScrollView.addSubview(textSede)
        uViewScrollView.addSubview(lineaSede)
        uViewScrollView.addSubview(labelMax)
        uViewScrollView.addSubview(textMax)
        uViewScrollView.addSubview(lineaMax)
        uViewScrollView.addSubview(labelMatch)
        uViewScrollView.addSubview(textMatch)
        uViewScrollView.addSubview(lineaMatch)
        uViewScrollView.addSubview(labelCantSet)
        uViewScrollView.addSubview(textCantSet)
        uViewScrollView.addSubview(lineaCantSet)
        uViewScrollView.addSubview(labelLlaves)
        uViewScrollView.addSubview(textLlaves)
        uViewScrollView.addSubview(lineLlaves)
        uViewScrollView.addSubview(labelZonas)
        uViewScrollView.addSubview(textZonas)
        uViewScrollView.addSubview(lineZonas)
        uViewScrollView.addSubview(buttonConfirm)

        
        NSLayoutConstraint.activate([
        
            
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.heightAnchor.constraint(equalToConstant: 180),
            
            titleTorneo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            titleTorneo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            uViewScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            uViewScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            uViewScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            uViewScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            uViewScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelFecha.topAnchor.constraint(equalTo: uViewScrollView.topAnchor,constant: 20),
            labelFecha.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelFecha.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textFecha.topAnchor.constraint(equalTo: labelFecha.bottomAnchor, constant: 5),
            textFecha.leadingAnchor.constraint(equalTo: labelFecha.leadingAnchor),
            textFecha.trailingAnchor.constraint(equalTo: labelFecha.trailingAnchor),
            textFecha.heightAnchor.constraint(equalToConstant: 30),

            lineaFecha.topAnchor.constraint(equalTo: textFecha.bottomAnchor, constant: 5),
            lineaFecha.leadingAnchor.constraint(equalTo: labelFecha.leadingAnchor),
            lineaFecha.trailingAnchor.constraint(equalTo: labelFecha.trailingAnchor),
            lineaFecha.heightAnchor.constraint(equalToConstant: 2),

            labelHorario.topAnchor.constraint(equalTo: lineaFecha.bottomAnchor,constant: 20),
            labelHorario.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelHorario.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textHorario.topAnchor.constraint(equalTo: labelHorario.bottomAnchor, constant: 5),
            textHorario.leadingAnchor.constraint(equalTo: labelHorario.leadingAnchor),
            textHorario.trailingAnchor.constraint(equalTo: labelHorario.trailingAnchor),
            textHorario.heightAnchor.constraint(equalToConstant: 30),

            lineaHorario.topAnchor.constraint(equalTo: textHorario.bottomAnchor, constant: 5),
            lineaHorario.leadingAnchor.constraint(equalTo: labelHorario.leadingAnchor),
            lineaHorario.trailingAnchor.constraint(equalTo: labelHorario.trailingAnchor),
            lineaHorario.heightAnchor.constraint(equalToConstant: 2),
            
            labelModelo.topAnchor.constraint(equalTo: lineaHorario.bottomAnchor,constant: 20),
            labelModelo.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelModelo.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textModelo.topAnchor.constraint(equalTo: labelModelo.bottomAnchor, constant: 5),
            textModelo.leadingAnchor.constraint(equalTo: labelModelo.leadingAnchor),
            textModelo.trailingAnchor.constraint(equalTo: labelModelo.trailingAnchor),
            textModelo.heightAnchor.constraint(equalToConstant: 30),

            lineaModelo.topAnchor.constraint(equalTo: textModelo.bottomAnchor, constant: 5),
            lineaModelo.leadingAnchor.constraint(equalTo: labelModelo.leadingAnchor),
            lineaModelo.trailingAnchor.constraint(equalTo: labelModelo.trailingAnchor),
            lineaModelo.heightAnchor.constraint(equalToConstant: 2),
            
            labelSede.topAnchor.constraint(equalTo: lineaModelo.bottomAnchor,constant: 20),
            labelSede.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelSede.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textSede.topAnchor.constraint(equalTo: labelSede.bottomAnchor, constant: 5),
            textSede.leadingAnchor.constraint(equalTo: labelSede.leadingAnchor),
            textSede.trailingAnchor.constraint(equalTo: labelSede.trailingAnchor),
            textSede.heightAnchor.constraint(equalToConstant: 30),

            lineaSede.topAnchor.constraint(equalTo: textSede.bottomAnchor, constant: 5),
            lineaSede.leadingAnchor.constraint(equalTo: labelSede.leadingAnchor),
            lineaSede.trailingAnchor.constraint(equalTo: labelSede.trailingAnchor),
            lineaSede.heightAnchor.constraint(equalToConstant: 2),
            
            labelMax.topAnchor.constraint(equalTo: lineaSede.bottomAnchor,constant: 20),
            labelMax.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelMax.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textMax.topAnchor.constraint(equalTo: labelMax.bottomAnchor, constant: 5),
            textMax.leadingAnchor.constraint(equalTo: labelMax.leadingAnchor),
            textMax.trailingAnchor.constraint(equalTo: labelMax.trailingAnchor),
            textMax.heightAnchor.constraint(equalToConstant: 30),

            lineaMax.topAnchor.constraint(equalTo: textMax.bottomAnchor, constant: 5),
            lineaMax.leadingAnchor.constraint(equalTo: labelMax.leadingAnchor),
            lineaMax.trailingAnchor.constraint(equalTo: labelMax.trailingAnchor),
            lineaMax.heightAnchor.constraint(equalToConstant: 2),
            
            labelMatch.topAnchor.constraint(equalTo: lineaMax.bottomAnchor,constant: 20),
            labelMatch.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelMatch.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textMatch.topAnchor.constraint(equalTo: labelMatch.bottomAnchor, constant: 5),
            textMatch.leadingAnchor.constraint(equalTo: labelMatch.leadingAnchor),
            textMatch.trailingAnchor.constraint(equalTo: labelMatch.trailingAnchor),
            textMatch.heightAnchor.constraint(equalToConstant: 30),

            lineaMatch.topAnchor.constraint(equalTo: textMatch.bottomAnchor, constant: 5),
            lineaMatch.leadingAnchor.constraint(equalTo: labelMatch.leadingAnchor),
            lineaMatch.trailingAnchor.constraint(equalTo: labelMatch.trailingAnchor),
            lineaMatch.heightAnchor.constraint(equalToConstant: 2),
            
            labelCantSet.topAnchor.constraint(equalTo: lineaMatch.bottomAnchor,constant: 20),
            labelCantSet.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelCantSet.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textCantSet.topAnchor.constraint(equalTo: labelCantSet.bottomAnchor, constant: 5),
            textCantSet.leadingAnchor.constraint(equalTo: labelCantSet.leadingAnchor),
            textCantSet.trailingAnchor.constraint(equalTo: labelCantSet.trailingAnchor),
            textCantSet.heightAnchor.constraint(equalToConstant: 30),

            lineaCantSet.topAnchor.constraint(equalTo: textCantSet.bottomAnchor, constant: 5),
            lineaCantSet.leadingAnchor.constraint(equalTo: labelCantSet.leadingAnchor),
            lineaCantSet.trailingAnchor.constraint(equalTo: labelCantSet.trailingAnchor),
            lineaCantSet.heightAnchor.constraint(equalToConstant: 2),
            
            labelLlaves.topAnchor.constraint(equalTo: lineaCantSet.bottomAnchor,constant: 20),
            labelLlaves.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelLlaves.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textLlaves.topAnchor.constraint(equalTo: labelLlaves.bottomAnchor, constant: 5),
            textLlaves.leadingAnchor.constraint(equalTo: labelLlaves.leadingAnchor),
            textLlaves.trailingAnchor.constraint(equalTo: labelLlaves.trailingAnchor),
            textLlaves.heightAnchor.constraint(equalToConstant: 30),

            lineLlaves.topAnchor.constraint(equalTo: textLlaves.bottomAnchor, constant: 5),
            lineLlaves.leadingAnchor.constraint(equalTo: labelLlaves.leadingAnchor),
            lineLlaves.trailingAnchor.constraint(equalTo: labelLlaves.trailingAnchor),
            lineLlaves.heightAnchor.constraint(equalToConstant: 2),
            
            labelZonas.topAnchor.constraint(equalTo: lineLlaves.bottomAnchor,constant: 20),
            labelZonas.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelZonas.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textZonas.topAnchor.constraint(equalTo: labelZonas.bottomAnchor, constant: 5),
            textZonas.leadingAnchor.constraint(equalTo: labelZonas.leadingAnchor),
            textZonas.trailingAnchor.constraint(equalTo: labelZonas.trailingAnchor),
            textZonas.heightAnchor.constraint(equalToConstant: 30),

            lineZonas.topAnchor.constraint(equalTo: textZonas.bottomAnchor, constant: 5),
            lineZonas.leadingAnchor.constraint(equalTo: labelZonas.leadingAnchor),
            lineZonas.trailingAnchor.constraint(equalTo: labelZonas.trailingAnchor),
            lineZonas.heightAnchor.constraint(equalToConstant: 2),
            
            buttonConfirm.centerXAnchor.constraint(equalTo: uViewScrollView.centerXAnchor),
            buttonConfirm.topAnchor.constraint(equalTo: lineZonas.bottomAnchor,constant: 20),
            buttonConfirm.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -20),
            buttonConfirm.heightAnchor.constraint(equalToConstant: 40),
            buttonConfirm.widthAnchor.constraint(equalToConstant: 200),
            
                                        
        ])
        
    }

    
    @objc func backPressed() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func confirmAction() {
    
        
        let allData : [String : Any] = ["Area":"Polvo de Ladrillo","Price":1500,"Hour":textHorario.text ?? "12:00PM","Max":textMax.text ?? 16,"Model":textModelo.text ?? "Single Mixto","Matches" : textMatch.text ?? 4,"Sede":textSede.text ?? "Club Mitre"]
        
        let allWins : [String:String] = ["20" : "Participar","40" : "Cuartos","60":"Semifinal","80" : "Final", "100" : "Campeon"]
        
        var tourament : [String : [String:Any]] = ["Info":allData]
        tourament.updateValue(allWins, forKey: "WinPoints")
        
        let infoZona : [String : String] = ["fullName" : "-","lose" : "0","picture" : "personIcon","win" : "0","points":"0"]
        
        var zonas : [String :
                        [String : [String : String]]] = [:]
        
        let cantZona = Int(textZonas.text!) ?? 1
        let total = (Int(textMax.text!) ?? 1) / cantZona
        
        for i in 1...cantZona {
            var allPlayers : [String : [String : String]] = [:]
            for _ in 1...total {
                let random = randomString(length: 7)
                allPlayers.updateValue(infoZona, forKey: random)
            }
            zonas.updateValue(allPlayers, forKey: "Zona \(i)")
        }
        
        var SET : [String : String] = [:]
    
        let cantSet = Int(textCantSet.text!) ?? 1
        
        for i in 1...cantSet {
            SET.updateValue("-", forKey: "\(i)")
        }
       
        var savellave : [String :
                                [String :
                                        [String :
                                                [String :
                                                    [String : [String : String]]]]]] = [:]
    
        
        switch textLlaves.text {
        case "Octavos":
  
            savellave = ["Octavos" :
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
                         "Cuartos" :
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
                         "Semifinal" :
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
                         "Final" :
                                 ["Match1" :
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
            


        case "Cuartos":
            savellave = ["Cuartos" :
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
                         "Semifinal" :
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
                         "Final" :
                                 ["Match1" :
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
        case "Semifinal":
            savellave = ["Semifinal" :
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
                         "Final" :
                                 ["Match1" :
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
        case "Final" :
            savellave = ["Final" :
                                 ["Match1" :
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
        default:
            savellave = ["Final" :
                                 ["Match1" :
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
        }
        
 
        
        ref = Database.database().reference().child("Torneos/\(textFecha.text ?? "1989-01-16")/\(UserDefaults.standard.string(forKey: "AdminNewTour") ?? "Testing Tour")")
        
        ref.setValue(tourament){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              self.showAlert(title: "Error", message: error.localizedDescription)
              return
            } else {

                self.ref1 = Database.database().reference().child("Torneos/\(self.textFecha.text ?? "1989-01-16")/\(UserDefaults.standard.string(forKey: "AdminNewTour") ?? "Testing Tour")/Llaves")
                self.ref1.setValue(savellave){
                    
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                      self.showAlert(title: "Error", message: error.localizedDescription)
                      return
                    } else {
                        
                        self.ref2 = Database.database().reference().child("Torneos/\(self.textFecha.text ?? "1989-01-16")/\(UserDefaults.standard.string(forKey: "AdminNewTour") ?? "Testing Tour")/Zonas")
                        self.ref2.setValue(zonas){
                            
                            (error:Error?, ref:DatabaseReference) in
                            if let error = error {
                              self.showAlert(title: "Error", message: error.localizedDescription)
                              return
                            } else {
                                
                                self.showAlert(title: "Torneo Agendado", message: "Se creó correctamente el torneo \(self.titleTorneo.text ?? "Testing Tour")")
                            }
   
                        }
   
                    }
                    
                }
                
                
       
            }
        }
        
    }
    

}
