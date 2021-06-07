//
//  UserMainVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit

class UserMainVC: UIViewController,UINavigationControllerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    var profesorsImage = ["profesor1","profesor2"]
    var profesorsTitle = ["Agus","Fran"]
    var allTorneosNames = ["Torneo Apertura","Torneo Relampago II","Torneo Verano"]
    var allTorneosDates = ["02-01-2020","16-01-2020","02-02-2020"]
    var allTorneosPlace = ["Club Mitre","Devoto","Agronomia"]
    var allNews = ["news1","news2","news3"]
    var rankingPoints = ["250","220","170","90","80"]
    var rankingPlayers = ["Roger Federer","Mago Coria","Pete Sampras","Diego Armando","Ezequiel Martinez"]
    var myTorneos = ["Torneo Relampago","Torneo Invierno","Torneo Roger"]
    var gameTimer: Timer?
    var co : Int = 0

    let titleMain : UILabel = {
        let label = UILabel()
        label.text = "BsAs Tennis Academy"
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ballTennis: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "homeIcon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGray
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
          label.text = "Organizadores"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 20)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTitle5: UILabel = {
          let label = UILabel()
          label.text = "Tus Torneos"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 20)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let uView2 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.backgroundColor = .mainGray
        return view
    }()
    
    let uView3 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.borderWidth = 1
        view.backgroundColor = .mainGray
        return view
    }()
    
    lazy var snapCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.layer.cornerRadius = 20
           collectionView.backgroundColor = .mainGray
           collectionView.register(ProfesorCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    lazy var snapCollectionNews: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.layer.cornerRadius = 20
           collectionView.backgroundColor = .mainGray
           collectionView.register(NewsCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    private lazy var pageControl: UIPageControl = {
         let pc = UIPageControl()
         pc.currentPage = 0
         pc.numberOfPages = profesorsImage.count
         pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .white
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()
    
    private lazy var pageControl2: UIPageControl = {
         let pc = UIPageControl()
         pc.currentPage = 0
         pc.numberOfPages = allNews.count
         pc.currentPageIndicatorTintColor = .black
         pc.pageIndicatorTintColor = .white
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()
    
    private let labelTitle2: UILabel = {
          let label = UILabel()
          label.text = "Proximos Torneos"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 20)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let allTorneosTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .mainGray
        table.layer.cornerRadius = 10
        table.separatorColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TorneosTableCell.self, forCellReuseIdentifier: "cellTable")
        table.rowHeight = 90
        table.allowsSelection = true
       return table
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
    
    private let allRankingTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .mainGray
        table.layer.cornerRadius = 10
        table.separatorColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RankingTableCell.self, forCellReuseIdentifier: "cellTable")
        table.rowHeight = 60
        table.allowsSelection = true
       return table
    }()
    
    
    private let labelTitle4: UILabel = {
          let label = UILabel()
          label.text = "Novedades"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 20)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTitle3: UILabel = {
          let label = UILabel()
          label.text = "Ranking ATP"
          label.textColor = .darkGray
          label.font = .boldSystemFont(ofSize: 20)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarItemLoad()
        setupScrollView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
      
        self.tabBarController?.tabBar.items?[0].title = "Main"
        self.tabBarController?.tabBar.items?[0].selectedImage = UIImage(named: "ballTennisResize")?.withRenderingMode(.alwaysOriginal)
      }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameTimer?.invalidate()
    }


    func navBarItemLoad(){
            
        let vw = UIView()
        vw.isUserInteractionEnabled = true
        vw.addSubview(titleMain)
        
        let menuBarItem = UIBarButtonItem(customView: ballTennis)
    
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
       
        vw.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = vw
            
        titleMain.centerXAnchor.constraint(equalTo: vw.centerXAnchor).isActive = true
        titleMain.centerYAnchor.constraint(equalTo: vw.centerYAnchor).isActive = true
    }
    
    
    func setupScrollView(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.delegate = self
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        
        contentView.addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(uView2)
        
        uView2.topAnchor.constraint(equalTo: labelTitle.bottomAnchor,constant: 20).isActive = true
        uView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        uView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        uView2.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        uView2.addSubview(snapCollectionView)
        uView2.addSubview(pageControl)
        snapCollectionView.leadingAnchor.constraint(equalTo: uView2.leadingAnchor).isActive = true
        snapCollectionView.trailingAnchor.constraint(equalTo: uView2.trailingAnchor).isActive = true
        snapCollectionView.topAnchor.constraint(equalTo: uView2.topAnchor).isActive = true
        snapCollectionView.bottomAnchor.constraint(equalTo: uView2.bottomAnchor).isActive = true
        snapCollectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        pageControl.centerXAnchor.constraint(equalTo: uView2.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: uView2.bottomAnchor).isActive = true
        
        contentView.addSubview(labelTitle2)
        labelTitle2.topAnchor.constraint(equalTo: uView2.bottomAnchor,constant: 20).isActive = true
        labelTitle2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        labelTitle2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        allTorneosTable.dataSource = self
        allTorneosTable.delegate = self
        contentView.addSubview(allTorneosTable)
        
        allTorneosTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        allTorneosTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        allTorneosTable.topAnchor.constraint(equalTo: labelTitle2.bottomAnchor,constant: 20).isActive = true
        allTorneosTable.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        contentView.addSubview(labelTitle5)
        labelTitle5.topAnchor.constraint(equalTo: allTorneosTable.bottomAnchor,constant: 20).isActive = true
        labelTitle5.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        labelTitle5.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        myTorneosTable.dataSource = self
        myTorneosTable.delegate = self
        contentView.addSubview(myTorneosTable)
        
        myTorneosTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        myTorneosTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        myTorneosTable.topAnchor.constraint(equalTo: labelTitle5.bottomAnchor,constant: 20).isActive = true
        myTorneosTable.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        contentView.addSubview(labelTitle3)
        labelTitle3.topAnchor.constraint(equalTo: myTorneosTable.bottomAnchor,constant: 20).isActive = true
        labelTitle3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        labelTitle3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        allRankingTable.dataSource = self
        allRankingTable.delegate = self
        
        contentView.addSubview(allRankingTable)
        
        allRankingTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        allRankingTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        allRankingTable.topAnchor.constraint(equalTo: labelTitle3.bottomAnchor,constant: 20).isActive = true
        allRankingTable.heightAnchor.constraint(equalToConstant: 180).isActive = true

        
        contentView.addSubview(labelTitle4)
        labelTitle4.topAnchor.constraint(equalTo: allRankingTable.bottomAnchor,constant: 20).isActive = true
        labelTitle4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        labelTitle4.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(uView3)
        uView3.topAnchor.constraint(equalTo: labelTitle4.bottomAnchor, constant: 20).isActive = true
        uView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        uView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        uView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        uView3.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        uView3.addSubview(snapCollectionNews)
        uView3.addSubview(pageControl2)
        snapCollectionNews.leadingAnchor.constraint(equalTo: uView3.leadingAnchor).isActive = true
        snapCollectionNews.trailingAnchor.constraint(equalTo: uView3.trailingAnchor).isActive = true
        snapCollectionNews.topAnchor.constraint(equalTo: uView3.topAnchor).isActive = true
        snapCollectionNews.bottomAnchor.constraint(equalTo: uView3.bottomAnchor).isActive = true
        snapCollectionNews.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        pageControl2.centerXAnchor.constraint(equalTo: uView3.centerXAnchor).isActive = true
        pageControl2.bottomAnchor.constraint(equalTo: uView3.bottomAnchor).isActive = true
        
    
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0
        if tableView == allTorneosTable {
            countTable = allTorneosNames.count
        }
        if tableView == allRankingTable {
            countTable = rankingPlayers.count
        }
        if tableView == myTorneosTable {
            countTable = myTorneos.count
        }
        return countTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        if tableView == allTorneosTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! TorneosTableCell
            myCell.labelName.text = allTorneosNames[indexPath.row]
            myCell.labelDate.text = allTorneosDates[indexPath.row]
            returnCell = myCell
        }
        
        if tableView == myTorneosTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! MyTorneosTableCell
            myCell.labelName.text = myTorneos[indexPath.row]
            returnCell = myCell
        }
        
        if tableView == allRankingTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! RankingTableCell
            myCell.labelPosition.text = String(indexPath.row + 1)
            myCell.labelName.text = rankingPlayers[indexPath.row]
            myCell.labelRank.text = rankingPoints[indexPath.row]
            
            if indexPath.row == 0 {
                myCell.labelPosition.isHidden = true
                myCell.tourImage.isHidden = false
                myCell.viewContainer.backgroundColor = .mainYellow
            }else {
                myCell.labelPosition.isHidden = false
                myCell.tourImage.isHidden = true
                myCell.viewContainer.backgroundColor = .darkGray
            }
            
            returnCell = myCell
        }
        return returnCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == allTorneosTable {
        gameTimer?.invalidate()
            
            UserDefaults.standard.set(allTorneosDates[indexPath.row], forKey: "dateTour")
            UserDefaults.standard.set(allTorneosNames[indexPath.row], forKey: "nameTour")
            UserDefaults.standard.set(allTorneosPlace[indexPath.row], forKey: "placeTour")
            UserDefaults.standard.synchronize()
            
            eventTorneo(vcOpen: InscriptionsVC(), titleAlert: "Inscribirse")
        }
        
        if tableView == myTorneosTable {
            
            UserDefaults.standard.set(myTorneos[indexPath.row], forKey: "dateTour")
            UserDefaults.standard.set(myTorneos[indexPath.row], forKey: "nameTour")
            UserDefaults.standard.synchronize()
            
            eventTorneo(vcOpen: TouramentVC(), titleAlert: "Ver Torneo")
        }
        
    }
    
    @objc func runTimedCode() {
        
        if allTorneosNames.count > 0 {
        let indexPath = IndexPath(row: co, section: 0)
        allTorneosTable.scrollToRow(at: indexPath, at: .top, animated: true)
        co = co + 1
        if co >= allTorneosNames.count {
            co = 0
        }
        }
    }
    
    func eventTorneo(vcOpen : UIViewController, titleAlert : String) {
               
       
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let subscribe = UIAlertAction(title: titleAlert, style: .default) { (_) in
            
            vcOpen.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vcOpen, animated: true)
//            self.present(vcOpen, animated: true, completion: nil)

        }
      

        let cancel = UIAlertAction(title: "Volver", style: .cancel) { (_) in
            self.gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: true)
        }
        
          alert.addAction(subscribe)
          alert.addAction(cancel)
          present(alert, animated: true)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == snapCollectionView {
   
         let x = targetContentOffset.pointee.x
         pageControl.currentPage = Int(x / uView2.bounds.width)

        }
        
        if scrollView == snapCollectionNews {
   
         let x = targetContentOffset.pointee.x
         pageControl2.currentPage = Int(x / uView3.bounds.width)

        }

    }

    
}

extension UserMainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnInt = 0
        if collectionView == snapCollectionView {
        returnInt = profesorsImage.count
        }
        if collectionView == snapCollectionNews {
        returnInt = allNews.count
        }
        return returnInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        
        if collectionView == snapCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ProfesorCollectionCell
        let data = self.profesorsTitle[indexPath.item]
        cell.lableTitle.text = String(data)
        cell.imageType.image = UIImage(named: profesorsImage[indexPath.row])
        returnCell = cell
        }
        
        if collectionView == snapCollectionNews {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! NewsCollectionCell
            cell.imageType.image = UIImage(named: allNews[indexPath.row])
            returnCell = cell
            
        }
        
        
        return returnCell
    }
    
  
}

extension UserMainVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var sizeCollection = CGSize(width: 10, height: 10)
        if collectionView == snapCollectionView {
            sizeCollection = CGSize(width: uView2.bounds.width, height: uView2.bounds.height)
        }
        if collectionView == snapCollectionNews {
            sizeCollection = CGSize(width: uView3.bounds.width, height: uView3.bounds.height)
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

