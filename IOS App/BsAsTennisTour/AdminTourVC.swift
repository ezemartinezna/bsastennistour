//
//  AdminVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 01/08/2021.
//

import UIKit
import FirebaseDatabase

class AdminTourVC: UIViewController,UIScrollViewDelegate, UITextFieldDelegate {

    //HISTORICO
    var myTorneos : [String] = []
    var dayMyTorneos : [String] = []
    var cantPlayers : [String] = []
    
    //PROXIMOS
    var allTorneos : [Tourament] = []
    var ref : DatabaseReference!
    
    var co : Int = 0
    
    let titleTorneo : UILabel = {
        let label = UILabel()
        label.text = "ADMIN TORNEOS"
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Bold", size: 25)!
        label.textColor = .white
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageTrophy : UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "tournament")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let createTourButton : UIButton = {
        let button = UIButton()
        button.setTitle("NUEVO", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(comingAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPop
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let historyButton : UIButton = {
        let button = UIButton()
        button.setTitle("LISTADO DE TORNEOS", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
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
    
    private let uViewScrollView : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let uViewScrollView1 : UIView = {
        let uView = UIView()
        uView.layer.backgroundColor = UIColor.clear.cgColor
        uView.layer.masksToBounds = false
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.isUserInteractionEnabled = true
        return uView
    }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.text = "NUEVO TORNEO"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTitle2: UILabel = {
          let label = UILabel()
            label.text = "LISTADO DE TORNEOS"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let myTorneosTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .mainGray
        table.layer.cornerRadius = 10
        table.separatorColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyTorneosTableCell.self, forCellReuseIdentifier: "cellTable")
        table.rowHeight = 90
        table.allowsSelection = true
       return table
    }()
    
    private let buttonAddTour : UIButton = {
        let button = UIButton()
        button.setTitle("CREAR TORNEO", for: .normal)
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
        button.addTarget(self, action: #selector(AddTour), for: .touchUpInside)
        return button
    }()
    
    private let labelNewTour : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .gray
         label.textAlignment = .left
         label.text = "Nombre del Torneo"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textNewTour : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineNewTour : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarItemLoad()
        setupLayout()
        loadListTours()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadListTours), name: NSNotification.Name(rawValue: "LoadListTour"), object: nil)
    }
    
    func navBarItemLoad(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func setupLayout() {
        
        view.backgroundColor = .mainGray
        view.addSubview(viewContainer)
        
        viewContainer.addSubview(titleTorneo)
        viewContainer.addSubview(imageTrophy)
        viewContainer.addSubview(uViewBackgroundLeft)
        viewContainer.addSubview(uViewBackgroundRight)
        view.addSubview(createTourButton)
        uViewBackgroundLeft.addSubview(lineButton1)
        view.addSubview(historyButton)
        uViewBackgroundRight.addSubview(lineButton2)
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(uViewScrollView)
        view.addSubview(scrollView1)
        scrollView1.delegate = self
        scrollView1.addSubview(uViewScrollView1)
        
        uViewScrollView.addSubview(labelTitle)
        uViewScrollView.addSubview(labelNewTour)
        uViewScrollView.addSubview(textNewTour)
        textNewTour.delegate = self
        uViewScrollView.addSubview(lineNewTour)
        uViewScrollView.addSubview(buttonAddTour)
        
        uViewScrollView1.addSubview(labelTitle2)
        scrollView1.addSubview(myTorneosTable)
        
        myTorneosTable.delegate = self
        myTorneosTable.dataSource = self
        
        NSLayoutConstraint.activate([
            
            viewContainer.heightAnchor.constraint(equalToConstant: 200),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleTorneo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            titleTorneo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            
            imageTrophy.topAnchor.constraint(equalTo: titleTorneo.bottomAnchor, constant: 10),
            imageTrophy.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageTrophy.widthAnchor.constraint(equalToConstant: 60),
            imageTrophy.heightAnchor.constraint(equalToConstant: 60),
            
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
            
            createTourButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor),
            createTourButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            createTourButton.heightAnchor.constraint(equalToConstant: 15),
            createTourButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor),
            
            lineButton2.leadingAnchor.constraint(equalTo: uViewBackgroundRight.leadingAnchor, constant: 20),
            lineButton2.trailingAnchor.constraint(equalTo: uViewBackgroundRight.trailingAnchor, constant: -20),
            lineButton2.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            lineButton2.heightAnchor.constraint(equalToConstant: 3),
            
            historyButton.centerXAnchor.constraint(equalTo: uViewBackgroundRight.centerXAnchor),
            historyButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10),
            historyButton.heightAnchor.constraint(equalToConstant: 15),
            historyButton.widthAnchor.constraint(equalTo: uViewBackgroundRight.widthAnchor),
        
            //INCOMING TOURS
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            uViewScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            uViewScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            uViewScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            uViewScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            uViewScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: uViewScrollView.topAnchor, constant: 20),
            labelTitle.centerXAnchor.constraint(equalTo: uViewScrollView.centerXAnchor),
            
            labelNewTour.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 30),
            labelNewTour.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor,constant: 40),
            labelNewTour.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor,constant: -40),

            textNewTour.topAnchor.constraint(equalTo: labelNewTour.bottomAnchor, constant: 5),
            textNewTour.leadingAnchor.constraint(equalTo: labelNewTour.leadingAnchor),
            textNewTour.trailingAnchor.constraint(equalTo: labelNewTour.trailingAnchor),
            textNewTour.heightAnchor.constraint(equalToConstant: 30),

            lineNewTour.topAnchor.constraint(equalTo: textNewTour.bottomAnchor, constant: 5),
            lineNewTour.leadingAnchor.constraint(equalTo: labelNewTour.leadingAnchor),
            lineNewTour.trailingAnchor.constraint(equalTo: labelNewTour.trailingAnchor),
            lineNewTour.heightAnchor.constraint(equalToConstant: 2),

            buttonAddTour.topAnchor.constraint(equalTo: lineNewTour.bottomAnchor, constant: 20),
            buttonAddTour.centerXAnchor.constraint(equalTo: uViewScrollView.centerXAnchor),
            buttonAddTour.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -20),
            buttonAddTour.heightAnchor.constraint(equalToConstant: 40),
            buttonAddTour.widthAnchor.constraint(equalToConstant: 200),

            //HISTORY TOURS
            scrollView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView1.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView1.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uViewScrollView1.centerXAnchor.constraint(equalTo: scrollView1.centerXAnchor),
            uViewScrollView1.topAnchor.constraint(equalTo: scrollView1.topAnchor),
            uViewScrollView1.leadingAnchor.constraint(equalTo: scrollView1.leadingAnchor),
            uViewScrollView1.trailingAnchor.constraint(equalTo: scrollView1.trailingAnchor),
            uViewScrollView1.bottomAnchor.constraint(equalTo: scrollView1.bottomAnchor),
            
            labelTitle2.topAnchor.constraint(equalTo: uViewScrollView1.topAnchor, constant: 20),
            labelTitle2.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor, constant: 20),
            
            myTorneosTable.topAnchor.constraint(equalTo: labelTitle2.bottomAnchor,constant: 20),
            myTorneosTable.leadingAnchor.constraint(equalTo: uViewScrollView1.leadingAnchor),
            myTorneosTable.trailingAnchor.constraint(equalTo: uViewScrollView1.trailingAnchor),
            myTorneosTable.heightAnchor.constraint(equalToConstant: 450),
        ])
        
        
    }
    
    @objc func loadListTours() {
        
        myTorneos.removeAll()
        dayMyTorneos.removeAll()
        
        ref = Database.database().reference().child("Torneos/")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                if let allDates = snapshot.children.allObjects as? [DataSnapshot] {
                    for date in allDates {
                        if let allTours = date.children.allObjects as? [DataSnapshot] {
                            for tour in allTours {
                                self.myTorneos.append(tour.key)
                                self.dayMyTorneos.append(date.key)
                                var maxPlayers = ""
                                var currentPlayers = ""
                                if let allInfo = tour.children.allObjects as? [DataSnapshot] {
                                    for info in allInfo {
                                        if info.key == "Info" {
                                            if let allData = info.children.allObjects as? [DataSnapshot] {
                                                for data in allData {
                                                    if data.key == "Max" {
                                                        maxPlayers = data.value as? String ?? "-"
                                                        currentPlayers = "0/\(maxPlayers)"
                                                    }
                                                }
                                            }
                                        }
                                        if info.key == "Players" {
                                            if let allPlayers = info.children.allObjects as? [DataSnapshot] {
                                                var i = 0
                                                for _ in allPlayers {
                                                    i+=1
                                                }
                                                currentPlayers = "\(i)/\(maxPlayers)"
                                            }
                                        }
                                    }
                                }
                                self.cantPlayers.append(currentPlayers)
                            }
                        }
                    }
                }
                self.myTorneosTable.reloadData()
            }
            
        })
        
    }
    
  
    
    @objc func AddTour() {
        
        UserDefaults.standard.set(textNewTour.text, forKey: "AdminNewTour")
        UserDefaults.standard.synchronize()
        
        let vc = CreateNewTourVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func comingAction() {
        
        createTourButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        historyButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        scrollView.isHidden = false
        scrollView1.isHidden = true
        
    }
    
    @objc func historyAction() {
        
        createTourButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        historyButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        scrollView1.isHidden = false
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textNewTour {
            labelNewTour.textColor = .colorMint
            lineNewTour.backgroundColor = .colorMint
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textNewTour {
            labelNewTour.textColor = .gray
            lineNewTour.backgroundColor = .colorCoal
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension AdminTourVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0

        if tableView == myTorneosTable {
            countTable = myTorneos.count
        }
        return countTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        
        if tableView == myTorneosTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! MyTorneosTableCell
            myCell.labelName.text = myTorneos[indexPath.row]
            myCell.labelPlayers.text = cantPlayers[indexPath.row]
            returnCell = myCell
        }
        

        return returnCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == myTorneosTable {
            
            UserDefaults.standard.set(dayMyTorneos[indexPath.row], forKey: "dayTour")
            UserDefaults.standard.set(myTorneos[indexPath.row], forKey: "nameTour")
            UserDefaults.standard.synchronize()
            
            let vc = InscriptionsVC()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
