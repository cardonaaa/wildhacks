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
        let firstname = decoder.decodeObjectForKey("firstname") as! String
        let lastname = decoder.decodeObjectForKey("lastname") as! String
        let phone = decoder.decodeObjectForKey("phone") as! String
        let position = decoder.decodeObjectForKey("positiion") as! String
        let state = decoder.decodeObjectForKey("state") as! String
        let party = decoder.decodeObjectForKey("party") as! String

        self.init(
            firstname: firstname,
            lastname: lastname,
            phone: phone,
            position: position,
            state: state,
            party: party
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.firstname, forKey: "firstname")
        coder.encodeObject(self.lastname, forKey: "lastname")
        coder.encodeObject(self.phone, forKey: "phone")
        coder.encodeObject(self.position, forKey: "position")
        coder.encodeObject(self.state, forKey: "state")
        coder.encodeObject(self.party, forKey: "party")
        coder.encodeBool(self.denounced, forKey: "denounced")
    }
    
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("politicians")
    
}
