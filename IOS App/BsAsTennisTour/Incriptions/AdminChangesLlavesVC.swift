//
//  AdminChangesLlavesVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 13/08/2021.
//

import UIKit
import FirebaseDatabase
import SwiftyPickerPopover

class AdminChangesLlavesVC: UIViewController, UITextFieldDelegate {
    
    let pathPlayer = UserDefaults.standard.string(forKey: "pathPlayers") ?? "-"
    var uid : String = ""
    var picture : String = ""
    
    let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .colorPaper
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelNamePlayer1 : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Nombre del Jugador"
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
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineNamePlayer1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelNamePlayer2 : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Nombre del Jugador"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textNamePlayer2 : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineNamePlayer2 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
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
    let path = UserDefaults.standard.string(forKey: "pathModified") ?? "-"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loadInfoPlayer()


    }
    
    func setupLayout() {
        
        if let i = path.lastIndex(of: "/") {
            let nextIndex = path.index(i, offsetBy: 1)
            let number = path.suffix(from: nextIndex)
            labelTitle.text = "EDITAR POSICION \(number)"
        }
        
        view.backgroundColor = UIColor.clear
        view.addSubview(blackView)
        blackView.addSubview(dismissLayerBtn)
        
        view.addSubview(containerView)
        
        view.addSubview(labelTitle)
        view.addSubview(labelNamePlayer1)
        view.addSubview(textNamePlayer1)
        view.addSubview(lineNamePlayer1)
        
        view.addSubview(labelNamePlayer2)
        view.addSubview(textNamePlayer2)
        view.addSubview(lineNamePlayer2)

          
        view.addSubview(buttonEdit)
        
        textNamePlayer1.delegate = self
        textNamePlayer2.delegate = self
        
        NSLayoutConstraint.activate([
            
            blackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60),
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
            
            labelNamePlayer1.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 20),
            labelNamePlayer1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            labelNamePlayer1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            
            textNamePlayer1.topAnchor.constraint(equalTo: labelNamePlayer1.bottomAnchor, constant: 5),
            textNamePlayer1.leadingAnchor.constraint(equalTo: labelNamePlayer1.leadingAnchor),
            textNamePlayer1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            textNamePlayer1.heightAnchor.constraint(equalToConstant: 30),

            lineNamePlayer1.topAnchor.constraint(equalTo: textNamePlayer1.bottomAnchor, constant: 5),
            lineNamePlayer1.leadingAnchor.constraint(equalTo: labelNamePlayer1.leadingAnchor),
            lineNamePlayer1.trailingAnchor.constraint(equalTo: labelNamePlayer1.trailingAnchor),
            lineNamePlayer1.heightAnchor.constraint(equalToConstant: 2),
            
            labelNamePlayer2.topAnchor.constraint(equalTo: lineNamePlayer1.bottomAnchor,constant: 20),
            labelNamePlayer2.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            labelNamePlayer2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            
            textNamePlayer2.topAnchor.constraint(equalTo: labelNamePlayer2.bottomAnchor, constant: 5),
            textNamePlayer2.leadingAnchor.constraint(equalTo: labelNamePlayer2.leadingAnchor),
            textNamePlayer2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            textNamePlayer2.heightAnchor.constraint(equalToConstant: 30),

            lineNamePlayer2.topAnchor.constraint(equalTo: textNamePlayer2.bottomAnchor, constant: 5),
            lineNamePlayer2.leadingAnchor.constraint(equalTo: labelNamePlayer2.leadingAnchor),
            lineNamePlayer2.trailingAnchor.constraint(equalTo: labelNamePlayer2.trailingAnchor),
            lineNamePlayer2.heightAnchor.constraint(equalToConstant: 2),
        

            buttonEdit.topAnchor.constraint(equalTo: lineNamePlayer2.bottomAnchor, constant: 60),
            buttonEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonEdit.heightAnchor.constraint(equalToConstant: 40),
            buttonEdit.widthAnchor.constraint(equalToConstant: 200),
            
            
        
        ])
        
    }
    
    func loadInfoPlayer() {
        
        ref = Database.database().reference().child(path)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
               print("BIEN")
            }
        })
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textNamePlayer1 {
            labelNamePlayer1.textColor = .colorMint
            lineNamePlayer1.backgroundColor = .colorMint
            pickPlayer()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
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
                            }
                        }
                    }
                }
                
//                StringPickerPopover(title: "Ingrese el Jugador:", choices: arrayPlayers)
//                        .setSelectedRow(0)
//                    .setValueChange(action: { _, selectedDate,argData  in
//                            print("current date \(selectedDate)")
//                        })
//                        .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in
//
//                            self.textNamePlayer.text = selectedString
//                            self.textNamePlayer.endEditing(true)
//                        })
//                        .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textNamePlayer.endEditing(true)}
//
//                        )
//                        .setSize(height: 150)
//                        .setFontColor(.colorCoal)
//                    .appear(originView: self.textNamePlayer, baseViewController: self)
            }
        })
    }
    
    @objc func editAction() {
        
        
//        let dataChanged : [String : Any] = ["fullName" : textNamePlayer1.text ?? "-",
//                                            "lose" : Int(textLose.text!) ?? 0,
//                                            "win" : Int(textWin.text!) ?? 0,
//                                            "points" : Int(textPoints.text!) ?? 0,
//                                            "uid" : uid,
//                                            "picture" : picture,
//        ]
//        
//        
//        ref = Database.database().reference().child(path)
//        
//        ref.setValue(dataChanged) {
//            (error:Error?, ref:DatabaseReference) in
//            if let error = error {
//              self.showAlert(title: "Error", message: error.localizedDescription)
//              return
//            } else {
//              self.showAlert(title: "Posicion Cambiada", message: "Se modificó con exito")
//            }
//        }
        
    }
    
    @objc func DismissVW(){
//        NotificationCenter.default.post(name: Notification.Name("LoadZonaTour"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }

}
