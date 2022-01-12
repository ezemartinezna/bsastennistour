//
//  UserMainVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 25/11/2020.
//

import UIKit

class UserMainVC: UIViewController,UINavigationControllerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    var profesorsImage = ["professor-tennis-1","professor-tennis-2"]
    var profesorsTitle = ["Agustin Louys","Francisco Louys"]

    var allNews = ["news1","news2","news3"]
    var rankingPoints = ["2081","1834","1779","1693","700"]
    var rankPlayersName = ["Mariano","Martin","Javier","Ezequiel","Jonathan"]
    var rankPlayersLastName = ["Balarino","Rioseco","Belvedere","Martinez","Dalinger"]
    var rankPlays = ["75","75","75","70","67"]
    var rankWins = ["86","76","70","65","55"]
    var rankTours = ["5","4","4","4","3"]
    var rankImages = ["person1","person2","person3","person4","person1"]
    var isLive : Bool = true
    var matchesLive : [AllMatches] = []
  
   
    var co : Int = 0
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorCoal
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageLogo : UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo-app")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let infoButton : UIButton = {
        let button = UIButton()
        button.setTitle("NOVEDADES", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPop
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let rankingButton : UIButton = {
        let button = UIButton()
        button.setTitle("RANKING", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(rankingAction), for: .touchUpInside)
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
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let contentView1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelTitle: UILabel = {
          let label = UILabel()
            label.text = "ORGANIZADORES"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    
    let uView2 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let uView3 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let uViewCVRank : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let labelLive: UILabel = {
          let label = UILabel()
            label.text = "PARTIDOS EN VIVO"
            label.font = UIFont(name: "Helvetica Bold", size: 15)!
            label.textColor = .colorCoal
            label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let uViewLive : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorSage
        return view
    }()
    
    private let liveTableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = .colorSage
        table.separatorColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(LiveTableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.rowHeight = 200
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.allowsSelection = true
       return table
    }()
    
    let imageNet : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "red-tennis")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
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
    //    button.addTarget(self, action: #selector(showMore), for: .touchUpInside)
        return button
    }()
    
    lazy var snapCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .white
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
           collectionView.backgroundColor = .white
           collectionView.register(NewsCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    lazy var snapCollectionRank: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = .white
           collectionView.register(RankCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
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
    
    
    private let allRankingTable: UITableView = {
       let table = UITableView()
        table.backgroundColor = .mainGray
        table.layer.cornerRadius = 10
        table.separatorColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RankingTableCell.self, forCellReuseIdentifier: "cellTable")
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 70
        table.isHidden = true
        table.allowsSelection = true
       return table
    }()
    
    
    private let labelTitle4: UILabel = {
          let label = UILabel()
          label.text = "NOVEDADES"
          label.font = UIFont(name: "Helvetica Bold", size: 15)!
          label.textColor = .colorCoal
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    private let labelTitle3: UIButton = {
          let button = UIButton()
            button.setTitle("RANKING - LISTADO DE POSICIONES", for: .normal)
            button.setTitleColor(.colorGray, for: .selected)
            button.setTitleColor(.colorCoal, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
            button.layer.backgroundColor = UIColor.clear.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isUserInteractionEnabled = true
            button.addTarget(self, action: #selector(openRankingList), for: .touchUpInside)
          return button
      }()
    
    private let labelTitleRank: UIButton = {
        let button = UIButton()
          button.setTitle("RANKING - TOP TEN", for: .normal)
          button.setTitleColor(.colorGray, for: .selected)
          button.setTitleColor(.colorCoal, for: .normal)
          button.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
          button.layer.backgroundColor = UIColor.clear.cgColor
          button.translatesAutoresizingMaskIntoConstraints = false
          button.isUserInteractionEnabled = true
          button.addTarget(self, action: #selector(openTopTen), for: .touchUpInside)
        return button
      }()
    
    var topAnchorView : NSLayoutConstraint?
    var topAnchorNOCVRank : NSLayoutConstraint?
    var bottomTitleList : NSLayoutConstraint?
    var bottomTableViewList : NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarItemLoad()
        setupScrollView()
        loadMatchLive()
        
        
    }


    func navBarItemLoad(){
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .colorCoal
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
    }
    
    
    func setupScrollView(){
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(scrollView1)
        view.addSubview(viewContainer)
        
        viewContainer.addSubview(imageLogo)
        viewContainer.addSubview(uViewBackgroundLeft)
        viewContainer.addSubview(uViewBackgroundRight)
        view.addSubview(infoButton)
        uViewBackgroundLeft.addSubview(lineButton1)
        view.addSubview(rankingButton)
        uViewBackgroundRight.addSubview(lineButton2)
        
        scrollView.addSubview(contentView)
        scrollView1.addSubview(contentView1)
        
        //SCROLLVIEW NOVEDADES
        
        contentView.addSubview(labelLive)
        contentView.addSubview(uViewLive)
        uViewLive.addSubview(liveTableView)
        uViewLive.addSubview(imageNet)
        uViewLive.addSubview(buttonShowMore)
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(uView2)

        contentView.addSubview(labelTitle4)
        contentView.addSubview(uView3)
        
        uView2.addSubview(snapCollectionView)
        uView2.addSubview(pageControl)
        
        uView3.addSubview(snapCollectionNews)
        uView3.addSubview(pageControl2)
        
        //SCROLLVIEW1 RANKING
        
        contentView1.addSubview(labelTitleRank)
        contentView1.addSubview(uViewCVRank)
        uViewCVRank.addSubview(snapCollectionRank)
        contentView1.addSubview(labelTitle3)
        contentView1.addSubview(allRankingTable)
        
        
        NSLayoutConstraint.activate([
            
            viewContainer.heightAnchor.constraint(equalToConstant: 200),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            imageLogo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageLogo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: -20),
            imageLogo.widthAnchor.constraint(equalToConstant: 160),
            imageLogo.heightAnchor.constraint(equalToConstant: 160),
            
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
            
            infoButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor),
            infoButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10),
            infoButton.heightAnchor.constraint(equalToConstant: 15),
            infoButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor),
            
            lineButton2.leadingAnchor.constraint(equalTo: uViewBackgroundRight.leadingAnchor, constant: 20),
            lineButton2.trailingAnchor.constraint(equalTo: uViewBackgroundRight.trailingAnchor, constant: -20),
            lineButton2.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            lineButton2.heightAnchor.constraint(equalToConstant: 3),
            
            rankingButton.centerXAnchor.constraint(equalTo: uViewBackgroundRight.centerXAnchor),
            rankingButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10),
            rankingButton.heightAnchor.constraint(equalToConstant: 15),
            rankingButton.widthAnchor.constraint(equalTo: uViewBackgroundRight.widthAnchor),
            
            //SCROLLVIEW NOVEDADES
        
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelLive.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            labelLive.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            uViewLive.topAnchor.constraint(equalTo: labelLive.bottomAnchor, constant: 20),
            uViewLive.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 25),
            uViewLive.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -25),
            uViewLive.heightAnchor.constraint(equalToConstant: 300),
            
            imageNet.leadingAnchor.constraint(equalTo: uViewLive.leadingAnchor),
            imageNet.trailingAnchor.constraint(equalTo: uViewLive.trailingAnchor),
            imageNet.topAnchor.constraint(equalTo: liveTableView.bottomAnchor,constant: 5),
            imageNet.bottomAnchor.constraint(equalTo: uViewLive.bottomAnchor),
            imageNet.heightAnchor.constraint(equalToConstant: 140),
            
            liveTableView.topAnchor.constraint(equalTo: uViewLive.topAnchor),
            liveTableView.leadingAnchor.constraint(equalTo: uViewLive.leadingAnchor),
            liveTableView.trailingAnchor.constraint(equalTo: uViewLive.trailingAnchor),
            liveTableView.bottomAnchor.constraint(equalTo: imageNet.topAnchor),

            buttonShowMore.centerYAnchor.constraint(equalTo: imageNet.centerYAnchor),
            buttonShowMore.centerXAnchor.constraint(equalTo: imageNet.centerXAnchor),
            buttonShowMore.heightAnchor.constraint(equalToConstant: 40),
            buttonShowMore.widthAnchor.constraint(equalToConstant: 200),
            
            labelTitle.topAnchor.constraint(equalTo: uViewLive.bottomAnchor,constant: 20),
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            uView2.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
            uView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            uView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            uView2.heightAnchor.constraint(equalToConstant: 250),
            
            snapCollectionView.leadingAnchor.constraint(equalTo: uView2.leadingAnchor),
            snapCollectionView.trailingAnchor.constraint(equalTo: uView2.trailingAnchor),
            snapCollectionView.topAnchor.constraint(equalTo: uView2.topAnchor),
            snapCollectionView.bottomAnchor.constraint(equalTo: uView2.bottomAnchor),
//            snapCollectionView.heightAnchor.constraint(equalToConstant: 130),
            
            pageControl.centerXAnchor.constraint(equalTo: uView2.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: uView2.bottomAnchor),
            
            labelTitle4.topAnchor.constraint(equalTo: snapCollectionView.bottomAnchor,constant: 20),
            labelTitle4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            labelTitle4.heightAnchor.constraint(equalToConstant: 30),
            
            uView3.topAnchor.constraint(equalTo: labelTitle4.bottomAnchor),
            uView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            uView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            uView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            uView3.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            snapCollectionNews.leadingAnchor.constraint(equalTo: uView3.leadingAnchor),
            snapCollectionNews.trailingAnchor.constraint(equalTo: uView3.trailingAnchor),
            snapCollectionNews.topAnchor.constraint(equalTo: uView3.topAnchor),
            snapCollectionNews.bottomAnchor.constraint(equalTo: uView3.bottomAnchor),
            snapCollectionNews.heightAnchor.constraint(equalToConstant: 400),
            
            pageControl2.centerXAnchor.constraint(equalTo: uView3.centerXAnchor),
            pageControl2.bottomAnchor.constraint(equalTo: uView3.bottomAnchor),
            
            //SCROLLVIEW1 RANKING
            
            scrollView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView1.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView1.topAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            scrollView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView1.centerXAnchor.constraint(equalTo: scrollView1.centerXAnchor),
            contentView1.topAnchor.constraint(equalTo: scrollView1.topAnchor),
            contentView1.leadingAnchor.constraint(equalTo: scrollView1.leadingAnchor),
            contentView1.trailingAnchor.constraint(equalTo: scrollView1.trailingAnchor),
            contentView1.bottomAnchor.constraint(equalTo: scrollView1.bottomAnchor),
            
            labelTitleRank.topAnchor.constraint(equalTo: contentView1.topAnchor,constant: 20),
            labelTitleRank.leadingAnchor.constraint(equalTo: contentView1.leadingAnchor,constant: 20),
            labelTitleRank.heightAnchor.constraint(equalToConstant: 30),
            
            uViewCVRank.topAnchor.constraint(equalTo: labelTitleRank.bottomAnchor),
            uViewCVRank.leadingAnchor.constraint(equalTo: contentView1.leadingAnchor),
            uViewCVRank.trailingAnchor.constraint(equalTo: contentView1.trailingAnchor),
            uViewCVRank.heightAnchor.constraint(equalToConstant: 400),
            
            snapCollectionRank.topAnchor.constraint(equalTo: uViewCVRank.topAnchor),
            snapCollectionRank.leadingAnchor.constraint(equalTo: uViewCVRank.leadingAnchor),
            snapCollectionRank.trailingAnchor.constraint(equalTo: uViewCVRank.trailingAnchor),
            snapCollectionRank.bottomAnchor.constraint(equalTo: uViewCVRank.bottomAnchor),
            
//            labelTitle3.topAnchor.constraint(equalTo: uViewCVRank.bottomAnchor, constant: 20),
            labelTitle3.leadingAnchor.constraint(equalTo: contentView1.leadingAnchor,constant: 20),
            labelTitle3.heightAnchor.constraint(equalToConstant: 30),
            
            allRankingTable.leadingAnchor.constraint(equalTo: contentView1.leadingAnchor),
            allRankingTable.trailingAnchor.constraint(equalTo: contentView1.trailingAnchor),
            allRankingTable.topAnchor.constraint(equalTo: labelTitle3.bottomAnchor,constant: 20),
            allRankingTable.heightAnchor.constraint(equalToConstant: 400),
//            allRankingTable.bottomAnchor.constraint(equalTo: contentView1.bottomAnchor, constant: -20),
        
        ])
        
        topAnchorView = labelTitle3.topAnchor.constraint(equalTo: uViewCVRank.bottomAnchor, constant: 20)
        topAnchorView?.isActive = true
        
        topAnchorNOCVRank = labelTitle3.topAnchor.constraint(equalTo: labelTitleRank.bottomAnchor, constant: 20)
        topAnchorNOCVRank?.isActive = false
        
        bottomTitleList = labelTitle3.bottomAnchor.constraint(equalTo: contentView1.bottomAnchor, constant: -20)
        bottomTitleList?.isActive = true
        
        bottomTableViewList = allRankingTable.bottomAnchor.constraint(equalTo: contentView1.bottomAnchor, constant: -20)
        bottomTableViewList?.isActive = false
        
        
        scrollView.delegate = self
        scrollView1.delegate = self
        allRankingTable.dataSource = self
        allRankingTable.delegate = self
        liveTableView.dataSource = self
        liveTableView.delegate = self
    
    }
    
    @objc func infoAction() {
        
        infoButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        rankingButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        scrollView.isHidden = false
        scrollView1.isHidden = true
        
    }
    
    @objc func rankingAction() {
        
        infoButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        rankingButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        scrollView.isHidden = true
        scrollView1.isHidden = false
        
    }
    
    @objc func openRankingList() {
        
        if allRankingTable.isHidden {
            uViewCVRank.isHidden = true
            topAnchorView?.isActive = false
            topAnchorNOCVRank?.isActive = true
            bottomTitleList?.isActive = false
            bottomTableViewList?.isActive = true
            allRankingTable.isHidden = false
        }else{
            uViewCVRank.isHidden = false
            topAnchorView?.isActive = true
            topAnchorNOCVRank?.isActive = false
            bottomTitleList?.isActive = true
            bottomTableViewList?.isActive = false
            allRankingTable.isHidden = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.view.layoutIfNeeded()

        }, completion: nil)
        
    }
    
    @objc func openTopTen() {
        
        if uViewCVRank.isHidden {
            topAnchorView?.isActive = true
            topAnchorNOCVRank?.isActive = false
            uViewCVRank.isHidden = false
        }else{
            topAnchorView?.isActive = false
            topAnchorNOCVRank?.isActive = true
            uViewCVRank.isHidden = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.view.layoutIfNeeded()

        }, completion: nil)
        
    }
    
    func loadMatchLive() {
        
        let participant1 = MatchParticipant(firstName: "Mariano", lastName: "Balarino", profilePicture: "person1", points: ["4","-","-"], win: false)
        let participant2 = MatchParticipant(firstName: "Ezequiel", lastName: "Martinez", profilePicture: "person2", points: ["2","-","-"],win: false)
        
        matchesLive.append(AllMatches(nameTour: "Torneo Club Mitre", dateTour: "En vivo", detailTour: "Zona de Grupos - Grupo A - Jornada 1 de 3", participant: [participant1,participant2]))
        
        liveTableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0

        if tableView == allRankingTable {
            countTable = rankPlayersLastName.count
        }
        if tableView == liveTableView {
            countTable = matchesLive.count
        }

        return countTable
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()


        if tableView == allRankingTable {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! RankingTableCell
            myCell.labelPosition.text = "#\(String(indexPath.row + 1)) Posicion en el Ranking"
            myCell.labelName.text = rankPlayersName[indexPath.row]
            myCell.labelLastname.text = rankPlayersLastName[indexPath.row].uppercased()
            myCell.labelPosB.text = "\(String(indexPath.row + 1))"
            myCell.labelPointsB.text = "\(String(rankingPoints[indexPath.row]))"
            myCell.labelPlaysB.text = "\(String(rankPlays[indexPath.row]))"
            myCell.labelWinsB.text = "\(String(rankWins[indexPath.row]))%"
            myCell.labelToursB.text = "\(String(rankTours[indexPath.row]))"
            
            if indexPath.row == 0 {
                myCell.tourImage.image = #imageLiteral(resourceName: "Pelota Oro")
            }
            
            if indexPath.row == 1 {
                myCell.tourImage.image = #imageLiteral(resourceName: "Pelota Plata")
            }
            if indexPath.row == 2 {
                myCell.tourImage.image = #imageLiteral(resourceName: "Pelota Bronce")
            }
            if indexPath.row == 3 {
                myCell.tourImage.image = #imageLiteral(resourceName: "Pelota Resto")
            }
            if indexPath.row == 4 {
                myCell.tourImage.image = #imageLiteral(resourceName: "Pelota Plata Negativo")
            }

            
            returnCell = myCell
        }
        
        if tableView == liveTableView {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LiveTableViewCell

            myCell.labelTorneo.text = matchesLive[indexPath.row].nameTour
            myCell.labelDate.text = matchesLive[indexPath.row].dateTour
            myCell.labelDatails.text = matchesLive[indexPath.row].detailTour
            myCell.labelName.text = matchesLive[indexPath.row].participant[0].firstName
            myCell.labelLastname.text = matchesLive[indexPath.row].participant[0].lastName
            myCell.labelName1.text = matchesLive[indexPath.row].participant[1].firstName
            myCell.labelLastname1.text = matchesLive[indexPath.row].participant[1].lastName
            myCell.imagePhotoHeader.image = UIImage(named: matchesLive[indexPath.row].participant[0].profilePicture)
            myCell.imagePhotoHeader1.image = UIImage(named: matchesLive[indexPath.row].participant[1].profilePicture)
            
            if matchesLive[indexPath.row].participant[0].win {
                myCell.imageBallPlayer1.isHidden = false
            }else{
                myCell.imageBallPlayer1.isHidden = true
            }
            
            if matchesLive[indexPath.row].participant[1].win {
                myCell.imageBallPlayer2.isHidden = false
            }else{
                myCell.imageBallPlayer2.isHidden = true
            }
            
            let dataArray = matchesLive[indexPath.row].participant[0].points
            myCell.updateCellWith(row: dataArray)
            
            let dataArray1 = matchesLive[indexPath.row].participant[1].points
            myCell.updateCellWith1(row: dataArray1)
            
            returnCell = myCell
        }
        
        return returnCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("Testing")

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         cell.layoutIfNeeded()
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
        if collectionView == snapCollectionRank {
            returnInt = rankingPoints.count
        }
        return returnInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        
        if collectionView == snapCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ProfesorCollectionCell
        let data = self.profesorsTitle[indexPath.item]
            cell.labelTitle.text = String(data).uppercased()
        cell.imageType.image = UIImage(named: profesorsImage[indexPath.row])
        returnCell = cell
        }
        
        if collectionView == snapCollectionNews {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! NewsCollectionCell
            cell.imageType.image = UIImage(named: allNews[indexPath.row])
            returnCell = cell
            
        }
        
        if collectionView == snapCollectionRank {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! RankCollectionCell
            cell.imagePerson.image = UIImage(named: rankImages[indexPath.row])
            cell.labelName.text = "\(rankPlayersName[indexPath.row].uppercased()),"
            cell.labelLastName.text = rankPlayersLastName[indexPath.row].uppercased()
            cell.labelPoints.text = rankingPoints[indexPath.row]
            cell.labelPos.text = "#\(indexPath.row + 1) Posición"
            
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
        if collectionView == snapCollectionRank {
            sizeCollection = CGSize(width: uViewCVRank.bounds.width / 2, height: uViewCVRank.bounds.height)
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

