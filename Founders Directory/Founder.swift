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

    init() {
        // Default initializer
    }

    init(copy address: Address) {
        self.address1 = address.address1
        self.address2 = address.address2
        self.city = address.city
        self.state = address.state
        self.zip = address.zip
        self.country = address.country
    }
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
    
    init(founder: Founder) {
        givenNames = founder.givenNames
        surnames = founder.surnames
        preferredFirstName = founder.preferredFirstName
        preferredFullName = founder.preferredFullName
        cell = founder.cell
        email = founder.email
        website = founder.website
        linkedIn = founder.linkedIn
        biography = founder.biography
        expertise = founder.expertise
        spouseGivenNames = founder.spouseGivenNames
        spouseSurnames = founder.spouseSurnames
        spousePreferredFirstName = founder.spousePreferredFirstName
        spousePreferredFullName = founder.spousePreferredFullName
        spouseCell = founder.spouseCell
        status = founder.status
        yearJoined = founder.yearJoined
        homeAddress = Address(copy: founder.homeAddress)
        organizationName = founder.organizationName
        jobTitle = founder.jobTitle
        workAddress = Address(copy: founder.workAddress)
        mailingSameAs = founder.mailingSameAs
        imageUrl = founder.imageUrl
        spouseImageUrl = founder.spouseImageUrl
        version = founder.version
        deleted = founder.deleted
        dirty = founder.dirty
        new = founder.new
        isPhoneListed = founder.isPhoneListed
        isEmailListed = founder.isEmailListed
    }
}
