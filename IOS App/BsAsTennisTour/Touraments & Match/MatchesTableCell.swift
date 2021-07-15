//
//  MatchesTableCell.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 06/06/2021.
//

import UIKit

//protocol AlertShower{
//    func showAlert(_: UITableViewCell)
//}

class MatchesTableCell: UITableViewCell {
    
    var dataArray: [String] = []
    var dataArray1: [String] = []
//    var delegate: AlertShower?
    
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
//           imageView.image = #imageLiteral(resourceName: "perfilIcon")
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
       }()
    
    let labelName: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 14)!
          label.textColor = .colorPaper
//          label.text = "Mariano"
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLastname: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 14)!
          label.textColor = .colorPaper
//          label.text = "BALARINO"
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
//           imageView.image = #imageLiteral(resourceName: "perfilIcon")
           imageView.contentMode = .scaleAspectFill
           imageView.isUserInteractionEnabled = true
           return imageView
       }()
    
    let labelName1: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 14)!
          label.textColor = .colorPaper
//          label.text = "Ezequiel"
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelLastname1: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 14)!
          label.textColor = .colorPaper
//          label.text = "MARTINEZ"
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelTorneo: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 14)!
          label.textColor = .colorMint
//          label.text = "Torneo Club Mitre"
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let labelDate: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica Bold", size: 14)!
          label.textColor = .colorPop
          label.translatesAutoresizingMaskIntoConstraints = false
          label.attributedText = NSAttributedString(string: "21 Sept", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
          return label
      }()
    
    let labelDatails: UILabel = {
          let label = UILabel()
          label.font = UIFont(name: "Helvetica", size: 12)!
          label.textColor = .colorGray
//          label.text = "Zona de Grupos - Grupo A - Jornada 1 de 3"
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
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
    
    private let imageBallPlayer1: UIImageView  = {
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
    
    private let imageBallPlayer2: UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Pelota Top Ten")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
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
        viewContainer.addSubview(labelName)
        viewContainer.addSubview(labelLastname)
        viewContainer.addSubview(container1CV)
        container1CV.addSubview(scorePlayer1CV)
        viewContainer.addSubview(imageBallPlayer1)
        
        //PLAYER 2
        viewContainer.addSubview(containerPhotoHeader1)
        containerPhotoHeader1.addSubview(imagePhotoHeader1)
        viewContainer.addSubview(labelName1)
        viewContainer.addSubview(labelLastname1)
        viewContainer.addSubview(container2CV)
        container2CV.addSubview(scorePlayer2CV)
        viewContainer.addSubview(imageBallPlayer2)

        viewContainer.addSubview(labelDate)
        viewContainer.addSubview(labelTorneo)
        viewContainer.addSubview(labelDatails)
        

        NSLayoutConstraint.activate([
            
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),

            labelTorneo.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 15),
            labelTorneo.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 15),
            
            containerPhotoHeader.leadingAnchor.constraint(equalTo: labelTorneo.leadingAnchor),
            containerPhotoHeader.topAnchor.constraint(equalTo: labelTorneo.bottomAnchor, constant: 15),
            containerPhotoHeader.widthAnchor.constraint(equalToConstant: 28),
            containerPhotoHeader.heightAnchor.constraint(equalToConstant: 28),

            imagePhotoHeader.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imagePhotoHeader.centerXAnchor.constraint(equalTo: containerPhotoHeader.centerXAnchor),
            imagePhotoHeader.heightAnchor.constraint(equalTo: containerPhotoHeader.heightAnchor),
            imagePhotoHeader.widthAnchor.constraint(equalTo: containerPhotoHeader.widthAnchor),
        
            labelName.topAnchor.constraint(equalTo: containerPhotoHeader.topAnchor, constant: -5),
            labelName.leadingAnchor.constraint(equalTo: containerPhotoHeader.trailingAnchor, constant: 15),
            
            labelLastname.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5),
            labelLastname.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            container1CV.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            container1CV.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            container1CV.widthAnchor.constraint(equalToConstant: 80),
            container1CV.heightAnchor.constraint(equalToConstant: 30),
            
            scorePlayer1CV.topAnchor.constraint(equalTo: container1CV.topAnchor),
            scorePlayer1CV.leadingAnchor.constraint(equalTo: container1CV.leadingAnchor),
            scorePlayer1CV.trailingAnchor.constraint(equalTo: container1CV.trailingAnchor),
            scorePlayer1CV.bottomAnchor.constraint(equalTo: container1CV.bottomAnchor),
            
            imageBallPlayer1.centerYAnchor.constraint(equalTo: containerPhotoHeader.centerYAnchor),
            imageBallPlayer1.trailingAnchor.constraint(equalTo: container1CV.leadingAnchor, constant: -15),
            imageBallPlayer1.widthAnchor.constraint(equalToConstant: 30),
            imageBallPlayer1.heightAnchor.constraint(equalToConstant: 30),

            containerPhotoHeader1.leadingAnchor.constraint(equalTo: labelTorneo.leadingAnchor),
            containerPhotoHeader1.topAnchor.constraint(equalTo: labelLastname.bottomAnchor, constant: 15),
            containerPhotoHeader1.widthAnchor.constraint(equalToConstant: 28),
            containerPhotoHeader1.heightAnchor.constraint(equalToConstant: 28),

            imagePhotoHeader1.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            imagePhotoHeader1.centerXAnchor.constraint(equalTo: containerPhotoHeader1.centerXAnchor),
            imagePhotoHeader1.heightAnchor.constraint(equalTo: containerPhotoHeader1.heightAnchor),
            imagePhotoHeader1.widthAnchor.constraint(equalTo: containerPhotoHeader1.widthAnchor),
        
            labelName1.topAnchor.constraint(equalTo: containerPhotoHeader1.topAnchor, constant: -5),
            labelName1.leadingAnchor.constraint(equalTo: containerPhotoHeader1.trailingAnchor, constant: 15),
            
            labelLastname1.topAnchor.constraint(equalTo: labelName1.bottomAnchor, constant: 5),
            labelLastname1.leadingAnchor.constraint(equalTo: labelName1.leadingAnchor),
            
            container2CV.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            container2CV.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            container2CV.widthAnchor.constraint(equalToConstant: 80),
            container2CV.heightAnchor.constraint(equalToConstant: 30),
            
            scorePlayer2CV.topAnchor.constraint(equalTo: container2CV.topAnchor),
            scorePlayer2CV.leadingAnchor.constraint(equalTo: container2CV.leadingAnchor),
            scorePlayer2CV.trailingAnchor.constraint(equalTo: container2CV.trailingAnchor),
            scorePlayer2CV.bottomAnchor.constraint(equalTo: container2CV.bottomAnchor),

            imageBallPlayer2.centerYAnchor.constraint(equalTo: containerPhotoHeader1.centerYAnchor),
            imageBallPlayer2.trailingAnchor.constraint(equalTo: container2CV.leadingAnchor, constant: -15),
            imageBallPlayer2.widthAnchor.constraint(equalToConstant: 30),
            imageBallPlayer2.heightAnchor.constraint(equalToConstant: 30),
            
            
            labelDate.centerYAnchor.constraint(equalTo: labelTorneo.centerYAnchor),
            labelDate.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20),
            
            labelDatails.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            labelDatails.topAnchor.constraint(equalTo: labelLastname1.bottomAnchor, constant: 15),
            

            
        ])


        
        
    }

}

extension MatchesTableCell {
    func updateCellWith(row: [String]) {
        self.dataArray = row
        self.scorePlayer1CV.reloadData()
  
       
    }
    
    func updateCellWith1(row: [String]) {
        self.dataArray1 = row
        self.scorePlayer2CV.reloadData()
  
    }
    
}


extension MatchesTableCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell = UICollectionViewCell()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MatchesCVCell
        
        if collectionView == scorePlayer1CV {
       
        let number = self.dataArray[indexPath.item]
        cell.labelTitle.text = String(number)
        returnCell = cell
        }
        
        if collectionView == scorePlayer2CV {

        let number = self.dataArray1[indexPath.item]
        cell.labelTitle.text = String(number)
        returnCell = cell
        }


        return returnCell
    }
    
    
}

extension MatchesTableCell : UICollectionViewDelegateFlowLayout {
    
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
    
}

