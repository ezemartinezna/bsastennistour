//
//  CreateNewTourVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 01/08/2021.
//

import UIKit
import FirebaseDatabase
import SwiftyPickerPopover

class CreateNewTourVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    

    var ref: DatabaseReference!
    var ref1: DatabaseReference!
    var ref2: DatabaseReference!
    
    var allWinsKey : [String] = ["100","80"]
    var allWinsValue : [String] = ["Campeón","Subcampeón"]
    
    let buttonMenu : UIButton = {
         let button = UIButton(type: .custom)
         button.frame = CGRect(x: 0.0,y: 0.0, width: 40, height: 40)
         let origImage = UIImage(named: "leftArrowWhite")
         let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
         button.setImage(tintedImage, for: .normal)
         button.tintColor = .white
         return button
     }()
    
    let buttonConfirm : UIButton = {
         let button = UIButton(type: .custom)
         button.frame = CGRect(x: 0.0,y: 0.0, width: 40, height: 40)
         let origImage = UIImage(named: "check_icon")
         button.setImage(origImage, for: .normal)
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
    
    private let buttonEdit : UIButton  = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pencil_icon_white"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    let datePicker : UIDatePicker = {
       let datepicker = UIDatePicker()
        datepicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle = .compact
        }
        datepicker.locale = Locale(identifier: "es")
        datepicker.tintColor = .colorPop
        datepicker.backgroundColor = .clear
        datepicker.translatesAutoresizingMaskIntoConstraints = false
       return datepicker
    }()
    

    let viewDatePicker : UIView = {
        let uview = UIView()
        uview.clipsToBounds = true
        uview.backgroundColor = UIColor.colorCoal
        uview.translatesAutoresizingMaskIntoConstraints = false
        return uview
    }()
    
//    private let lineaFecha : UIView = {
//        let uView = UIView()
//        uView.backgroundColor = .colorCoal
//        uView.translatesAutoresizingMaskIntoConstraints = false
//        return uView
//    }()
    
    private let datosButton : UIButton = {
        let button = UIButton()
        button.setTitle("DATOS", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(datosAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPop
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let llavesButton : UIButton = {
        let button = UIButton()
        button.setTitle("LLAVES - ZONAS", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(llavesAction), for: .touchUpInside)
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
    
    private let uViewScrollView1 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let labelModelo : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
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
         label.textColor = .gray
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
         label.textColor = .gray
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
         label.textColor = .gray
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
         label.textColor = .gray
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
         label.textColor = .gray
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
         label.textColor = .gray
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
    
    private let labelPoints : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Puntos"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let viewPoints : UIView = {
        let uView = UIView()
        uView.layer.borderWidth = 2
        uView.layer.borderColor = UIColor.colorCoal.cgColor
        uView.layer.cornerRadius = 10
        uView.layer.masksToBounds = true
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let allPointsTB : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TorneoInfoCell.self, forCellReuseIdentifier: "thirdCell")
        table.rowHeight = 50
        return table
    }()
    
    private let buttonPlus : UIButton  = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Icono - Más (Verde)"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(addPoint), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonMinus : UIButton  = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Icono - Menos (Rojo)"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(removePoint), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        let menuBarItemRight = UIBarButtonItem(customView: buttonConfirm)
        menuBarItemRight.customView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBarItemRight.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItemRight
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        buttonMenu.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        buttonConfirm.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    func setupLayout() {
        
        view.backgroundColor = .mainGray
        view.addSubview(viewContainer)
        
        viewContainer.addSubview(titleTorneo)
        viewContainer.addSubview(viewDatePicker)
        viewDatePicker.addSubview(datePicker)
        viewContainer.addSubview(buttonEdit)

        viewContainer.addSubview(uViewBackgroundLeft)
        viewContainer.addSubview(uViewBackgroundRight)
        view.addSubview(datosButton)
        uViewBackgroundLeft.addSubview(lineButton1)
        view.addSubview(llavesButton)
        uViewBackgroundRight.addSubview(lineButton2)
        
        view.addSubview(scrollView)
        view.addSubview(scrollView1)
        scrollView.delegate = self
        scrollView.addSubview(uViewScrollView)
        
        scrollView1.delegate = self
        scrollView1.addSubview(uViewScrollView1)
        
        uViewScrollView.addSubview(labelModelo)
        uViewScrollView.addSubview(textModelo)
        textModelo.delegate = self
        uViewScrollView.addSubview(lineaModelo)
        uViewScrollView.addSubview(labelSede)
        uViewScrollView.addSubview(textSede)
        textSede.delegate = self
        uViewScrollView.addSubview(lineaSede)
        uViewScrollView.addSubview(labelMax)
        uViewScrollView.addSubview(textMax)
        textMax.delegate = self
        uViewScrollView.addSubview(lineaMax)
        uViewScrollView.addSubview(labelMatch)
        uViewScrollView.addSubview(textMatch)
        textMatch.delegate = self
        uViewScrollView.addSubview(lineaMatch)
        uViewScrollView.addSubview(labelPoints)
        uViewScrollView.addSubview(buttonMinus)
        uViewScrollView.addSubview(buttonPlus)
        uViewScrollView.addSubview(viewPoints)
        viewPoints.addSubview(allPointsTB)
        allPointsTB.dataSource = self
        allPointsTB.delegate = self
        
        //LLAVES Y ZONAS
        
        uViewScrollView1.addSubview(labelCantSet)
        uViewScrollView1.addSubview(textCantSet)
        textCantSet.delegate = self
        uViewScrollView1.addSubview(lineaCantSet)
        uViewScrollView1.addSubview(labelLlaves)
        uViewScrollView1.addSubview(textLlaves)
        textLlaves.delegate = self
        uViewScrollView1.addSubview(lineLlaves)
        uViewScrollView1.addSubview(labelZonas)
        uViewScrollView1.addSubview(textZonas)
        textZonas.delegate = self
        uViewScrollView1.addSubview(lineZonas)
        
        NSLayoutConstraint.activate([
        
            
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.heightAnchor.constraint(equalToConstant: 180),
            
            titleTorneo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            titleTorneo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            
            viewDatePicker.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            viewDatePicker.topAnchor.constraint(equalTo: titleTorneo.bottomAnchor,constant: 5),
            viewDatePicker.heightAnchor.constraint(equalToConstant: 40),
            viewDatePicker.widthAnchor.constraint(equalToConstant: 200),
            datePicker.centerXAnchor.constraint(equalTo: viewDatePicker.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: viewDatePicker.centerYAnchor),
            
            buttonEdit.centerYAnchor.constraint(equalTo: viewDatePicker.centerYAnchor),
            buttonEdit.leadingAnchor.constraint(equalTo: viewDatePicker.trailingAnchor, constant: 8),
            buttonEdit.widthAnchor.constraint(equalToConstant: 20),
            buttonEdit.heightAnchor.constraint(equalToConstant: 20),
            
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
            
            datosButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor),
            datosButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            datosButton.heightAnchor.constraint(equalToConstant: 15),
            datosButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor),
            
            lineButton2.leadingAnchor.constraint(equalTo: uViewBackgroundRight.leadingAnchor, constant: 20),
            lineButton2.trailingAnchor.constraint(equalTo: uViewBackgroundRight.trailingAnchor, constant: -20),
            lineButton2.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            lineButton2.heightAnchor.constraint(equalToConstant: 3),
            
            llavesButton.centerXAnchor.constraint(equalTo: uViewBackgroundRight.centerXAnchor),
            llavesButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10),
            llavesButton.heightAnchor.constraint(equalToConstant: 15),
            llavesButton.widthAnchor.constraint(equalTo: uViewBackgroundRight.widthAnchor),
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            uViewScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            uViewScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            uViewScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            uViewScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            uViewScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            scrollView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView1.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView1.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            uViewScrollView1.centerXAnchor.constraint(equalTo: scrollView1.centerXAnchor),
            uViewScrollView1.topAnchor.constraint(equalTo: scrollView1.topAnchor),
            uViewScrollView1.leadingAnchor.constraint(equalTo: scrollView1.leadingAnchor),
            uViewScrollView1.trailingAnchor.constraint(equalTo: scrollView1.trailingAnchor),
            uViewScrollView1.bottomAnchor.constraint(equalTo: scrollView1.bottomAnchor),
            
            labelModelo.topAnchor.constraint(equalTo: uViewScrollView.topAnchor,constant: 20),
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
            
            labelPoints.topAnchor.constraint(equalTo: lineaMatch.bottomAnchor,constant: 20),
            labelPoints.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            
            buttonMinus.centerYAnchor.constraint(equalTo: labelPoints.centerYAnchor),
            buttonMinus.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),
            buttonMinus.heightAnchor.constraint(equalToConstant: 30),
            buttonMinus.widthAnchor.constraint(equalToConstant: 30),
            
            buttonPlus.centerYAnchor.constraint(equalTo: labelPoints.centerYAnchor),
            buttonPlus.trailingAnchor.constraint(equalTo: buttonMinus.leadingAnchor, constant: -20),
            buttonPlus.heightAnchor.constraint(equalToConstant: 30),
            buttonPlus.widthAnchor.constraint(equalToConstant: 30),
            
            viewPoints.topAnchor.constraint(equalTo: labelPoints.bottomAnchor,constant: 20),
            viewPoints.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            viewPoints.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),
            viewPoints.heightAnchor.constraint(equalToConstant: 150),
            viewPoints.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -10),
            
            allPointsTB.topAnchor.constraint(equalTo: viewPoints.topAnchor),
            allPointsTB.leadingAnchor.constraint(equalTo: viewPoints.leadingAnchor),
            allPointsTB.trailingAnchor.constraint(equalTo: viewPoints.trailingAnchor),
            allPointsTB.bottomAnchor.constraint(equalTo: viewPoints.bottomAnchor),

            //LLAVES Y ZONAS
            
            labelCantSet.topAnchor.constraint(equalTo: uViewScrollView1.topAnchor,constant: 20),
            labelCantSet.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor,constant: 40),
            labelCantSet.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor,constant: -40),

            textCantSet.topAnchor.constraint(equalTo: labelCantSet.bottomAnchor, constant: 5),
            textCantSet.leadingAnchor.constraint(equalTo: labelCantSet.leadingAnchor),
            textCantSet.trailingAnchor.constraint(equalTo: labelCantSet.trailingAnchor),
            textCantSet.heightAnchor.constraint(equalToConstant: 30),

            lineaCantSet.topAnchor.constraint(equalTo: textCantSet.bottomAnchor, constant: 5),
            lineaCantSet.leadingAnchor.constraint(equalTo: labelCantSet.leadingAnchor),
            lineaCantSet.trailingAnchor.constraint(equalTo: labelCantSet.trailingAnchor),
            lineaCantSet.heightAnchor.constraint(equalToConstant: 2),
            
            labelLlaves.topAnchor.constraint(equalTo: lineaCantSet.bottomAnchor,constant: 20),
            labelLlaves.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor,constant: 40),
            labelLlaves.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor,constant: -40),

            textLlaves.topAnchor.constraint(equalTo: labelLlaves.bottomAnchor, constant: 5),
            textLlaves.leadingAnchor.constraint(equalTo: labelLlaves.leadingAnchor),
            textLlaves.trailingAnchor.constraint(equalTo: labelLlaves.trailingAnchor),
            textLlaves.heightAnchor.constraint(equalToConstant: 30),

            lineLlaves.topAnchor.constraint(equalTo: textLlaves.bottomAnchor, constant: 5),
            lineLlaves.leadingAnchor.constraint(equalTo: labelLlaves.leadingAnchor),
            lineLlaves.trailingAnchor.constraint(equalTo: labelLlaves.trailingAnchor),
            lineLlaves.heightAnchor.constraint(equalToConstant: 2),
            
            labelZonas.topAnchor.constraint(equalTo: lineLlaves.bottomAnchor,constant: 20),
            labelZonas.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor,constant: 40),
            labelZonas.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor,constant: -40),

            textZonas.topAnchor.constraint(equalTo: labelZonas.bottomAnchor, constant: 5),
            textZonas.leadingAnchor.constraint(equalTo: labelZonas.leadingAnchor),
            textZonas.trailingAnchor.constraint(equalTo: labelZonas.trailingAnchor),
            textZonas.heightAnchor.constraint(equalToConstant: 30),

            lineZonas.topAnchor.constraint(equalTo: textZonas.bottomAnchor, constant: 5),
            lineZonas.leadingAnchor.constraint(equalTo: labelZonas.leadingAnchor),
            lineZonas.trailingAnchor.constraint(equalTo: labelZonas.trailingAnchor),
            lineZonas.heightAnchor.constraint(equalToConstant: 2),
            lineZonas.bottomAnchor.constraint(equalTo: uViewScrollView1.bottomAnchor,constant: -20)
            
                                        
        ])
        
    }

    
    @objc func backPressed() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func confirmAction() {
    
        let saveday = self.formatterUS.string(from: datePicker.date)
//        let savedayArg = self.formatterARG.string(from: datePicker.date)
        let saveHour = self.formatterHour.string(from: datePicker.date)
        
        let allData : [String : Any] = ["Area":"Polvo de Ladrillo","Price":1500,"Hour":saveHour,"Max":textMax.text ?? 16,"Model":textModelo.text ?? "Single Mixto","Matches" : textMatch.text ?? 4,"Sede":textSede.text ?? "Club Mitre"]
        
        var tourament : [String : [String:Any]] = ["Info":allData]
        
        var winwin : [String : String] = [:]
        for i in 0..<allWinsKey.count {
            winwin.updateValue(allWinsValue[i], forKey: allWinsKey[i])
        }
        
        tourament.updateValue(winwin, forKey: "WinPoints")
        
        let infoZona : [String : Any] = ["fullName" : "-","lose" : 0,"picture" : "perfilIcon","win" : 0,"points":0,"uid":randomString(length: 7)]
      
        var zonas : [String :
                        [String : [String : Any]]] = [:]
        
        let cantZona = Int(textZonas.text!) ?? 1
        let total = (Int(textMax.text!) ?? 1) / cantZona
        
        for i in 1...cantZona {
            var allPlayers : [String : [String : Any]] = [:]
            for f in 1...total {
                allPlayers.updateValue(infoZona, forKey: "\(f)")
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
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
            


        case "Cuartos":
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
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
        case "Semifinal":
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
                                     ["S1" :
                                         ["1q2w3e4r" :["SET":SET]],
                                      "S2":
                                         ["1q2w3e4r" :["SET":SET]],
                                     ]
            ]]
        case "Final" :
            savellave = ["1Final" :
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
        
        
        
 

        
        ref = Database.database().reference().child("Torneos/\(saveday)/\(UserDefaults.standard.string(forKey: "AdminNewTour") ?? "Testing Tour")")
        
        ref.setValue(tourament){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              self.showAlert(title: "Error", message: error.localizedDescription)
              return
            } else {

                self.ref1 = Database.database().reference().child("Torneos/\(saveday)/\(UserDefaults.standard.string(forKey: "AdminNewTour") ?? "Testing Tour")/Llaves")
                self.ref1.setValue(savellave){
                    
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                      self.showAlert(title: "Error", message: error.localizedDescription)
                      return
                    } else {
                        
                        self.ref2 = Database.database().reference().child("Torneos/\(saveday)/\(UserDefaults.standard.string(forKey: "AdminNewTour") ?? "Testing Tour")/Zonas")
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
    
    @objc func editAction() {
        datePicker.isHidden = false
    }
    
    @objc func datosAction() {
        
        datosButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        llavesButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        scrollView.isHidden = false
        scrollView1.isHidden = true
        
    }
    
    @objc func llavesAction() {
        
        datosButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        llavesButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        scrollView1.isHidden = false
        
    }
    
    func cantSETS() {
        
        StringPickerPopover(title: "Cantidad de Sets", choices: ["1","3","5"])
                .setImageNames(["ballTennisResize","ballTennisResize","ballTennisResize"])
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textCantSet.text = selectedString
                    self.textCantSet.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textCantSet.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textCantSet, baseViewController: self)
        
    }
    
    func cantLlaves() {
        
        StringPickerPopover(title: "Elige Fase Inicial:", choices: ["Octavos","Cuartos","Semifinal","Final"])
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textLlaves.text = selectedString
                    self.textLlaves.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textLlaves.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textLlaves, baseViewController: self)
        
    }
    
    func cantZonas() {
        
        StringPickerPopover(title: "Cantidad de Zonas:", choices: ["1","2","3","4","5","6","7","8","9"])
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textZonas.text = selectedString
                    self.textZonas.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textZonas.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textZonas, baseViewController: self)
        
    }
    
    func cantModelo() {
        
        StringPickerPopover(title: "Tipo de Modelo:", choices: ["Single Mixto","Doubles Mixto","Single Hombre","Double Hombre","Single Mujer","Double Mujer"])
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
                    
                    self.textModelo.text = selectedString
                    self.textModelo.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textModelo.endEditing(true)}
                                 
                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
                .appear(originView: textModelo, baseViewController: self)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textCantSet {
            labelCantSet.textColor = .colorMint
            lineaCantSet.backgroundColor = .colorMint
            cantSETS()
        }
        
        if textField == textLlaves {
            labelLlaves.textColor = .colorMint
            lineLlaves.backgroundColor = .colorMint
            cantLlaves()
        }
        
        if textField == textZonas {
            labelZonas.textColor = .colorMint
            lineZonas.backgroundColor = .colorMint
            cantZonas()
        }
        
        if textField == textModelo {
            labelModelo.textColor = .colorMint
            lineaModelo.backgroundColor = .colorMint
            cantModelo()
        }
        
        if textField == textMax {
            labelMax.textColor = .colorMint
            lineaMax.backgroundColor = .colorMint
        }
        
        if textField == textMatch {
            labelMatch.textColor = .colorMint
            lineaMatch.backgroundColor = .colorMint
        }
        
        if textField == textSede {
            labelSede.textColor = .colorMint
            lineaSede.backgroundColor = .colorMint
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textCantSet {
            labelCantSet.textColor = .gray
            lineaCantSet.backgroundColor = .colorCoal
        }
        
        if textField == textLlaves {
            labelLlaves.textColor = .gray
            lineLlaves.backgroundColor = .colorCoal
        }
        
        if textField == textZonas {
            labelZonas.textColor = .gray
            lineZonas.backgroundColor = .colorCoal
        }
        
        if textField == textModelo {
            labelModelo.textColor = .gray
            lineaModelo.backgroundColor = .colorCoal
        }
        
        if textField == textMax {
            labelMax.textColor = .gray
            lineaMax.backgroundColor = .colorCoal
        }
        if textField == textMatch {
            labelMatch.textColor = .gray
            lineaMatch.backgroundColor = .colorCoal
        }
        
        if textField == textSede {
            labelSede.textColor = .gray
            lineaSede.backgroundColor = .colorCoal
        }
    }
    
    @objc func addPoint() {
        
        let dialogMessage = UIAlertController(title: NSLocalizedString("Puntos Torneo", comment: ""), message: NSLocalizedString("Agregue el nombre y los puntos", comment: ""), preferredStyle: .alert)
        dialogMessage.addTextField(configurationHandler: {(textField) in
                               textField.placeholder = NSLocalizedString("Ingrese el Nombre", comment: "")
        })
         dialogMessage.addTextField(configurationHandler: {(textField) in
                                textField.placeholder = NSLocalizedString("Ingrese el puntaje", comment: "")
         })
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        let namePoint = dialogMessage.textFields![0]
        let numberPoint = dialogMessage.textFields![1]
         
         if namePoint.text != "" && numberPoint.text != ""  {
            self.allWinsValue.append(namePoint.text ?? "")
            self.allWinsKey.append(numberPoint.text ?? "")
            self.allPointsTB.reloadData()
         }
        })
                     
        dialogMessage.addAction(ok)
                  
     self.present(dialogMessage, animated: true, completion: nil)

        
    }
    
    @objc func removePoint() {
        
        if allWinsKey.count != 0 && allWinsValue.count != 0 {
        allWinsValue.removeLast()
        allWinsKey.removeLast()
        allPointsTB.reloadData()
        }
    }
    
    
    fileprivate let formatterUS: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
     }()
    
    fileprivate let formatterARG: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "dd-MM-yyyy"
       return formatter
    }()
    
    fileprivate let formatterHour: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "HH:mm"
       return formatter
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

extension CreateNewTourVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWinsKey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as! TorneoInfoCell
        myCell.labelTitle1.text = allWinsValue[indexPath.row]
        myCell.labelTitle2.text = "\(allWinsKey[indexPath.row]) pts"
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dialogMessage = UIAlertController(title: NSLocalizedString("Puntos Torneo", comment: ""), message: NSLocalizedString("Agregue el nombre y los puntos", comment: ""), preferredStyle: .alert)
        dialogMessage.addTextField(configurationHandler: {(textField) in
                               textField.placeholder = NSLocalizedString("Ingrese el Nombre", comment: "")
                               textField.text = self.allWinsValue[indexPath.row]
        })
         dialogMessage.addTextField(configurationHandler: {(textField) in
                                textField.placeholder = NSLocalizedString("Ingrese el puntaje", comment: "")
                                textField.text = self.allWinsKey[indexPath.row]
         })
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        let namePoint = dialogMessage.textFields![0]
        let numberPoint = dialogMessage.textFields![1]
         
         if namePoint.text != "" && numberPoint.text != ""  {
            self.allWinsValue[indexPath.row] = namePoint.text ?? ""
            self.allWinsKey[indexPath.row] = numberPoint.text ?? ""
            self.allPointsTB.reloadData()
         }
        })
                     
        dialogMessage.addAction(ok)
                  
     self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}


extension UIDatePicker {

var textColor: UIColor? {
    set {
        setValue(newValue, forKeyPath: "textColor")
    }
    get {
        return value(forKeyPath: "textColor") as? UIColor
    }
  }
}
