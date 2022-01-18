//
//  ConfigVC.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 15/05/2021.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ConfigVC: UIViewController {
    
    var titles : [String] = ["Notificaciones","Promociones","Cerrar Sesión"]
    
    private let configTableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .lightGray
        table.separatorColor = .darkGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ConfigCell.self, forCellReuseIdentifier: "ConfigCell")
        table.rowHeight = 50
        table.allowsSelection = true
       return table
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(configTableView)
        configTableView.delegate = self
        configTableView.dataSource = self
        
        NSLayoutConstraint.activate([
        
            configTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            configTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            configTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            configTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
  
    }
    
    func firebaseLogOut() {
        
        do {
            try Auth.auth().signOut()
        }catch {
            self.showAlert(title: "Error", message: "LogOut Error")
        }
        
    }
    
    func googleSingOut() {
        
        GIDSignIn.sharedInstance.signOut()
        
    }

    


}

extension ConfigVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "ConfigCell", for: indexPath) as! ConfigCell
        myCell.titleName.text = titles[indexPath.row]
        return myCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("ShowNotififaciones")
        case 1:
            print("ShowPromos")
        case 2:
            firebaseLogOut()
            
            UserDefaults.standard.removeObject(forKey: "uid")
            UserDefaults.standard.removeObject(forKey: "Provider")
            UserDefaults.standard.removeObject(forKey: "ADMIN")
            UserDefaults.standard.synchronize()
            
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = vc
            self.present(vc, animated: true, completion: nil)
        default:
            print("NotMark")
        }
    }
    
}


class ConfigCell: UITableViewCell {

    let titleName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(titleName)
        
        NSLayoutConstraint.activate([
            titleName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            titleName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
