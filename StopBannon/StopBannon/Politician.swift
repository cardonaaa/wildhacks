//
//  Politician.swift
//  StopBannon
//
//  Created by Kathleen Lu on 11/19/16.
//  Copyright (c) 2016 Kyle Jablon. All rights reserved.
//


import Foundation

// MARK: Types

struct PropertyKey {
    static let firstname = "firstname"
    static let lastname = "lastname"
    static let phone = "phone"
    static let position = "position"
    static let party = "party"
    static let state = "state"
}

class Politician: NSObject, NSCoding {
    var firstname: String
    var lastname: String
    var phone: String
    var position: String
    var state: String
    var party: String
    var denounced: Bool
    
    // MARK: NSCoding
    
    init(firstname: String, lastname: String, phone: String, position: String, state: String, party:String) {
        self.firstname = firstname
        self.lastname = lastname
        self.phone = phone
        self.position = position
        self.state = state
        self.party = party
        self.denounced = false
    }
    
    required convenience init(coder decoder: NSCoder) {
        let firstname = decoder.decodeObject(forKey: "firstname") as! String
        let lastname = decoder.decodeObject(forKey: "lastname") as! String
        let phone = decoder.decodeObject(forKey: "phone") as! String
        let position = decoder.decodeObject(forKey: "positiion") as! String
        let state = decoder.decodeObject(forKey: "state") as! String
        let party = decoder.decodeObject(forKey: "party") as! String

        self.init(
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            position: position,
            state: state,
            party: party
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.firstname, forKey: "firstname")
        coder.encode(self.lastname, forKey: "lastname")
        coder.encode(self.phone, forKey: "phone")
        coder.encode(self.position, forKey: "position")
        coder.encode(self.state, forKey: "state")
        coder.encode(self.party, forKey: "party")
        coder.encode(self.denounced, forKey: "denounced")
    }
    
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("politicians")
    
}
