//
//  File.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 28/11/2020.
//

import UIKit

class UserMainTabBar : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .colorCoal
        tabBar.isTranslucent = false
        tabBar.tintColor = .mainGreen
     
        setupTabBar()
            
        self.tabBar.items?[0].title = "Main"
        self.tabBar.items?[1].title = "Mis Datos"
        self.tabBar.items?[2].title = "Partidos"
        self.tabBar.items?[3].title = "Jugador"
        self.tabBar.items?[4].title = "Conf."
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.colorPaper], for: .selected)
        

    }
    
    func setupTabBar() {
        
        let firstImageIdle = UIImage(named: "ballTennisResize")?.withRenderingMode(.alwaysOriginal)
        let firstImageSelect = UIImage(named: "ballTennisResize")?.withRenderingMode(.alwaysTemplate)
        firstImageIdle?.withTintColor(.mainGreen)
        firstImageSelect?.withTintColor(.gray)

        
        
        let firstController = createNavControllers(vc: UserMainVC(), selected: firstImageIdle!, unselected: firstImageSelect!)
        let secondController = createNavControllers(vc: UserRankingVC(), selected: firstImageIdle!, unselected: firstImageSelect!)
        let thirdController = createNavControllers(vc: UserPerfilVC(), selected: firstImageIdle!, unselected: firstImageSelect!)
        let fourController = createNavControllers(vc: UserPerfilVC(), selected: firstImageIdle!, unselected: firstImageSelect!)
        let fiveController = createNavControllers(vc: UserPerfilVC(), selected: firstImageIdle!, unselected: firstImageSelect!)

        viewControllers = [firstController,secondController,thirdController,fourController,fiveController]
     
      
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
