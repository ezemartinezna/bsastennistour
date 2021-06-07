//
//  ViewController.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 24/11/2020.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    private let uViewBackground : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorMint
        uView.isUserInteractionEnabled = true
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()

    private let imageLogo : UIImageView  = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo-app")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let titleLabel : UILabel  = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)!
        label.textColor = .white
        label.text = "Buenos Aires Tennis Tour"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel1 : UILabel  = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica Bold", size: 20)!
        label.textColor = .white
        label.text = "TORNEOS"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("INICIAR SESIÓN", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.colorMint.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton1 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPop
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("CREAR CUENTA", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPaper, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    private let lineButton2 : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorPaper
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let uViewLoginRegister : UIView = {
        let uView = UIView()
        uView.backgroundColor = .white
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let uViewSocialMediaLogin : UIView = {
        let uView = UIView()
        uView.backgroundColor = .white
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelLogin : UILabel  = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica Bold", size: 19)
        label.textColor = .colorCoal
        label.text = "INICIAR SESIÓN"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelRegister : UILabel  = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica Bold", size: 19)
        label.textColor = .colorCoal
        label.isHidden = true
        label.text = "CREAR CUENTA"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelEmail : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Correo Electrónico"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textEmail : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.font = UIFont(name: "Helvetica", size: 15)
        text.clearButtonMode = .always
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let lineEmail : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelPassword : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 16)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Contraseña"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let textPassword : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.borderWidth = 0
        text.clearButtonMode = .always
        text.isSecureTextEntry = true
        text.font = UIFont(name: "Helvetica", size: 15)
        text.textColor = .colorCoal
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let linePassword : UIView = {
        let uView = UIView()
        uView.backgroundColor = .colorCoal
        uView.translatesAutoresizingMaskIntoConstraints = false
        return uView
    }()
    
    private let labelTermsCondition : UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Helvetica", size: 14)
         label.textColor = .colorCoal
         label.textAlignment = .left
         label.text = "Al registrarse, acepta nuestros "
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let buttonTermsCondition : UIButton = {
        let button = UIButton()
        button.setTitle("Terminos y Condiciones", for: .normal)
        button.setTitleColor(.colorPop, for: .selected)
        button.setTitleColor(.colorPop, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 13)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.underline()
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    private let loginButtonInit : UIButton = {
        let button = UIButton()
        button.setTitle("INICIAR SESIÓN", for: .normal)
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
        button.addTarget(self, action: #selector(emailLogin), for: .touchUpInside)
        return button
    }()
    
    private let registerButtonInit : UIButton = {
        let button = UIButton()
        button.setTitle("CREAR CUENTA", for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        button.layer.backgroundColor = UIColor.colorPop.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.isHidden = true
        button.layer.shadowOpacity = 0.9
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        return button
    }()
    
    private let labelOr : UILabel  = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textColor = .colorGray
        label.text = "o Iniciar Sesión con"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonFacebook : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "facebook_icon") as UIImage?
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.colorGray.cgColor
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(facebookLogin), for: .touchUpInside)
        return button
    }()
    
    private let buttonGoogle : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "googleImage") as UIImage?
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.colorGray.cgColor
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        return button
    }()
    
    private let buttonApple : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "appleIcon") as UIImage?
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.colorGray.cgColor
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.9
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLayout()
        
    }
    
    
    func loadLayout() {
        
        view.backgroundColor = .clear
//        var labelHeightFix = 35
//        let screenSize: CGRect = UIScreen.main.bounds
//
//
//        if screenSize.width > 500 {
//            labelHeightFix = 60
//            facebookLabel.font = .boldSystemFont(ofSize: 25)
//            googleLabel.font = .boldSystemFont(ofSize: 25)
//            appleLabel.font = .boldSystemFont(ofSize: 25)
//            titleLabel.font = .boldSystemFont(ofSize: 31)
//        }
        
        view.addSubview(uViewBackground)
        uViewBackground.addSubview(imageLogo)
        uViewBackground.addSubview(titleLabel)
        uViewBackground.addSubview(titleLabel1)
        uViewBackground.addSubview(uViewBackgroundLeft)
        uViewBackground.addSubview(uViewBackgroundRight)
        
        view.addSubview(loginButton)
        uViewBackgroundLeft.addSubview(lineButton1)
        
        view.addSubview(registerButton)
        uViewBackgroundRight.addSubview(lineButton2)
        
        view.addSubview(scrollView)
        scrollView.addSubview(uViewLoginRegister)
        uViewLoginRegister.addSubview(uViewSocialMediaLogin)
        
        uViewSocialMediaLogin.addSubview(labelOr)
        uViewSocialMediaLogin.addSubview(buttonFacebook)
        uViewSocialMediaLogin.addSubview(buttonApple)
        uViewSocialMediaLogin.addSubview(buttonGoogle)

        uViewLoginRegister.addSubview(labelTermsCondition)
        uViewLoginRegister.addSubview(buttonTermsCondition)
        
        //CONSTRAINTS
        
        uViewBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        uViewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uViewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uViewBackground.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        
        imageLogo.widthAnchor.constraint(equalToConstant: 160).isActive = true
        imageLogo.heightAnchor.constraint(equalToConstant: 160).isActive = true
        imageLogo.centerXAnchor.constraint(equalTo: uViewBackground.centerXAnchor).isActive = true
        imageLogo.centerYAnchor.constraint(equalTo: uViewBackground.centerYAnchor,constant: -40).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: uViewBackground.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageLogo.bottomAnchor,constant: -5).isActive = true
        
        titleLabel1.centerXAnchor.constraint(equalTo: uViewBackground.centerXAnchor).isActive = true
        titleLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        uViewBackgroundLeft.widthAnchor.constraint(equalTo: uViewBackground.widthAnchor, multiplier: 0.5).isActive = true
        uViewBackgroundLeft.centerYAnchor.constraint(equalTo: uViewBackground.centerYAnchor).isActive = true
        uViewBackgroundLeft.leadingAnchor.constraint(equalTo: uViewBackground.leadingAnchor).isActive = true
        
        uViewBackgroundRight.widthAnchor.constraint(equalTo: uViewBackground.widthAnchor, multiplier: 0.5).isActive = true
        uViewBackgroundRight.centerYAnchor.constraint(equalTo: uViewBackground.centerYAnchor).isActive = true
        uViewBackgroundRight.trailingAnchor.constraint(equalTo: uViewBackground.trailingAnchor).isActive = true
        
        lineButton1.leadingAnchor.constraint(equalTo: uViewBackgroundLeft.leadingAnchor, constant: 20).isActive = true
        lineButton1.trailingAnchor.constraint(equalTo: uViewBackgroundLeft.trailingAnchor, constant: -20).isActive = true
        lineButton1.bottomAnchor.constraint(equalTo: uViewBackground.bottomAnchor).isActive = true
        lineButton1.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: uViewBackgroundLeft.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: lineButton1.topAnchor, constant: -10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        loginButton.widthAnchor.constraint(equalTo: uViewBackgroundLeft.widthAnchor).isActive = true
        
        lineButton2.leadingAnchor.constraint(equalTo: uViewBackgroundRight.leadingAnchor, constant: 20).isActive = true
        lineButton2.trailingAnchor.constraint(equalTo: uViewBackgroundRight.trailingAnchor, constant: -20).isActive = true
        lineButton2.bottomAnchor.constraint(equalTo: uViewBackground.bottomAnchor).isActive = true
        lineButton2.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: uViewBackgroundRight.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: lineButton2.topAnchor, constant: -10).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        registerButton.widthAnchor.constraint(equalTo: uViewBackgroundRight.widthAnchor).isActive = true

        
        scrollView.delegate = self
        scrollView.topAnchor.constraint(equalTo: uViewBackground.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        uViewLoginRegister.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        uViewLoginRegister.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        uViewLoginRegister.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        uViewLoginRegister.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        uViewLoginRegister.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        uViewLoginRegister.addSubview(labelLogin)
   
        labelLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelLogin.topAnchor.constraint(equalTo: uViewLoginRegister.topAnchor,constant: 15).isActive = true
        
        uViewLoginRegister.addSubview(labelRegister)
        
        labelRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelRegister.topAnchor.constraint(equalTo: uViewLoginRegister.topAnchor,constant: 15).isActive = true
        
        uViewLoginRegister.addSubview(labelEmail)
        uViewLoginRegister.addSubview(textEmail)
        uViewLoginRegister.addSubview(lineEmail)

        uViewLoginRegister.addSubview(labelPassword)
        uViewLoginRegister.addSubview(textPassword)
        uViewLoginRegister.addSubview(linePassword)

        labelEmail.topAnchor.constraint(equalTo: labelLogin.bottomAnchor,constant: 30).isActive = true
        labelEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40).isActive = true
        labelEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40).isActive = true

        textEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 5).isActive = true
        textEmail.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        textEmail.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true
        textEmail.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textEmail.delegate = self

        lineEmail.topAnchor.constraint(equalTo: textEmail.bottomAnchor, constant: 5).isActive = true
        lineEmail.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        lineEmail.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true
        lineEmail.heightAnchor.constraint(equalToConstant: 2).isActive = true

        labelPassword.topAnchor.constraint(equalTo: lineEmail.bottomAnchor,constant: 30).isActive = true
        labelPassword.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        labelPassword.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true

        textPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 5).isActive = true
        textPassword.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        textPassword.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true
        textPassword.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textPassword.delegate = self

        linePassword.topAnchor.constraint(equalTo: textPassword.bottomAnchor, constant: 5).isActive = true
        linePassword.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        linePassword.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true
        linePassword.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        uViewLoginRegister.addSubview(loginButtonInit)
        uViewLoginRegister.addSubview(registerButtonInit)
        
        loginButtonInit.topAnchor.constraint(equalTo: linePassword.bottomAnchor,constant: 55).isActive = true
        loginButtonInit.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        loginButtonInit.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true
        loginButtonInit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButtonInit.topAnchor.constraint(equalTo: linePassword.bottomAnchor,constant: 55).isActive = true
        registerButtonInit.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor).isActive = true
        registerButtonInit.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor).isActive = true
        registerButtonInit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        uViewSocialMediaLogin.topAnchor.constraint(equalTo: registerButtonInit.bottomAnchor).isActive = true
        uViewSocialMediaLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uViewSocialMediaLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uViewSocialMediaLogin.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        labelOr.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelOr.topAnchor.constraint(equalTo: uViewSocialMediaLogin.topAnchor, constant: 35).isActive = true
        
        buttonFacebook.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonFacebook.topAnchor.constraint(equalTo: labelOr.bottomAnchor,constant: 30).isActive = true
        buttonFacebook.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonFacebook.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonApple.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 80).isActive = true
        buttonApple.centerYAnchor.constraint(equalTo: buttonFacebook.centerYAnchor).isActive = true
        buttonApple.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonApple.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonGoogle.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -80).isActive = true
        buttonGoogle.centerYAnchor.constraint(equalTo: buttonFacebook.centerYAnchor).isActive = true
        buttonGoogle.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonGoogle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        labelTermsCondition.centerXAnchor.constraint(equalTo: uViewLoginRegister.centerXAnchor,constant: -70).isActive = true
        labelTermsCondition.topAnchor.constraint(equalTo: uViewSocialMediaLogin.bottomAnchor, constant: 15).isActive = true
        labelTermsCondition.bottomAnchor.constraint(equalTo: uViewLoginRegister.bottomAnchor,constant: -15).isActive = true
        buttonTermsCondition.centerYAnchor.constraint(equalTo: labelTermsCondition.centerYAnchor).isActive = true
        buttonTermsCondition.leadingAnchor.constraint(equalTo: labelTermsCondition.trailingAnchor).isActive = true

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textEmail {
            labelEmail.textColor = .colorMint
            lineEmail.backgroundColor = .colorMint
        }
        
        if textField == textPassword {
            labelPassword.textColor = .colorMint
            linePassword.backgroundColor = .colorMint
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == textEmail {
            labelEmail.textColor = .colorCoal
            lineEmail.backgroundColor = .colorCoal
        }
        if textField == textPassword {
            labelPassword.textColor = .colorCoal
            linePassword.backgroundColor = .colorCoal
        }
    }
    
    
    @objc func loginAction() {
        
        loginButton.setTitleColor(.colorPop, for: .normal)
        lineButton1.backgroundColor = .colorPop
        registerButton.setTitleColor(.colorPaper, for: .normal)
        lineButton2.backgroundColor = .colorPaper
        
        labelLogin.isHidden = false
        labelRegister.isHidden = true
        
        loginButtonInit.isHidden = false
        registerButtonInit.isHidden = true
        
        uViewSocialMediaLogin.isHidden = false
        
    }
    
    @objc func registerAction() {
        
        
        loginButton.setTitleColor(.colorPaper, for: .normal)
        lineButton1.backgroundColor = .colorPaper
        registerButton.setTitleColor(.colorPop, for: .normal)
        lineButton2.backgroundColor = .colorPop
        
        labelLogin.isHidden = true
        labelRegister.isHidden = false
        
        loginButtonInit.isHidden = true
        registerButtonInit.isHidden = false
        
        uViewSocialMediaLogin.isHidden = true
        
        
        
    }
    
    @objc func emailLogin() {
        
        let mainPage = UserMainTabBar()
        mainPage.modalPresentationStyle = .fullScreen
        self.present(mainPage, animated: true, completion: nil)
        
    }
    
    @objc func createAccount() {
        
        
    }
    
    @objc func facebookLogin() {
        
        print("Facebook Login")
        
        
    }
    
    @objc func googleLogin() {

        print("Google Login")
        
    }
    
    @objc func appleLogin() {

        print("Google Login")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension UIViewController
{
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

