//
//  TouramentVC.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 26/03/2021.
//

import UIKit

class TouramentVC: UIViewController {
    
    var allZones = ["1","2"]
    
    let titleTorneo : UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "nameTour")
        label.textColor = .white
        label.isHighlighted = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.white.withAlphaComponent(0.6).cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.9
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerZoneCV: UIView = {
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
    
    lazy var zoneCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero,
           collectionViewLayout: layout)
           layout.scrollDirection = .horizontal
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.layer.cornerRadius = 20
           collectionView.backgroundColor = .mainGray
           collectionView.register(ZoneTableCell.self, forCellWithReuseIdentifier: "MyCell")
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           collectionView.isPagingEnabled = true
           return collectionView
       }()
    
    private lazy var pageControl: UIPageControl = {
         let pc = UIPageControl()
         pc.currentPage = 0
         pc.numberOfPages = allZones.count
         pc.currentPageIndicatorTintColor = .black
         pc.pageIndicatorTintColor = .white
         pc.translatesAutoresizingMaskIntoConstraints = false
         return pc
     }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()

    }
    

    func setupLayout() {
        
        view.backgroundColor = .mainGray
        view.addSubview(viewContainer)

        viewContainer.addSubview(titleTorneo)
        
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        
        titleTorneo.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        titleTorneo.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        
        view.addSubview(containerZoneCV)
        containerZoneCV.addSubview(zoneCollectionView)
        containerZoneCV.addSubview(pageControl)
        
        containerZoneCV.topAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 20).isActive = true
        containerZoneCV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerZoneCV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        containerZoneCV.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        zoneCollectionView.topAnchor.constraint(equalTo: containerZoneCV.topAnchor, constant: 5).isActive = true
        zoneCollectionView.leadingAnchor.constraint(equalTo: containerZoneCV.leadingAnchor, constant: 5).isActive = true
        zoneCollectionView.trailingAnchor.constraint(equalTo: containerZoneCV.trailingAnchor, constant: -5).isActive = true
        zoneCollectionView.bottomAnchor.constraint(equalTo: containerZoneCV.bottomAnchor, constant: -5).isActive = true
        
        pageControl.centerXAnchor.constraint(equalTo: containerZoneCV.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: containerZoneCV.bottomAnchor).isActive = true

        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == zoneCollectionView {
   
         let x = targetContentOffset.pointee.x
         pageControl.currentPage = Int(x / containerZoneCV.bounds.width)

        }

    }

}

extension TouramentVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnInt = 0
        if collectionView == zoneCollectionView {
        returnInt = allZones.count
        }
        return returnInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        
        if collectionView == zoneCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ZoneTableCell
        let number = self.allZones[indexPath.item]
        cell.lableTitle.text = String(number)
        returnCell = cell
        }
        
        
        return returnCell
    }
    
  
}

extension TouramentVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var sizeCollection = CGSize(width: 10, height: 10)
        if collectionView == zoneCollectionView {
            sizeCollection = CGSize(width: containerZoneCV.bounds.width, height: containerZoneCV.bounds.height)
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


