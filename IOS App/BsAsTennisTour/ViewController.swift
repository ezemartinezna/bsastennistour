//
//  ViewController.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 24/11/2020.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FBSDKLoginKit
import AuthenticationServices
import CryptoKit

class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var ref: DatabaseReference!
    private var currentNonce : String?
    
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
        
        let userEmailAddress = textEmail.text!
        let userPassword = textPassword.text!
        
        if(userEmailAddress.isEmpty || userPassword.isEmpty)
        {
          // Display an alert message
            self.showAlert(title: "Error", message: NSLocalizedString("Complete los datos de Usuario y Contraseña", comment: ""))
            return
        }
        
        Auth.auth().signIn(withEmail: userEmailAddress, password: userPassword){ (result,error) in
            
            if let result = result, error == nil {
                
                let uid = result.user.uid
                let email = result.user.email ?? "NIL"
                let emailverify = result.user.isEmailVerified
                if emailverify {
                    self.firebaseDBLogin(uid: uid,email: email,firstname: "NIL",lastname: "NIL",provider: "Mail")
                }else{
                    self.showAlert(title: NSLocalizedString("Active su Email", comment: ""), message: NSLocalizedString("Active su cuenta desde el link que se le envio a su buzon.", comment: ""))
                }
                
                
            }else{
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }
        }
        
    }
    
    @objc func createAccount() {
        
        let userEmail = textEmail.text!
        let userPassword = textPassword.text!
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, error) in
            
            if let result = result, error == nil {
                
                let uid = result.user.uid
                self.ref = Database.database().reference().child("Users/\(uid)")
                let user = ["userEmail" : userEmail,"firstName" : "-","lastName":"-","admin" : "0","badge":"0","rank" : 0,"points":0,"picture":"https://firebasestorage.googleapis.com/v0/b/bsastennistour.appspot.com/o/perfilIcon.png?alt=media&token=1653dd88-f0c5-46e8-8276-9861b2967cfb"] as [String : Any]

                self.ref.setValue(user){
                  (error:Error?, ref:DatabaseReference) in
                  if let error = error {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                  } else {
                    result.user.sendEmailVerification { error in
                        if let error = error {
                            self.showAlert(title: "Error", message: error.localizedDescription)
                        }else{
                            self.showAlert(title: "Cuenta Creada", message: "Se creó correctamente la cuenta")
                        }
                    }
                  }
                }
               
        
                
            }else{
                self.showAlert(title: "Error",message: error!.localizedDescription)
            }
            
        }
        

        
    }
    
    @objc func facebookLogin() {
        
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions:[ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            
            switch loginResult {
            
            case .failed(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            
            case .cancelled:
                print("User cancelled login process.")
                break
            
            case .success(granted: let granted,declined: _, token: let token):
                
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                
                Auth.auth().signIn(with: credential) { (result, error) in
                
                    if let result = result, error == nil {
                        
                        var firstName : String = "NIL"
                        var lastName : String = "NIL"
                        var email : String = "NIL"
                        let uid = result.user.uid
                        
                        if (granted.contains(.email) && (granted.contains(.publicProfile))){
                            let fullname = result.user.displayName ?? "NIL"
                            email = result.user.email ?? "NIL"
                            var components = fullname.components(separatedBy: " ")
                            if components.count > 0 {
                                firstName = components.removeFirst()
                                lastName = components.joined(separator: " ")
                            }
                        }
                        
                        self.firebaseDBLogin(uid: uid,email: email,firstname: firstName,lastname: lastName,provider: "Facebook")
                        
                        
                        
                    }else{
                      self.showAlert(title: "Error", message: error!.localizedDescription)
                    }
                }
                
            }
        }
        
        
    }
    
    @objc func googleLogin() {

        print("Google Login")
        
    }
    
    @objc func appleLogin() {

        currentNonce = randomNonceString()
       
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(currentNonce!)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    func firebaseDBLogin(uid:String,email:String,firstname:String,lastname:String,provider:String) {
        
    ref = Database.database().reference().child("Users/\(uid)")
    
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
        
      let value = snapshot.value as? NSDictionary
      let total = value?.allKeys.count
        if total ?? 0 > 0 {
          //ALREADY LOGIN
          let admin = value?["admin"] as? String ?? ""
            
            UserDefaults.standard.set(uid, forKey: "uid")
            UserDefaults.standard.set(provider, forKey: "Provider")
            
            var vc = UIViewController()
            
                
          if (admin != "1"){
               
            UserDefaults.standard.set("NO-1", forKey: "ADMIN")
            vc = UserMainTabBar()
        
          }else{
            
            UserDefaults.standard.set("YES-1", forKey: "ADMIN")
            vc = AdminMainTabBar()
            
          }
            
            UserDefaults.standard.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            
        }
        else{
            //NOT LOGIN BEFORE

            let user = ["userEmail" : email,"firstName" : firstname,"lastName":lastname,"admin" : "0","badge":"0","rank" : 0,"points":0,"picture":"https://firebasestorage.googleapis.com/v0/b/bsastennistour.appspot.com/o/perfilIcon.png?alt=media&token=1653dd88-f0c5-46e8-8276-9861b2967cfb"] as [String : Any]

            self.ref.setValue(user){
                       (error:Error?, ref:DatabaseReference) in
                       if let error = error {
                         self.showAlert(title: "Error", message: error.localizedDescription)
                       } else {

                        UserDefaults.standard.set(uid, forKey: "uid")
                        UserDefaults.standard.set(provider, forKey: "Provider")
                        UserDefaults.standard.synchronize()

                       }
                    }

        }
          }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension ViewController: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let nonce = currentNonce,
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let appleIDToken = appleIDCredential.identityToken,
            let appleIDTokenString = String(data: appleIDToken, encoding: .utf8) {

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: appleIDTokenString, rawNonce: nonce)

            Auth.auth().signIn(with: credential) { (result, error) in

                   if let result = result, error == nil {

                       let uid = result.user.uid
                       let firstname = appleIDCredential.fullName?.givenName ?? "NIL"
                       let lastname = appleIDCredential.fullName?.familyName ?? "NIL"
                       let email = appleIDCredential.email ?? "null@apple.com"

                       self.firebaseDBLogin(uid: uid,email: email,firstname: firstname,lastname: lastname,provider: "Apple")
                   }else{
                     self.showAlert(title: "Error", message: error!.localizedDescription)
                   }
            }
        }
    }


    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

