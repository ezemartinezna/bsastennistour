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
    var position : Int
    var points : Int
    
    public init(name : String, lastname : String, imageprofile : String, score : String, position : Int, points : Int) {
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

public struct MatchParticipant {
    
    var firstName : String
    var lastName : String
    var profilePicture : String
    var points : [String]
    var win : Bool
    
}

public struct AllMatches {
    
    var nameTour : String
    var dateTour : String
    var detailTour : String
    var participant : [MatchParticipant]
    
}

public struct Tourament {
    var name : String
    var day : String
    var model : String
    var max : Int
    var stats : [TourStats]
    var players : [PlayerStat]
    var winPoints : [Points]
    var llave : [Llaves]
    var zone : [Zonas]
    
    public init(name : String,
                day : String,
                model : String,
                max : Int,
                stats : [TourStats],
                players : [PlayerStat],
                winPoints : [Points],
                llave : [Llaves],
                zone : [Zonas]) {
        
        self.name = name
        self.day = day
        self.model = model
        self.max = max
        self.stats = stats
        self.players = players
        self.winPoints = winPoints
        self.llave = llave
        self.zone = zone
    
    }
}

public struct TourStats {
    var title : String
    var value : Any
    
    public init(title : String,
                value : Any) {
        
        self.title = title
        self.value = value
        
    }
    
    
}

public struct Points {
    var title : String
    var number : Int
    
    public init(title : String, number : Int) {
        self.title = title
        self.number = number
    }
}

public struct PlayerStat {
    
    var id : String
    var fullName : String
    var points : Int
    var rank : Int
    var picture : String
    
    public init(id : String,fullName : String,points : Int,rank : Int,picture : String) {
        self.id = id
        self.fullName = fullName
        self.points = points
        self.rank = rank
        self.picture = picture
    }
}

public struct PlayerLlave {
    
    var match : String
    var id : String
    var fullName : String
    var picture : String
    var win : Bool
    var set : [String]
    
    public init(match:String,id : String, fullName : String,picture:String,win:Bool,set:[String]) {
        self.match = match
        self.id = id
        self.fullName = fullName
        self.picture = picture
        self.win = win
        self.set = set
    }
    
}

public struct Match {
    
    var name : String
    var player1 : PlayerLlave
    var player2 : PlayerLlave
    
    public init(name : String, player1 : PlayerLlave, player2: PlayerLlave) {
        self.name = name
        self.player1 = player1
        self.player2 = player2
    }
}

public struct PlayerZona {
    
    var id : String
    var fullName : String
    var picture : String
    var win : Int
    var lose : Int
    var points : Int
    
    public init(id : String,fullName : String,picture:String,win:Int,lose:Int,points:Int) {
        self.id = id
        self.fullName = fullName
        self.picture = picture
        self.win = win
        self.lose = lose
        self.points = points
    }
}

public struct Llaves {
    var name : String
    var types : [Match]
    
    public init(name:String,types:[Match]) {
        self.name = name
        self.types = types
    }
}
public struct Zonas {
    var name : String
    var types : [PlayerZona]
    
    public init(name:String,types:[PlayerZona]) {
        self.name = name
        self.types = types
    }
}
