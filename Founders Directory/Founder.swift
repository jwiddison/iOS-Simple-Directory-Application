//
//  Founder.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation

class Founder {
    var name = ""
    var company = ""
    var phone = ""
    var email = ""
    var photoName = ""
    var phoneListed = true
    var emailListed = true
    var spouseName = ""
    var profile = ""

    init(name: String, company: String, phone: String, email: String, photoName: String,
         spouseName: String, profile: String) {
        self.name = name
        self.company = company
        self.phone = phone
        self.email = email
        self.photoName = photoName
        self.spouseName = spouseName
        self.profile = profile
    }
}
