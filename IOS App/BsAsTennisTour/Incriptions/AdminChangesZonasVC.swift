//
//  AdminChangesVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 10/08/2021.
//

import UIKit
import FirebaseDatabase
import SwiftyPickerPopover

class AdminChangesZonasVC: UIViewController, UITextFieldDelegate {
    
    let pathPlayer = UserDefaults.standard.string(forKey: "pathPlayers") ?? "-"
    var path = UserDefaults.standard.string(forKey: "pathModified") ?? "-"
    var uid : String = UserDefaults.standard.string(forKey: "UID1Pass") ?? "-"
    var picture : String = ""
    var uid1 : String = UserDefaults.standard.string(forKey: "UID2Pass") ?? "-"
    var picture1 : String = ""
    var arrayPictures : [String] = []
    var arrayUIDS : [String] = []
    
    let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .colorPaper
           view.translatesAutoresizingMaskIntoConstraints = false
           view.clipsToBounds = true
           view.layer.cornerRadius = 10
           view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
           return view
       }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.text = "EDITAR POSICION \(UserDefaults.standard.integer(forKey: "indexZone") + 1)"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelNamePlayer : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Nombre del Jugador"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textNamePlayer : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineNamePlayer : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelNamePlayer1 : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Nombre del Jugador"
         label.isHidden = true
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textNamePlayer1 : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.isHidden = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineNamePlayer1 : UIView = {
        let uView = UIView()
        uView.isHidden = true
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelWin : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Ganados"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textWin : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.isUserInteractionEnabled = true
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineWin : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let uViewWin : UIView = {
        let uView = UIView()
        uView.isUserInteractionEnabled = true
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelLose : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Perdidos"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textLose : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineLose : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let uViewLose : UIView = {
        let uView = UIView()
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
    
    private let textPoints : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let linePoints : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let uViewPoints : UIView = {
        let uView = UIView()
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let stackview : UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.isUserInteractionEnabled = true
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonEdit : UIButton = {
        let button = UIButton()
        button.setTitle("EDITAR", for: .normal)
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
        button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        return button
    }()
    
    let blackView: UIView = {
           let view = UIView()
        view.backgroundColor = .clear
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var dismissLayerBtn: UIButton = {
         let btn = UIButton()
         btn.backgroundColor = .clear
         btn.addTarget(self, action: #selector(DismissVW), for: .touchUpInside)
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
    
    var ref: DatabaseReference!

    var traiTextNamePlayerCenter : NSLayoutConstraint?
    var traiLabelNamePlayerCenter : NSLayoutConstraint?
    var traiLineNamePlayerCenter : NSLayoutConstraint?
    
    var traiTextNamePlayerView : NSLayoutConstraint?
    var traiLabelNamePlayerView : NSLayoutConstraint?
    var traiLineNamePlayerView : NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loadInfoPlayer()


    }
    
    func setupLayout() {

        view.backgroundColor = UIColor.clear
        view.addSubview(blackView)
        blackView.addSubview(dismissLayerBtn)
        
        view.addSubview(containerView)
        
        view.addSubview(labelTitle)
        view.addSubview(labelNamePlayer)
        view.addSubview(textNamePlayer)
        view.addSubview(lineNamePlayer)
        view.addSubview(labelNamePlayer1)
        view.addSubview(textNamePlayer1)
        view.addSubview(lineNamePlayer1)
        stackview.addArrangedSubview(uViewWin)
        stackview.addArrangedSubview(uViewLose)
        stackview.addArrangedSubview(uViewPoints)
        view.addSubview(stackview)

        uViewWin.addSubview(labelWin)
        view.addSubview(textWin)
        uViewWin.addSubview(lineWin)
        uViewLose.addSubview(labelLose)
        view.addSubview(textLose)
        uViewLose.addSubview(lineLose)
        uViewPoints.addSubview(labelPoints)
        view.addSubview(textPoints)
        uViewPoints.addSubview(linePoints)
          
        view.addSubview(buttonEdit)
        
        textNamePlayer.delegate = self
        textNamePlayer1.delegate = self
        textWin.delegate = self
        textLose.delegate = self
        textPoints.delegate = self
        
//        traiTextNamePlayerCenter = textNamePlayer.trailingAnchor.constraint(equalTo: view.centerXAnchor,constant: -10)
        traiLabelNamePlayerCenter = labelNamePlayer.trailingAnchor.constraint(equalTo: view.centerXAnchor,constant: -10)
//        traiLineNamePlayerCenter = lineNamePlayer.trailingAnchor.constraint(equalTo: view.centerXAnchor,constant: -10)
        traiLabelNamePlayerCenter?.isActive = false
                                            
        traiLabelNamePlayerView = labelNamePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40)
//        traiTextNamePlayerView = textNamePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        traiLabelNamePlayerView?.isActive = true
        
        NSLayoutConstraint.activate([
            
            blackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            blackView.topAnchor.constraint(equalTo: view.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dismissLayerBtn.topAnchor.constraint(equalTo: blackView.topAnchor),
            dismissLayerBtn.leadingAnchor.constraint(equalTo: blackView.leadingAnchor),
            dismissLayerBtn.trailingAnchor.constraint(equalTo: blackView.trailingAnchor),
            dismissLayerBtn.bottomAnchor.constraint(equalTo: blackView.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: blackView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 20),
            
            labelNamePlayer.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 20),
            labelNamePlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            
            textNamePlayer.topAnchor.constraint(equalTo: labelNamePlayer.bottomAnchor, constant: 5),
            textNamePlayer.leadingAnchor.constraint(equalTo: labelNamePlayer.leadingAnchor),
            textNamePlayer.trailingAnchor.constraint(equalTo: labelNamePlayer.trailingAnchor),
            textNamePlayer.heightAnchor.constraint(equalToConstant: 30),

            lineNamePlayer.topAnchor.constraint(equalTo: textNamePlayer.bottomAnchor, constant: 5),
            lineNamePlayer.leadingAnchor.constraint(equalTo: labelNamePlayer.leadingAnchor),
            lineNamePlayer.trailingAnchor.constraint(equalTo: labelNamePlayer.trailingAnchor),
            lineNamePlayer.heightAnchor.constraint(equalToConstant: 2),
            
            labelNamePlayer1.topAnchor.constraint(equalTo: labelNamePlayer.topAnchor),
            labelNamePlayer1.leadingAnchor.constraint(equalTo: view.centerXAnchor,constant: 10),
            labelNamePlayer1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            
            textNamePlayer1.leadingAnchor.constraint(equalTo: view.centerXAnchor,constant: 10),
            textNamePlayer1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            textNamePlayer1.topAnchor.constraint(equalTo: textNamePlayer.topAnchor),
            textNamePlayer1.heightAnchor.constraint(equalToConstant: 30),
 
            lineNamePlayer1.topAnchor.constraint(equalTo: lineNamePlayer.topAnchor),
            lineNamePlayer1.leadingAnchor.constraint(equalTo: view.centerXAnchor,constant: 10),
            lineNamePlayer1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineNamePlayer1.heightAnchor.constraint(equalToConstant: 2),
            
            stackview.topAnchor.constraint(equalTo: lineNamePlayer.bottomAnchor,constant: 10),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            stackview.heightAnchor.constraint(equalToConstant: 50),
            
            labelWin.topAnchor.constraint(equalTo: uViewWin.topAnchor),
            labelWin.leadingAnchor.constraint(equalTo: uViewWin.leadingAnchor),
            labelWin.trailingAnchor.constraint(equalTo: uViewWin.trailingAnchor),
            
            textWin.topAnchor.constraint(equalTo: labelWin.bottomAnchor, constant: 5),
            textWin.leadingAnchor.constraint(equalTo: uViewWin.leadingAnchor),
            textWin.trailingAnchor.constraint(equalTo: uViewWin.trailingAnchor),
            textWin.heightAnchor.constraint(equalToConstant: 30),

            lineWin.topAnchor.constraint(equalTo: textWin.bottomAnchor, constant: 5),
            lineWin.leadingAnchor.constraint(equalTo: labelWin.leadingAnchor),
            lineWin.trailingAnchor.constraint(equalTo: labelWin.trailingAnchor),
            lineWin.heightAnchor.constraint(equalToConstant: 2),
            
            labelLose.topAnchor.constraint(equalTo: uViewLose.topAnchor),
            labelLose.leadingAnchor.constraint(equalTo: uViewLose.leadingAnchor),
            labelLose.trailingAnchor.constraint(equalTo: uViewLose.trailingAnchor),
            
            textLose.topAnchor.constraint(equalTo: labelLose.bottomAnchor, constant: 5),
            textLose.leadingAnchor.constraint(equalTo: uViewLose.leadingAnchor),
            textLose.trailingAnchor.constraint(equalTo: uViewLose.trailingAnchor),
            textLose.heightAnchor.constraint(equalToConstant: 30),

            lineLose.topAnchor.constraint(equalTo: textLose.bottomAnchor, constant: 5),
            lineLose.leadingAnchor.constraint(equalTo: textLose.leadingAnchor),
            lineLose.trailingAnchor.constraint(equalTo: textLose.trailingAnchor),
            lineLose.heightAnchor.constraint(equalToConstant: 2),
            
            labelPoints.topAnchor.constraint(equalTo: uViewPoints.topAnchor),
            labelPoints.leadingAnchor.constraint(equalTo: uViewPoints.leadingAnchor),
            labelPoints.trailingAnchor.constraint(equalTo: uViewPoints.trailingAnchor),
            
            textPoints.topAnchor.constraint(equalTo: labelPoints.bottomAnchor, constant: 5),
            textPoints.leadingAnchor.constraint(equalTo: uViewPoints.leadingAnchor),
            textPoints.trailingAnchor.constraint(equalTo: uViewPoints.trailingAnchor),
            textPoints.heightAnchor.constraint(equalToConstant: 30),

            linePoints.topAnchor.constraint(equalTo: textPoints.bottomAnchor, constant: 5),
            linePoints.leadingAnchor.constraint(equalTo: textPoints.leadingAnchor),
            linePoints.trailingAnchor.constraint(equalTo: textPoints.trailingAnchor),
            linePoints.heightAnchor.constraint(equalToConstant: 2),

            buttonEdit.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 60),
            buttonEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonEdit.heightAnchor.constraint(equalToConstant: 40),
            buttonEdit.widthAnchor.constraint(equalToConstant: 200),

        ])
        
    }
    
    func loadInfoPlayer() {
        
        let pathToView = "\(path)\(uid)"
        
        ref = Database.database().reference().child(pathToView)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                if let allData = snapshot.children.allObjects as? [DataSnapshot] {
                    for data in allData {
                        if data.key == "fullName" {
                            self.textNamePlayer.text = data.value as? String
                        }
                        if data.key == "lose" {
                            self.textLose.text = "\(data.value as? Int ?? 0)"
                        }
                        if data.key == "win" {
                            self.textWin.text = "\(data.value as? Int ?? 0)"
                        }
                        if data.key == "points" {
                            self.textPoints.text = "\(data.value as? Int ?? 0)"
                        }
                        if data.key == "picture" {
                            self.picture = data.value as? String ?? "-"
                        }
                    }
                }
            }
        })
        
        if uid1 != "-" {
            
            let pathToView = "\(path)\(uid1)"
            
            ref = Database.database().reference().child(pathToView)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in

                if snapshot.exists() {
                    if let allData = snapshot.children.allObjects as? [DataSnapshot] {
                        for data in allData {
                            if data.key == "fullName" {
                                self.textNamePlayer1.text = data.value as? String
                                self.textNamePlayer1.isHidden = false
                                self.labelNamePlayer1.isHidden = false
                                self.lineNamePlayer1.isHidden = false
                                self.traiLabelNamePlayerCenter?.isActive = true
                                self.traiLabelNamePlayerView?.isActive = false
                                self.labelNamePlayer.text = "Nombre Jugador 1"
                                self.labelNamePlayer1.text = "Nombre Jugador 2"
                                
                                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                                    self.view.layoutIfNeeded()

                                }, completion: nil)
                            }
                            if data.key == "picture" {
                                self.picture1 = data.value as? String ?? "-"
                            }
                        }
                    }
                }
            })
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textWin {
            labelWin.textColor = .colorMint
            lineWin.backgroundColor = .colorMint
            picknumber(textFieldChanged: textWin)
        }
        
        if textField == textLose {
            labelLose.textColor = .colorMint
            lineLose.backgroundColor = .colorMint
            picknumber(textFieldChanged: textLose)
        }
        
        if textField == textPoints {
            labelPoints.textColor = .colorMint
            linePoints.backgroundColor = .colorMint
            picknumber(textFieldChanged: textPoints)
        }
        
        if textField == textNamePlayer {
            labelNamePlayer.textColor = .colorMint
            lineNamePlayer.backgroundColor = .colorMint
            pickPlayer()
        }
        if textField == textNamePlayer1 {
            labelNamePlayer1.textColor = .colorMint
            lineNamePlayer1.backgroundColor = .colorMint
            pickPlayer1()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textWin {
            labelWin.textColor = .gray
            lineWin.backgroundColor = .colorCoal
        }
        
        if textField == textLose {
            labelLose.textColor = .gray
            lineLose.backgroundColor = .colorCoal
        }
        
        if textField == textPoints {
            labelPoints.textColor = .gray
            linePoints.backgroundColor = .colorCoal
        }
        
        if textField == textNamePlayer {
            labelNamePlayer.textColor = .gray
            lineNamePlayer.backgroundColor = .colorCoal
        }
        
        if textField == textNamePlayer1 {
            labelNamePlayer1.textColor = .gray
            lineNamePlayer1.backgroundColor = .colorCoal
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func pickPlayer() {
        
        ref = Database.database().reference().child(pathPlayer)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                var arrayPlayers : [String] = []
                
                if let allPlayers = snapshot.children.allObjects as? [DataSnapshot] {
                    for player in allPlayers {
                        if let allData = player.children.allObjects as? [DataSnapshot] {
                            for data in allData {
                                if data.key == "fullName" {
                                    arrayPlayers.append(data.value as? String ?? "-")
                                }
                                if data.key == "picture" {
                                    self.arrayPictures.append(data.value as? String ?? "-")
                                }
                            }
                            self.arrayUIDS.append(player.key)
                        }
                    }
                }
                
                StringPickerPopover(title: "Ingrese el Jugador:", choices: arrayPlayers)
                        .setSelectedRow(0)
                    .setValueChange(action: { _, selectedDate,argData  in
                            print("current date \(selectedDate)")
                        })
                        .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in

                            self.textNamePlayer.text = selectedString
                            self.uid = self.arrayUIDS[selectedRow]
                            self.picture = self.arrayPictures[selectedRow]
                            self.textNamePlayer.endEditing(true)
                        })
                        .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textNamePlayer.endEditing(true)}

                        )
                        .setSize(height: 150)
                        .setFontColor(.colorCoal)
                    .appear(originView: self.textNamePlayer, baseViewController: self)
            }
        })
    }
    
    func pickPlayer1() {
        
        ref = Database.database().reference().child(pathPlayer)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                var arrayPlayers : [String] = []
                
                if let allPlayers = snapshot.children.allObjects as? [DataSnapshot] {
                    for player in allPlayers {
                        if let allData = player.children.allObjects as? [DataSnapshot] {
                            for data in allData {
                                if data.key == "fullName" {
                                    arrayPlayers.append(data.value as? String ?? "-")
                                }
                                if data.key == "picture" {
                                    self.arrayPictures.append(data.value as? String ?? "-")
                                }
                            }
                            self.arrayUIDS.append(player.key)
                        }
                    }
                }
                
                StringPickerPopover(title: "Ingrese el Jugador:", choices: arrayPlayers)
                        .setSelectedRow(0)
                    .setValueChange(action: { _, selectedDate,argData  in
                            print("current date \(selectedDate)")
                        })
                        .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in

                            self.textNamePlayer1.text = selectedString
                            self.uid1 = self.arrayUIDS[selectedRow]
                            self.picture1 = self.arrayPictures[selectedRow]
                            self.textNamePlayer1.endEditing(true)
                        })
                        .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textNamePlayer1.endEditing(true)}

                        )
                        .setSize(height: 150)
                        .setFontColor(.colorCoal)
                    .appear(originView: self.textNamePlayer1, baseViewController: self)
            }
        })
    }
    
    func picknumber(textFieldChanged : UITextField) {
        
        var arrayNumber : [String] = []
        for i in 0...100 {
            arrayNumber.append("\(i)")
        }
        
        textFieldChanged.resignFirstResponder()
        
        StringPickerPopover(title: "Ingrese el numero:", choices: arrayNumber)
                .setSelectedRow(0)
            .setValueChange(action: { _, selectedDate,argData  in
                    print("current date \(selectedDate)")
                })
                .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in

                    textFieldChanged.text = selectedString
                    textFieldChanged.endEditing(true)
                })
                .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textNamePlayer.endEditing(true)}

                )
                .setSize(height: 150)
                .setFontColor(.colorCoal)
            .appear(originView: textFieldChanged, baseViewController: self)
        
    }
    
    @objc func editAction() {
        
        var dataChanged : [String:[String:Any]] = [:]
        
        if self.uid1 == "-" {
    
        dataChanged = [self.uid : ["fullName" : textNamePlayer.text ?? "-",
                                            "lose" : Int(textLose.text!) ?? 0,
                                            "win" : Int(textWin.text!) ?? 0,
                                            "points" : Int(textPoints.text!) ?? 0,
                                            "picture" : picture,
        ]]
        
        ref = Database.database().reference().child(path)
        
        ref.setValue(dataChanged) { [self]
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              self.showAlert(title: "Error", message: error.localizedDescription)
              return
            } else {
              self.showAlert(title: "Posicion Cambiada", message: "Se modificó con exito")
            }
        }
        }else{
            
            dataChanged = [self.uid1 : ["fullName" : self.textNamePlayer1.text ?? "-",
                           "lose" : Int(self.textLose.text!) ?? 0,
                           "win" : Int(self.textWin.text!) ?? 0,
                           "points" : Int(self.textPoints.text!) ?? 0,
                           "picture" : self.picture1,
            ],
                               self.uid : ["fullName" : textNamePlayer.text ?? "-",
                                                                   "lose" : Int(textLose.text!) ?? 0,
                                                                   "win" : Int(textWin.text!) ?? 0,
                                                                   "points" : Int(textPoints.text!) ?? 0,
                                                                   "picture" : picture,
            ]]
            self.ref = Database.database().reference().child(self.path)
            self.ref.setValue(dataChanged) {
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                  self.showAlert(title: "Error", message: error.localizedDescription)
                  return
                } else {
                    self.showAlert(title: "Posicion Cambiada", message: "Se modificó con exito")
                }
            }
            
        }
    }
    
    @objc func DismissVW(){
        UserDefaults.standard.removeObject(forKey: "pathModified")
        UserDefaults.standard.removeObject(forKey: "UID1Pass")
        UserDefaults.standard.removeObject(forKey: "UID2Pass")
        UserDefaults.standard.removeObject(forKey: "pathPlayers")
        UserDefaults.standard.removeObject(forKey: "indexZone")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("LoadZonaTour"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }

}
