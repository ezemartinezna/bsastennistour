//
//  AllStructs.swift
//  BsAsTennisAcademy
//
//  Created by Ezequiel Martinez on 26/11/2020.
//

import Foundation

public struct Users {
    var name : String
    var lastname : String
    var imageProfile : String
    var score : String
    var position : String
    var points : String
    
    public init(name : String, lastname : String, imageprofile : String, score : String, position : String, points : String) {
        self.name = name
        self.lastname = lastname
        self.imageProfile = imageprofile
        self.score = score
        self.position = position
        self.points = points
    }
}


public struct AllParticipants {
    var allUsers: [Users]
    var collapsed: Bool
    var maxParticipants : Int
    
    public init(allUsers: [Users], collapsed: Bool = false,maxParticipants : Int) {
        self.allUsers = allUsers
        self.collapsed = true
        self.maxParticipants = maxParticipants
    }
}
