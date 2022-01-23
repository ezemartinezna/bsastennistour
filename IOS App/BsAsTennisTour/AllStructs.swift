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

public struct Ranking {
    var name : String?
    var allPlayers : [PlayerRank]?
    
    public init(name : String? = nil, allPlayers : [PlayerRank]? = nil) {
        self.name = name
        self.allPlayers = allPlayers
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
    var stats : [TourStats]
    var players : [PlayerStat]
    var winPoints : [Points]
    var llave : [Llaves]
    var zone : [Zonas]
    
    public init(name : String,
                stats : [TourStats],
                players : [PlayerStat],
                winPoints : [Points],
                llave : [Llaves],
                zone : [Zonas]) {
        
        self.name = name
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

public struct PlayerRank {
    
    var id : String
    var name : String
    var lastname : String
    var points : Int
    var picture : String
    var allMatch : Int
    var winMatch : Int
    var lostMatch : Int
    var tourMatch : Int
    
    public init(id : String,name : String,lastname : String,points : Int,picture : String,allMatch : Int, winMatch : Int, lostMatch : Int, tourMatch : Int) {
        self.id = id
        self.name = name
        self.lastname = lastname
        self.points = points
        self.picture = picture
        self.allMatch = allMatch
        self.winMatch = winMatch
        self.lostMatch = lostMatch
        self.tourMatch = tourMatch
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

public struct Llaves {
    var name : String
    var types : [Match]
    
    public init(name:String,types:[Match]) {
        self.name = name
        self.types = types
    }
}

///MARK: ZONAS TORNEOS
///
public struct Zonas {
    var name : String
    var numberZona : [NumberZona]
    
    public init(name:String,numberZona:[NumberZona]) {
        self.name = name
        self.numberZona = numberZona
    }
}

public struct NumberZona {
    var number : String
    var allPlayers : [ZonaUID]
    
    public init(number:String,allPlayers:[ZonaUID]) {
        self.number = number
        self.allPlayers = allPlayers
    }
}

public struct ZonaUID {
    var uid : String
    var player : PlayerZona
    
    public init(uid : String, player : PlayerZona) {
        self.uid = uid
        self.player = player
    }
}

public struct PlayerZona {
    
    var fullName : String
    var picture : String
    var win : Int
    var lose : Int
    var points : Int
    
    public init(fullName : String,picture:String,win:Int,lose:Int,points:Int) {
        self.fullName = fullName
        self.picture = picture
        self.win = win
        self.lose = lose
        self.points = points
    }
}

protocol ZonasLlavesDelegate:AnyObject {
    func ZonasCellTapped(position : String, index : Int,uid1:String,uid2:String)
    func LlavesCellTapped(match : String)
}
