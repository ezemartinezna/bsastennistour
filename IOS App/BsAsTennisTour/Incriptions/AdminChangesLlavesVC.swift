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
    
    let pathMatch = UserDefaults.standard.string(forKey: "pathMatch") ?? "-"
    let pathPlayer = UserDefaults.standard.string(forKey: "pathPlayers") ?? "-"
    var uid1 : String = ""
    var uid2 : String = ""
    var picture1 : String = "perfilIcon"
    var picture2 : String = "perfilIcon"
    var position1 : String = ""
    var position2 : String = ""
    var SETsPlayer1 : [String] = []
    var SETsPlayer2 : [String] = []
    var winnerPlayer1 : Bool = false
    var winnerPlayer2 : Bool = false
    
    let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .colorSage
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorPaper
            label.text = "PARTIDO EN \(UserDefaults.standard.string(forKey: "nameLlave") ?? "-")".uppercased()
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelNamePlayer1 : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
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
        text.layer.cornerRadius = 5
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
        text.layer.cornerRadius = 5
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
    
    let imageBallPlayer1: UIButton  = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Pelota Plata Negativo"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(winPlayer1), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let container1CV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()

    lazy var scorePlayer1CV: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .clear
           collectionView.register(MatchesCVCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    let imageBallPlayer2: UIButton  = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Pelota Plata Negativo"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(winPlayer2), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let container2CV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 5
        return view
    }()

    lazy var scorePlayer2CV: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .clear
           collectionView.register(MatchesCVCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    var ref: DatabaseReference!
    var ref1: DatabaseReference!

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
        view.addSubview(labelNamePlayer1)
        view.addSubview(textNamePlayer1)
        view.addSubview(lineNamePlayer1)
        
        view.addSubview(labelNamePlayer2)
        view.addSubview(textNamePlayer2)
        view.addSubview(lineNamePlayer2)
        
        view.addSubview(container1CV)
        view.addSubview(container2CV)
        container1CV.addSubview(scorePlayer1CV)
        container2CV.addSubview(scorePlayer2CV)
        view.addSubview(imageBallPlayer1)
        view.addSubview(imageBallPlayer2)

          
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
            labelNamePlayer1.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            textNamePlayer1.topAnchor.constraint(equalTo: labelNamePlayer1.bottomAnchor, constant: 5),
            textNamePlayer1.leadingAnchor.constraint(equalTo: labelNamePlayer1.leadingAnchor),
            textNamePlayer1.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            textNamePlayer1.heightAnchor.constraint(equalToConstant: 30),

            lineNamePlayer1.topAnchor.constraint(equalTo: textNamePlayer1.bottomAnchor, constant: 5),
            lineNamePlayer1.leadingAnchor.constraint(equalTo: labelNamePlayer1.leadingAnchor),
            lineNamePlayer1.trailingAnchor.constraint(equalTo: labelNamePlayer1.trailingAnchor),
            lineNamePlayer1.heightAnchor.constraint(equalToConstant: 2),
            
            imageBallPlayer1.centerYAnchor.constraint(equalTo: textNamePlayer1.centerYAnchor),
            imageBallPlayer1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imageBallPlayer1.widthAnchor.constraint(equalToConstant: 30),
            imageBallPlayer1.heightAnchor.constraint(equalToConstant: 30),
            
            container1CV.leadingAnchor.constraint(equalTo: textNamePlayer1.trailingAnchor,constant: 5),
            container1CV.centerYAnchor.constraint(equalTo: textNamePlayer1.centerYAnchor),
            container1CV.trailingAnchor.constraint(equalTo: imageBallPlayer1.leadingAnchor,constant: -5),
            container1CV.heightAnchor.constraint(equalToConstant: 30),
            
            scorePlayer1CV.topAnchor.constraint(equalTo: container1CV.topAnchor),
            scorePlayer1CV.leadingAnchor.constraint(equalTo: container1CV.leadingAnchor),
            scorePlayer1CV.trailingAnchor.constraint(equalTo: container1CV.trailingAnchor),
            scorePlayer1CV.bottomAnchor.constraint(equalTo: container1CV.bottomAnchor),
            
            labelNamePlayer2.topAnchor.constraint(equalTo: lineNamePlayer1.bottomAnchor,constant: 20),
            labelNamePlayer2.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            labelNamePlayer2.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            textNamePlayer2.topAnchor.constraint(equalTo: labelNamePlayer2.bottomAnchor, constant: 5),
            textNamePlayer2.leadingAnchor.constraint(equalTo: labelNamePlayer2.leadingAnchor),
            textNamePlayer2.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            textNamePlayer2.heightAnchor.constraint(equalToConstant: 30),

            lineNamePlayer2.topAnchor.constraint(equalTo: textNamePlayer2.bottomAnchor, constant: 5),
            lineNamePlayer2.leadingAnchor.constraint(equalTo: labelNamePlayer2.leadingAnchor),
            lineNamePlayer2.trailingAnchor.constraint(equalTo: labelNamePlayer2.trailingAnchor),
            lineNamePlayer2.heightAnchor.constraint(equalToConstant: 2),
            
            imageBallPlayer2.centerYAnchor.constraint(equalTo: textNamePlayer2.centerYAnchor),
            imageBallPlayer2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imageBallPlayer2.widthAnchor.constraint(equalToConstant: 30),
            imageBallPlayer2.heightAnchor.constraint(equalToConstant: 30),
            
            container2CV.leadingAnchor.constraint(equalTo: textNamePlayer2.trailingAnchor,constant: 5),
            container2CV.centerYAnchor.constraint(equalTo: textNamePlayer2.centerYAnchor),
            container2CV.trailingAnchor.constraint(equalTo: imageBallPlayer2.leadingAnchor,constant: -5),
            container2CV.heightAnchor.constraint(equalToConstant: 30),
            
            scorePlayer2CV.topAnchor.constraint(equalTo: container2CV.topAnchor),
            scorePlayer2CV.leadingAnchor.constraint(equalTo: container2CV.leadingAnchor),
            scorePlayer2CV.trailingAnchor.constraint(equalTo: container2CV.trailingAnchor),
            scorePlayer2CV.bottomAnchor.constraint(equalTo: container2CV.bottomAnchor),

            buttonEdit.topAnchor.constraint(equalTo: lineNamePlayer2.bottomAnchor, constant: 60),
            buttonEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonEdit.heightAnchor.constraint(equalToConstant: 40),
            buttonEdit.widthAnchor.constraint(equalToConstant: 200),
            
            
        
        ])
        
    }
    
    func loadInfoPlayer() {
        
        ref = Database.database().reference().child(pathMatch)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                if let allPosition = snapshot.children.allObjects as? [DataSnapshot] {
                    var i = 0
                    for position in allPosition {
                        if i == 0 {
                            self.position1 = position.key
                            self.labelNamePlayer1.text = "Jugador - \(self.position1)"
                        }else{
                            self.position2 = position.key
                            self.labelNamePlayer2.text = "Jugador - \(self.position2)"
                        }
                        if let allPlayers = position.children.allObjects as? [DataSnapshot] {
                            for player in allPlayers {
                                if i == 0 {
                                    self.uid1 = player.key
                                }else{
                                    self.uid2 = player.key
                                }
                                if let allInfo = player.children.allObjects as? [DataSnapshot] {
                                    for info in allInfo {
                                        if info.key == "fullName" {
                                            if i == 0 {
                                                self.textNamePlayer1.text = info.value as? String ?? "-"
                                            }else{
                                                self.textNamePlayer2.text = info.value as? String ?? "-"
                                            }
                                        }
                                        if info.key == "picture" {
                                            if i == 0 {
                                                self.picture1 = info.value as? String ?? "-"
                                            }else{
                                                self.picture2 = info.value as? String ?? "-"
                                            }
                                        }
                                        
                                        if info.key == "win" {
                                            if info.value as? Bool ?? false {
                                                if i == 0 {
                                                    self.imageBallPlayer1.setImage(#imageLiteral(resourceName: "Pelota Top Ten"), for: .normal)
                                                    self.winnerPlayer1 = true
                                                }else{
                                                    self.imageBallPlayer2.setImage(#imageLiteral(resourceName: "Pelota Top Ten"), for: .normal)
                                                    self.winnerPlayer2 = true
                                                }
                                            }
                                           
                                        }
                                        
                                        if info.key == "SET" {
                                            if let allSETS = info.children.allObjects as? [DataSnapshot] {
                                                for set in allSETS {
                                                    if i == 0 {
                                                    self.SETsPlayer1.append(set.value as? String ?? "0")
                                                    }else{
                                                    self.SETsPlayer2.append(set.value as? String ?? "0")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        i+=1
                    }
                    self.scorePlayer1CV.reloadData()
                    self.scorePlayer2CV.reloadData()
                }
            }
        })
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textNamePlayer1 {
            labelNamePlayer1.textColor = .colorMint
            lineNamePlayer1.backgroundColor = .colorMint
            pickPlayer1()
        }
        if textField == textNamePlayer2 {
            labelNamePlayer2.textColor = .colorMint
            lineNamePlayer2.backgroundColor = .colorMint
            pickPlayer2()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textNamePlayer1 {
            labelNamePlayer1.textColor = .gray
            lineNamePlayer1.backgroundColor = .colorCoal
        }
        if textField == textNamePlayer2 {
            labelNamePlayer2.textColor = .gray
            lineNamePlayer2.backgroundColor = .colorCoal
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
                            }
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
    func pickPlayer2() {
        
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
                
                StringPickerPopover(title: "Ingrese el Jugador:", choices: arrayPlayers)
                        .setSelectedRow(0)
                    .setValueChange(action: { _, selectedDate,argData  in
                            print("current date \(selectedDate)")
                        })
                        .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in

                            self.textNamePlayer2.text = selectedString
                            self.textNamePlayer2.endEditing(true)
                        })
                        .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in self.textNamePlayer2.endEditing(true)}

                        )
                        .setSize(height: 150)
                        .setFontColor(.colorCoal)
                    .appear(originView: self.textNamePlayer2, baseViewController: self)
            }
        })
    }
    
    @objc func winPlayer1() {
        
        if winnerPlayer1 {
            imageBallPlayer1.setImage(#imageLiteral(resourceName: "Pelota Plata Negativo"), for: .normal)
        }else{
            imageBallPlayer1.setImage(#imageLiteral(resourceName: "Pelota Top Ten"), for: .normal)
        }
        
        winnerPlayer1 = !winnerPlayer1
        
    }
    
    @objc func winPlayer2() {
        
        if winnerPlayer2 {
            imageBallPlayer2.setImage(#imageLiteral(resourceName: "Pelota Plata Negativo"), for: .normal)
        }else{
            imageBallPlayer2.setImage(#imageLiteral(resourceName: "Pelota Top Ten"), for: .normal)
        }
        
        winnerPlayer2 = !winnerPlayer2
        
    }
    
    @objc func editAction() {
        
        
        let player1 : [String : Any] = ["fullName" : textNamePlayer1.text ?? "-","win" : self.winnerPlayer1,"picture" : self.picture1,"SET" : SETsPlayer1]
        let player2 : [String : Any] = ["fullName" : textNamePlayer2.text ?? "-","win" : self.winnerPlayer2,"picture" : self.picture2,"SET" : SETsPlayer2]
        
        ref = Database.database().reference().child("\(pathMatch)/\(position1)/\(self.uid1)")
        ref1 = Database.database().reference().child("\(pathMatch)/\(position2)/\(self.uid2)")
        
        ref.removeValue() {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              self.showAlert(title: "Error", message: error.localizedDescription)
              return
            } else {
              ref.setValue(player1)
                self.ref1.removeValue() {
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                      self.showAlert(title: "Error", message: error.localizedDescription)
                      return
                    } else {
                      ref.setValue(player2)
                        self.showAlert(title: "Llave modificada", message: "Se modificó con éxito")
                    }
                }
            }
            
        }
        
    
        
    }
    
    @objc func DismissVW(){
        NotificationCenter.default.post(name: Notification.Name("LoadLlaveTour"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }

}

extension AdminChangesLlavesVC : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var sizeCollection = CGSize(width: 10, height: 10)
        if collectionView == scorePlayer1CV || collectionView == scorePlayer2CV {
            sizeCollection = CGSize(width: container1CV.bounds.width / 3, height: container1CV.bounds.height)
        }
        return sizeCollection
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SETsPlayer1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MatchesCVCell
        
        if collectionView == scorePlayer1CV {
       
        let number = self.SETsPlayer1[indexPath.item]
        cell.labelTitle.text = String(number)
        returnCell = cell
        }
        
        if collectionView == scorePlayer2CV {

        let number = self.SETsPlayer2[indexPath.item]
        cell.labelTitle.text = String(number)
        returnCell = cell
        }
        return returnCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == scorePlayer1CV {
            StringPickerPopover(title: "Ingrese el Resultado:", choices: ["0","1","2","3","4","5","6","7"])
                        .setSelectedRow(0)
                    .setValueChange(action: { _, selectedDate,argData  in
                            print("current date \(selectedDate)")
                        })
                        .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in

                            self.SETsPlayer1[indexPath.row] = selectedString
                            self.scorePlayer1CV.reloadData()
                        })
                        .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in print("Cancel")}

                        )
                        .setSize(height: 150)
                        .setFontColor(.colorCoal)
                    .appear(originView: self.scorePlayer1CV, baseViewController: self)
        }
        if collectionView == scorePlayer2CV {
            StringPickerPopover(title: "Ingrese el Resultado:", choices: ["0","1","2","3","4","5","6","7"])
                        .setSelectedRow(0)
                    .setValueChange(action: { _, selectedDate,argData  in
                            print("current date \(selectedDate)")
                        })
                        .setDoneButton(title: "OK", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (popover, selectedRow, selectedString) in

                            self.SETsPlayer2[indexPath.row] = selectedString
                            self.scorePlayer2CV.reloadData()
                        })
                        .setCancelButton(title: "Cancel", font: UIFont(name: "Helvetica Bold", size: 15), color: .white,action: { (_, _, _) in print("Cancel")}

                        )
                        .setSize(height: 150)
                        .setFontColor(.colorCoal)
                    .appear(originView: self.scorePlayer2CV, baseViewController: self)
        }
    }
    
    
}
