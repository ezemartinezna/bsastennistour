//
//  Extensions.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 29/07/2021.
//

import UIKit

extension InscriptionsVC {
    
    func NameDivisor(fullName : String) -> (firstName: String,lastname : String) {
        
        var firstname = ""
        var lastname = ""
        
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            firstname = components.removeFirst()
            lastname = components.joined(separator: " ")
        }
    return(firstname,lastname)
    }
    
}

extension String {

    func indexes(of character: String,str : String) -> Int {

        if let range: Range<String.Index> = str.range(of: character) {
            let index: Int = str.distance(from: str.startIndex, to: range.lowerBound)
            return index
        }
        else {
            return 0
        }
      }
    
    func index(from: Int) -> Index {
         return self.index(startIndex, offsetBy: from)
     }

     func substring(from: Int) -> String {
         let fromIndex = index(from: from)
         return String(self[fromIndex...])
     }

     func substring(to: Int) -> String {
         let toIndex = index(from: to)
         return String(self[..<toIndex])
     }

     func substring(with r: Range<Int>) -> String {
         let startIndex = index(from: r.lowerBound)
         let endIndex = index(from: r.upperBound)
         return String(self[startIndex..<endIndex])
     }

}

extension UITabBarController {
    func createNavControllers(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected

        navController.navigationBar.barTintColor = .colorCoal
        navController.navigationBar.isTranslucent = false
        self.navigationController?.view.tintColor = .white
     //  navController.navigationBar.tintColor = .white

        return navController
    }
    
}


extension UIViewController
{
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func showAlert(title: String, message:String) {
     
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    func showAlertWithOkAction(title: String, message:String,index:Int) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in

            self.tabBarController?.selectedIndex = index
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
      func changeDateToArg(dateString : String) -> String {
    
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = "yyyy-MM-dd"
           
           let changeDate = dateFormatter.date(from:dateString)
                           
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           let turnInvert = formatter.string(from: changeDate!)

           return turnInvert
       }
    
      func changeDateToUS(dateString : String) -> String {
    
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = "dd-MM-yyyy"
           
           let changeDate = dateFormatter.date(from:dateString)
    
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           let turnInvert = formatter.string(from: changeDate!)

           return turnInvert
       }
    
    func convertStringToDate(dateString : String ) -> Date {
        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX")
          dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let date = dateFormatter.date(from:dateString) ?? today
        return date
    }
    
    
    
 
    
}

extension UIView {
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        self.addSubview(subview)
        switch edge {
        case .top, .bottom:
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .top {
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            } else {
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            }
        case .left, .right:
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .left {
                subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            } else {
                subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            }
        default:
            break
        }
    }
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension UITableView {
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
            
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        
    }
    
}

extension UICollectionView {
    
    func setEmptyView(title: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        
        titleLabel.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15).isActive = true
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        
        messageImageView.image = messageImage
        titleLabel.text = title
        
        UIView.animate(withDuration: 2, animations: {
            
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 2, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 2, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        
        self.backgroundView = emptyView

    }
    
    func restore() {
        
        self.backgroundView = nil
        
    }
    
}

extension UINavigationBar {

    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
