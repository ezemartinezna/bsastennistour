//
//  LlavesTableViewCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 23/07/2021.
//

import UIKit

class LlavesTableViewCell: UITableViewCell {
    
    var setPlayer1: [String] = []
    var setPlayer2: [String] = []
    
    let viewContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorSage
        return view
    }()
    
    let containerPhotoHeader : UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 28 / 2
           view.layer.masksToBounds = false
           view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
           view.layer.shadowOffset = CGSize(width: 0, height: 0)
           view.layer.shadowOpacity = 0.9
           view.backgroundColor = .clear
           return view
       }()
    
    let imagePhotoHeader: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.cornerRadius = 28 / 2
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
       }()
    
    let labelFullName: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPosition: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 13)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let containerPhotoHeader1 : UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 28 / 2
           view.layer.masksToBounds = false
           view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
           view.layer.shadowOffset = CGSize(width: 0, height: 0)
           view.layer.shadowOpacity = 0.9
           view.backgroundColor = .clear
           return view
       }()
    
    let imagePhotoHeader1: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.cornerRadius = 28 / 2
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
       }()
    
    let labelFullName1: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelPosition1: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 13)!
          label.textColor = .colorPaper
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelDatails: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.textColor = .colorRust
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let imageBallPlayer1: UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Pelota Top Ten")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    let container1CV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
    
    let imageBallPlayer2: UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Pelota Top Ten")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    let container2CV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
    
    let viewDivisor : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let imageLlave: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.image = #imageLiteral(resourceName: "key-image")
           imageView.contentMode = .scaleAspectFit
           return imageView
       }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupLayout()
       }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLayout() {
        
        contentView.backgroundColor = .clear
        contentView.addSubview(viewContainer)
        
        //PLAYER 1
        viewContainer.addSubview(containerPhotoHeader)
        containerPhotoHeader.addSubview(imagePhotoHeader)
        viewContainer.addSubview(labelFullName)
        viewContainer.addSubview(labelPosition)
        viewContainer.addSubview(imageBallPlayer1)
        viewContainer.addSubview(container1CV)
        container1CV.addSubview(scorePlayer1CV)
        
        //PLAYER 2
        viewContainer.addSubview(containerPhotoHeader1)
        containerPhotoHeader1.addSubview(imagePhotoHeader1)
        viewContainer.addSubview(labelFullName1)
        viewContainer.addSubview(labelPosition1)
        viewContainer.addSubview(imageBallPlayer2)
        viewContainer.addSubview(container2CV)
        container2CV.addSubview(scorePlayer2CV)
        
        
        viewContainer.addSubview(viewDivisor)
        contentView.addSubview(imageLlave)
        contentView.addSubview(labelDatails)
        
        
        NSLayoutConstraint.activate([
            
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            
            containerPhotoHeader.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 15),
            containerPhotoHeader.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 15),
            containerPhotoHeader.widthAnchor.constraint(equalToConstant: 28),
            containerPhotoHeader.heightAnchor.constraint(equalToConstant: 28),

            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.heightAnchor.constraint(equalTo: containerPhotoHeader.heightAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalTo: containerPhotoHeader.widthAnchor),
        
            labelFullName.topAnchor.constraint(equalTo: containerPhotoHeader.topAnchor, constant: -5),
            labelFullName.leadingAnchor.constraint(equalTo: containerPhotoHeader.trailingAnchor, constant: 15),
            
            labelPosition.topAnchor.constraint(equalTo: labelFullName.bottomAnchor, constant: 5),
            labelPosition.leadingAnchor.constraint(equalTo: labelFullName.leadingAnchor),
            
            imageBallPlayer1.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imageBallPlayer1.trailingAnchor.constraint(equalTo: container1CV.leadingAnchor, constant: -15),
            imageBallPlayer1.widthAnchor.constraint(equalToConstant: 30),
            imageBallPlayer1.heightAnchor.constraint(equalToConstant: 30),
            
            container1CV.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            container1CV.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            container1CV.widthAnchor.constraint(equalToConstant: 80),
            container1CV.heightAnchor.constraint(equalToConstant: 30),
            
            scorePlayer1CV.topAnchor.constraint(equalTo: container1CV.topAnchor),
            scorePlayer1CV.leadingAnchor.constraint(equalTo: container1CV.leadingAnchor),
            scorePlayer1CV.trailingAnchor.constraint(equalTo: container1CV.trailingAnchor),
            scorePlayer1CV.bottomAnchor.constraint(equalTo: container1CV.bottomAnchor),
            
            viewDivisor.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            viewDivisor.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            viewDivisor.heightAnchor.constraint(equalToConstant: 5),
            viewDivisor.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),

            containerPhotoHeader1.leadingAnchor.constraint(equalTo: containerPhotoHeader.leadingAnchor),
            containerPhotoHeader1.topAnchor.constraint(equalTo: viewDivisor.bottomAnchor, constant: 15),
            containerPhotoHeader1.widthAnchor.constraint(equalToConstant: 28),
            containerPhotoHeader1.heightAnchor.constraint(equalToConstant: 28),

            imagePhotoHeader1.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            imagePhotoHeader1.centerXAnchor.constraint(equalTo: containerPhotoHeader1.centerXAnchor),
            imagePhotoHeader1.heightAnchor.constraint(equalTo: containerPhotoHeader1.heightAnchor),
            imagePhotoHeader1.widthAnchor.constraint(equalTo: containerPhotoHeader1.widthAnchor),
        
            labelFullName1.topAnchor.constraint(equalTo: containerPhotoHeader1.topAnchor, constant: -5),
            labelFullName1.leadingAnchor.constraint(equalTo: containerPhotoHeader1.trailingAnchor, constant: 15),
            
            labelPosition1.topAnchor.constraint(equalTo: labelFullName1.bottomAnchor, constant: 5),
            labelPosition1.leadingAnchor.constraint(equalTo: labelFullName1.leadingAnchor),

            imageBallPlayer2.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            imageBallPlayer2.trailingAnchor.constraint(equalTo: container2CV.leadingAnchor, constant: -15),
            imageBallPlayer2.widthAnchor.constraint(equalToConstant: 30),
            imageBallPlayer2.heightAnchor.constraint(equalToConstant: 30),
            
            container2CV.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            container2CV.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            container2CV.widthAnchor.constraint(equalToConstant: 80),
            container2CV.heightAnchor.constraint(equalToConstant: 30),
            
            scorePlayer2CV.topAnchor.constraint(equalTo: container2CV.topAnchor),
            scorePlayer2CV.leadingAnchor.constraint(equalTo: container2CV.leadingAnchor),
            scorePlayer2CV.trailingAnchor.constraint(equalTo: container2CV.trailingAnchor),
            scorePlayer2CV.bottomAnchor.constraint(equalTo: container2CV.bottomAnchor),
            
            imageLlave.leadingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            imageLlave.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            
            labelDatails.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelDatails.topAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 5),
                                        
        ])
        
        
    }
    
    func updatePlayer1(row: [String]) {
        self.setPlayer1 = row
        self.scorePlayer1CV.reloadData()
  
       
    }
    
    func updatePlayer2(row: [String]) {
        self.setPlayer2 = row
        self.scorePlayer2CV.reloadData()
  
    }

}

extension LlavesTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
        var countTable = 0

        if collectionView == scorePlayer1CV {
            countTable = setPlayer1.count
        }
        if collectionView == scorePlayer2CV {
            countTable = setPlayer2.count
        }

        return countTable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MatchesCVCell
        
        if collectionView == scorePlayer1CV {
       
        let number = self.setPlayer1[indexPath.item]
        cell.labelTitle.text = String(number)
        returnCell = cell
        }
        
        if collectionView == scorePlayer2CV {

        let number = self.setPlayer2[indexPath.item]
        cell.labelTitle.text = String(number)
        returnCell = cell
        }


        return returnCell
    }
    
    
    
}
