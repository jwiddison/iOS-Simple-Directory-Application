//
//  Founder.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation

class Address {
    var address1 = ""
    var address2 = ""
    var city = ""
    var state = ""
    var zip = ""
    var country = ""
}

class Founder {
    var givenNames = ""
    var surnames = ""
    var preferredFirstName = ""
    var preferredFullName = ""
    var cell = ""
    var email = ""
    var website = ""
    var linkedIn = ""
    var biography = ""
    var expertise = ""
    var spouseGivenNames = ""
    var spouseSurnames = ""
    var spousePreferredFirstName = ""
    var spousePreferredFullName = ""
    var spouseCell = ""
    var status = ""
    var yearJoined = ""
    var homeAddress = Address()
    var organizationName = ""
    var jobTitle = ""
    var workAddress = Address()
    var mailingSameAs = ""
    var imageUrl = ""
    var spouseImageUrl = ""
    var version = 0
    var deleted = 0
    var dirty = 0
    var new = 0
    var isPhoneListed = true
    var isEmailListed = true

    init(name: String, company: String, phone: String, email: String, photoName: String,
         spouseName: String, profile: String) {
        preferredFullName = name
        organizationName = company
        cell = phone
        self.email = email
        imageUrl = photoName
        spousePreferredFullName = spouseName
        biography = profile
    }
}
