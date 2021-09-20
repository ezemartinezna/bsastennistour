//
//  UserChangeName.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 06/09/2021.
//

import UIKit
import FirebaseDatabase

class UserChangeName: UIViewController,UITextFieldDelegate {

    let uid = UserDefaults.standard.string(forKey: "uid") ?? "-"
    var ref : DatabaseReference!
    
    let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .colorPaper
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.text = "Cambiar Nombre"
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
         label.text = "Ingrese su nombre"
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
    
    private let labelLastNamePlayer : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Ingrese su apellido"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textLastNamePlayer : UITextField = {
        let text = UITextField()
        text.backgroundColor = .colorPaper
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineLastNamePlayer : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        loadUserData()
    }
    
    func setupLayout() {

        view.backgroundColor = UIColor.clear
        view.addSubview(blackView)
        blackView.addSubview(dismissLayerBtn)
        
        view.addSubview(containerView)
        
        view.addSubview(labelTitle)
        view.addSubview(labelNamePlayer)
        view.addSubview(textNamePlayer)
        textNamePlayer.delegate = self
        view.addSubview(lineNamePlayer)
        view.addSubview(labelLastNamePlayer)
        view.addSubview(textLastNamePlayer)
        textLastNamePlayer.delegate = self
        view.addSubview(lineLastNamePlayer)
        
        NSLayoutConstraint.activate([
            
            blackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.70),
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
            labelNamePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            
            textNamePlayer.topAnchor.constraint(equalTo: labelNamePlayer.bottomAnchor, constant: 5),
            textNamePlayer.leadingAnchor.constraint(equalTo: labelNamePlayer.leadingAnchor),
            textNamePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            textNamePlayer.heightAnchor.constraint(equalToConstant: 30),

            lineNamePlayer.topAnchor.constraint(equalTo: textNamePlayer.bottomAnchor, constant: 5),
            lineNamePlayer.leadingAnchor.constraint(equalTo: labelNamePlayer.leadingAnchor),
            lineNamePlayer.trailingAnchor.constraint(equalTo: labelNamePlayer.trailingAnchor),
            lineNamePlayer.heightAnchor.constraint(equalToConstant: 2),
            
            labelLastNamePlayer.topAnchor.constraint(equalTo: lineNamePlayer.bottomAnchor,constant: 20),
            labelLastNamePlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            labelLastNamePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            
            textLastNamePlayer.topAnchor.constraint(equalTo: labelLastNamePlayer.bottomAnchor, constant: 5),
            textLastNamePlayer.leadingAnchor.constraint(equalTo: labelLastNamePlayer.leadingAnchor),
            textLastNamePlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            textLastNamePlayer.heightAnchor.constraint(equalToConstant: 30),

            lineLastNamePlayer.topAnchor.constraint(equalTo: textLastNamePlayer.bottomAnchor, constant: 5),
            lineLastNamePlayer.leadingAnchor.constraint(equalTo: labelLastNamePlayer.leadingAnchor),
            lineLastNamePlayer.trailingAnchor.constraint(equalTo: labelLastNamePlayer.trailingAnchor),
            lineLastNamePlayer.heightAnchor.constraint(equalToConstant: 2),
                                        
            ])
        
    }
    
    func loadUserData() {
        
        ref = Database.database().reference().child("Users/\(uid)/")
        ref.observeSingleEvent(of: .value, with: { [self] (snapshot) in
            
            if snapshot.exists() {
                
                
                if let allData = snapshot.children.allObjects as? [DataSnapshot] {
                    for data in allData {
                        
                        switch data.key {

                        case "firstName":
                            self.textNamePlayer.text = data.value as? String ?? "-"
                        case "lastName":
                            self.textLastNamePlayer.text = data.value as? String ?? "-"
                            
                        default:
                            print("LoadUser")
                        }
          
                    }
                }
   
           }
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    @objc func DismissVW(){
        
        ref = Database.database().reference().child("Users/\(uid)/firstName")
        ref.setValue(textNamePlayer.text)
        
        ref = Database.database().reference().child("Users/\(uid)/lastName")
        ref.setValue(textLastNamePlayer.text)
        
        NotificationCenter.default.post(name: Notification.Name("LoadUserData"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }

}
