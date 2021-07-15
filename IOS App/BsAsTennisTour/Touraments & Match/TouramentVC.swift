//
//  TouramentVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 26/03/2021.
//

import UIKit

class TouramentVC: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    var allTorneosNames = ["Torneo Apertura","Torneo Relampago II","Torneo Verano"]
    var allTorneosDates = ["21-09-2021","25-09-2021","02-10-2021"]
    var allTorneosTypes = ["Single","Single","Doubles"]
    var allTorneosPlaces = ["Club Mitre","Club Mitre","Club Devoto"]
    var allTorneosMaxPlayers = ["16","8","24"]
    var myTorneos = ["Torneo Relampago","Torneo Invierno","Torneo Roger","Torneo Fin de Año"]
    var co : Int = 0
    
    
    let titleTorneo : UILabel = {
        let label = UILabel()
        label.text = "TORNEOS"
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
    
    private let comingButton : UIButton = {
        let button = UIButton()
        button.setTitle("PROXIMOS", for: .normal)
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
        button.setTitle("HISTORICOS", for: .normal)
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
            label.text = "PROXIMOS TORNEOS"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTitle2: UILabel = {
          let label = UILabel()
            label.text = "HISTORICOS TORNEOS"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    
//    private let allTorneosTable: UITableView = {
//       let table = UITableView()
//        table.backgroundColor = .mainGray
//        table.layer.cornerRadius = 10
//        table.separatorColor = .clear
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.register(TorneosTableCell.self, forCellReuseIdentifier: "cellTable")
//        table.rowHeight = 90
//        table.allowsSelection = true
//       return table
//    }()
    
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
    
    let containerToursCV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var toursCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .white
           collectionView.register(ToursCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    private lazy var pageControl: UIPageControl = {
         let pc = UIPageControl()
         pc.currentPage = 0
         pc.numberOfPages = allTorneosNames.count
         pc.currentPageIndicatorTintColor = .black
         pc.pageIndicatorTintColor = .white
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()
    
    private let buttonShowMore : UIButton = {
        let button = UIButton()
        button.setTitle("VER MÁS", for: .normal)
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
        button.addTarget(self, action: #selector(showMore), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarItemLoad()
        setupLayout()
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
        view.addSubview(comingButton)
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
        uViewScrollView.addSubview(containerToursCV)
        containerToursCV.addSubview(toursCollectionView)
        containerToursCV.addSubview(pageControl)
        
        uViewScrollView.addSubview(buttonShowMore)
        
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
            
            comingButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor),
            comingButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            comingButton.heightAnchor.constraint(equalToConstant: 15),
            comingButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor),
            
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
            labelTitle.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor, constant: 20),
            
            containerToursCV.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
            containerToursCV.leadingAnchor.constraint(equalTo: uViewScrollView.leadingAnchor),
            containerToursCV.trailingAnchor.constraint(equalTo: uViewScrollView.trailingAnchor),
            containerToursCV.heightAnchor.constraint(equalToConstant: 300),
            
            toursCollectionView.topAnchor.constraint(equalTo: containerToursCV.topAnchor),
            toursCollectionView.leadingAnchor.constraint(equalTo: containerToursCV.leadingAnchor),
            toursCollectionView.trailingAnchor.constraint(equalTo: containerToursCV.trailingAnchor),
            toursCollectionView.bottomAnchor.constraint(equalTo: containerToursCV.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: containerToursCV.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: containerToursCV.bottomAnchor, constant: -5),
            
            buttonShowMore.topAnchor.constraint(equalTo: containerToursCV.bottomAnchor, constant: 20),
            buttonShowMore.centerXAnchor.constraint(equalTo: uViewScrollView.centerXAnchor),
            buttonShowMore.bottomAnchor.constraint(equalTo: uViewScrollView.bottomAnchor,constant: -20),
            buttonShowMore.heightAnchor.constraint(equalToConstant: 40),
            buttonShowMore.widthAnchor.constraint(equalToConstant: 200),

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
            returnCell = myCell
        }
        

        return returnCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if tableView == allTorneosTable {
//        gameTimer?.invalidate()
//
//            UserDefaults.standard.set(allTorneosDates[indexPath.row], forKey: "dateTour")
//            UserDefaults.standard.set(allTorneosNames[indexPath.row], forKey: "nameTour")
//            UserDefaults.standard.set(allTorneosPlace[indexPath.row], forKey: "placeTour")
//            UserDefaults.standard.synchronize()
//
//            eventTorneo(vcOpen: InscriptionsVC(), titleAlert: "Inscribirse")
//        }
        
        if tableView == myTorneosTable {
            
            UserDefaults.standard.set(myTorneos[indexPath.row], forKey: "dateTour")
            UserDefaults.standard.set(myTorneos[indexPath.row], forKey: "nameTour")
            UserDefaults.standard.synchronize()
            
//            eventTorneo(vcOpen: TouramentVC(), titleAlert: "Ver Torneo")
        }
        
    }
    
    @objc func showMore() {
        
        let index = pageControl.currentPage
        
        UserDefaults.standard.set(allTorneosDates[index], forKey: "dateTour")
        UserDefaults.standard.set(allTorneosNames[index], forKey: "nameTour")
        UserDefaults.standard.set(allTorneosPlaces[index], forKey: "placeTour")
        UserDefaults.standard.synchronize()
        
        let vc = InscriptionsVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func eventTorneo(vcOpen : UIViewController, titleAlert : String) {
//
//
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let subscribe = UIAlertAction(title: titleAlert, style: .default) { (_) in
//
//            vcOpen.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(vcOpen, animated: true)
////            self.present(vcOpen, animated: true, completion: nil)
//
//        }
//
//
//        let cancel = UIAlertAction(title: "Volver", style: .cancel) { (_) in
//
//        }
//
//          alert.addAction(subscribe)
//          alert.addAction(cancel)
//          present(alert, animated: true)
//    }
    
    @objc func comingAction() {
        
        comingButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        historyButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        scrollView.isHidden = false
        scrollView1.isHidden = true
        
    }
    
    @objc func historyAction() {
        
        comingButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        historyButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        scrollView1.isHidden = false
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == toursCollectionView {
   
         let x = targetContentOffset.pointee.x
         pageControl.currentPage = Int(x / containerToursCV.bounds.width)

        }

    }
    
}

extension TouramentVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnInt = 0
        if collectionView == toursCollectionView {
            returnInt = allTorneosNames.count
        }
        return returnInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        
        if collectionView == toursCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ToursCollectionViewCell
          
            cell.labelDate.text = allTorneosDates[indexPath.row]
            cell.labelNameTour.text = allTorneosNames[indexPath.row].uppercased()
            cell.labelType.text = allTorneosTypes[indexPath.row].uppercased()
            cell.labelMaxPlayers.text = "\(allTorneosMaxPlayers[indexPath.row]) JUGADORES"

        returnCell = cell
        }
        
        return returnCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == toursCollectionView {

                UserDefaults.standard.set(allTorneosDates[indexPath.row], forKey: "dateTour")
                UserDefaults.standard.set(allTorneosNames[indexPath.row], forKey: "nameTour")
                UserDefaults.standard.set(allTorneosPlaces[indexPath.row], forKey: "placeTour")
                UserDefaults.standard.synchronize()

                let vc = InscriptionsVC()
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    
}
extension TouramentVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var sizeCollection = CGSize(width: 10, height: 10)
        if collectionView == toursCollectionView {
            sizeCollection = CGSize(width: containerToursCV.bounds.width, height: containerToursCV.bounds.height)
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
    
}


