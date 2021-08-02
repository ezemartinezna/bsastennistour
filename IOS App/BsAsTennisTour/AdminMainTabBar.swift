//
//  AdminMainTabBar.swift
//  BsAsTennisTour
//
//  Created by Ezequiel Martinez on 01/08/2021.
//

import UIKit

class AdminMainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .colorCoal
        tabBar.isTranslucent = false
        tabBar.tintColor = .colorPop
     
        setupTabBar()
            
        self.tabBar.items?[0].title = "Inicio"
        self.tabBar.items?[1].title = "Torneos"
        self.tabBar.items?[2].title = "Partidos"
        self.tabBar.items?[3].title = "Jugador"
        self.tabBar.items?[4].title = "Config."
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.colorPaper], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.colorPop], for: .selected)
        

    }
    
    func setupTabBar() {
        
        let firstImageIdle = UIImage(named: "ISO Main")?.withRenderingMode(.alwaysOriginal)
        let firstImageSelect = UIImage(named: "ISO ON CLICK Main (Naranja)")?.withRenderingMode(.alwaysTemplate)
        firstImageIdle?.withTintColor(.colorPaper)
        firstImageSelect?.withTintColor(.colorPop)
        
        let secImageIdle = UIImage(named: "ISO Torneo")?.withRenderingMode(.alwaysOriginal)
        let secImageSelect = UIImage(named: "ISO ON CLICK Torneo (Naranja)")?.withRenderingMode(.alwaysTemplate)
        secImageIdle?.withTintColor(.colorPaper)
        secImageSelect?.withTintColor(.colorPop)
        
        let thiImageIdle = UIImage(named: "ISO Partidos")?.withRenderingMode(.alwaysOriginal)
        let thiImageSelect = UIImage(named: "ISO ON CLICK Partidos (Naranja)")?.withRenderingMode(.alwaysTemplate)
        thiImageIdle?.withTintColor(.colorPaper)
        thiImageSelect?.withTintColor(.colorPop)
        
        let fouImageIdle = UIImage(named: "ISO Player")?.withRenderingMode(.alwaysOriginal)
        let fouImageSelect = UIImage(named: "ISO ON CLICK Player (Naranja)")?.withRenderingMode(.alwaysTemplate)
        fouImageIdle?.withTintColor(.colorPaper)
        fouImageSelect?.withTintColor(.colorPop)
        
        let fivImageIdle = UIImage(named: "ISO Settings")?.withRenderingMode(.alwaysOriginal)
        let fivImageSelect = UIImage(named: "ISO ON CLICK Settings (Naranja)")?.withRenderingMode(.alwaysTemplate)
        fivImageIdle?.withTintColor(.colorPaper)
        fivImageSelect?.withTintColor(.colorPop)
        
        let firstController = createNavControllers(vc: UserMainVC(), selected: firstImageSelect!, unselected: firstImageIdle!)
        let secondController = createNavControllers(vc: AdminTourVC(), selected: secImageSelect!, unselected: secImageIdle!)
        let thirdController = createNavControllers(vc: MatchesVC(), selected: thiImageSelect!, unselected: thiImageIdle!)
        let fourController = createNavControllers(vc: UserRankingVC(), selected: fouImageSelect!, unselected: fouImageIdle!)
        let fiveController = createNavControllers(vc: ConfigVC(), selected: fivImageSelect!, unselected: fivImageIdle!)

        viewControllers = [firstController,secondController,thirdController,fourController,fiveController]
     
      
    }
}
