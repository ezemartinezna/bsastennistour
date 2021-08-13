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
    func showAlertWithOkAction(title: String, message:String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let mainPage = UserMainVC()
            let mainPageNav = UINavigationController(rootViewController: mainPage)
            mainPageNav.modalPresentationStyle = .fullScreen
            self.present(mainPageNav, animated: true, completion: nil)
            
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
