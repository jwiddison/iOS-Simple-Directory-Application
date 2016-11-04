//
//  Founder.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

class Founder : Record {

    // MARK: - Properties

    var id: Int
    var givenNames: String
    var surnames: String
    var preferredFirstName: String
    var preferredFullName: String
    var cell: String
    var email: String
    var website: String
    var linkedIn: String
    var biography: String
    var expertise: String
    var spouseGivenNames: String
    var spouseSurnames: String
    var spousePreferredFirstName: String
    var spousePreferredFullName: String
    var spouseCell: String
    var spouseEmail: String
    var status: String
    var yearJoined: String
    var homeAddress1: String
    var homeAddress2: String
    var homeCity: String
    var homeState: String
    var homeZip: String
    var homeCountry: String
    var organizationName: String
    var jobTitle: String
    var workAddress1: String
    var workAddress2: String
    var workCity: String
    var workState: String
    var workZip: String
    var workCountry: String
    var mailingAddress1: String
    var mailingAddress2: String
    var mailingCity: String
    var mailingState: String
    var mailingZip: String
    var mailingCountry: String
    var mailingSameAs: String
    var imageUrl: String
    var spouseImageUrl: String
    var registrationId: String
    var isPostAdmin: Bool
    var isPhoneListed: Bool
    var isEmailListed: Bool
    var version: Int
    var deleted: Int
    var dirty: Int
    var new: Int

    // MARK: - Table mapping

    override static var databaseTableName: String {
        return "founder"
    }

    // MARK: - Field names

    struct Field {
        static let id = "id"
        static let givenNames = "given_names"
        static let surnames = "surnames"
        static let preferredFirstName = "preferred_first_name"
        static let preferredFullName = "preferred_full_name"
        static let cell = "cell"
        static let email = "email"
        static let website = "web_site"
        static let linkedIn = "linked_in"
        static let biography = "biography"
        static let expertise = "expertise"
        static let spouseGivenNames = "spouse_given_names"
        static let spouseSurnames = "spouse_surnames"
        static let spousePreferredFirstName = "spouse_preferred_first_name"
        static let spousePreferredFullName = "spouse_preferred_full_name"
        static let spouseCell = "spouse_cell"
        static let spouseEmail = "spouse_email"
        static let status = "status"
        static let yearJoined = "year_joined"
        static let homeAddress1 = "home_address1"
        static let homeAddress2 = "home_address2"
        static let homeCity = "home_city"
        static let homeState = "home_state"
        static let homeZip = "home_postal_code"
        static let homeCountry = "home_country"
        static let organizationName = "organization_name"
        static let jobTitle = "job_title"
        static let workAddress1 = "work_address1"
        static let workAddress2 = "work_address2"
        static let workCity = "work_city"
        static let workState = "work_state"
        static let workZip = "work_postal_code"
        static let workCountry = "work_country"
        static let mailingAddress1 = "mailing_address1"
        static let mailingAddress2 = "mailing_address2"
        static let mailingCity = "mailing_city"
        static let mailingState = "mailing_state"
        static let mailingZip = "mailing_postal_code"
        static let mailingCountry = "mailing_country"
        static let mailingSameAs = "mailing_same_as"
        static let imageUrl = "image_url"
        static let spouseImageUrl = "spouse_image_url"
        static let registrationId = "registration_id"
        static let isPostAdmin = "post_admin"
        static let isPhoneListed = "is_phone_listed"
        static let isEmailListed = "is_email_listed"
        static let version = "version"
        static let deleted = "deleted"
        static let dirty = "dirty"
        static let new = "new"
    }

    static let allFieldsIdVersion = [
        Field.id, Field.givenNames, Field.surnames, Field.preferredFirstName,
        Field.preferredFullName, Field.cell, Field.email, Field.website, Field.linkedIn, Field.biography,
        Field.expertise, Field.spouseGivenNames, Field.spouseSurnames,
        Field.spousePreferredFirstName, Field.spousePreferredFullName, Field.spouseCell,
        Field.spouseEmail, Field.status, Field.yearJoined, Field.homeAddress1, Field.homeAddress2,
        Field.homeCity, Field.homeState, Field.homeZip, Field.homeCountry, Field.organizationName,
        Field.jobTitle, Field.workAddress1, Field.workAddress2, Field.workCity, Field.workState,
        Field.workZip, Field.workCountry, Field.mailingAddress1, Field.mailingAddress2,
        Field.mailingCity, Field.mailingState, Field.mailingZip, Field.mailingCountry,
        Field.mailingSameAs, Field.imageUrl, Field.spouseImageUrl, Field.registrationId,
        Field.isPostAdmin, Field.isPhoneListed, Field.isEmailListed, Field.version
    ]

    struct Flag {
        static let admin = "1"
        static let available = "0"
        static let clean = "0"
        static let deleted = "1"
        static let dirty = "1"
        static let existing = "0"
        static let listed = "1"
        static let new = "1"
        static let normal = "0"
        static let unlisted = "0"
    }

    // MARK: - Initialization

    override init() {
        id = 0
        givenNames = ""
        surnames = ""
        preferredFirstName = ""
        preferredFullName = ""
        cell = ""
        email = ""
        website = ""
        linkedIn = ""
        biography = ""
        expertise = ""
        spouseGivenNames = ""
        spouseSurnames = ""
        spousePreferredFirstName = ""
        spousePreferredFullName = ""
        spouseCell = ""
        spouseEmail = ""
        status = ""
        yearJoined = ""
        homeAddress1 = ""
        homeAddress2 = ""
        homeCity = ""
        homeState = ""
        homeZip = ""
        homeCountry = ""
        organizationName = ""
        jobTitle = ""
        workAddress1 = ""
        workAddress2 = ""
        workCity = ""
        workState = ""
        workZip = ""
        workCountry = ""
        mailingAddress1 = ""
        mailingAddress2 = ""
        mailingCity = ""
        mailingState = ""
        mailingZip = ""
        mailingCountry = ""
        mailingSameAs = ""
        imageUrl = ""
        spouseImageUrl = ""
        registrationId = ""
        isPostAdmin = false
        isPhoneListed = true
        isEmailListed = true
        version = 0
        deleted = 0
        dirty = 0
        new = 1

        super.init()
    }

    required init(row: Row) {
        id = row.value(named: Field.id)
        givenNames = row.value(named: Field.givenNames)
        surnames = row.value(named: Field.surnames)
        preferredFirstName = row.value(named: Field.preferredFirstName)
        preferredFullName = row.value(named: Field.preferredFullName)
        cell = row.value(named: Field.cell)
        email = row.value(named: Field.email)
        website = row.value(named: Field.website)
        linkedIn = row.value(named: Field.linkedIn)
        biography = row.value(named: Field.biography)
        expertise = row.value(named: Field.expertise)
        spouseGivenNames = row.value(named: Field.spouseGivenNames)
        spouseSurnames = row.value(named: Field.spouseSurnames)
        spousePreferredFirstName = row.value(named: Field.spousePreferredFirstName)
        spousePreferredFullName = row.value(named: Field.spousePreferredFullName)
        spouseCell = row.value(named: Field.spouseCell)
        spouseEmail = row.value(named: Field.spouseEmail)
        status = row.value(named: Field.status)
        yearJoined = row.value(named: Field.yearJoined)
        homeAddress1 = row.value(named: Field.homeAddress1)
        homeAddress2 = row.value(named: Field.homeAddress2)
        homeCity = row.value(named: Field.homeCity)
        homeState = row.value(named: Field.homeState)
        homeZip = row.value(named: Field.homeZip)
        homeCountry = row.value(named: Field.homeCountry)
        organizationName = row.value(named: Field.organizationName)
        jobTitle = row.value(named: Field.jobTitle)
        workAddress1 = row.value(named: Field.workAddress1)
        workAddress2 = row.value(named: Field.workAddress2)
        workCity = row.value(named: Field.workCity)
        workState = row.value(named: Field.workState)
        workZip = row.value(named: Field.workZip)
        workCountry = row.value(named: Field.workCountry)
        mailingAddress1 = row.value(named: Field.mailingAddress1)
        mailingAddress2 = row.value(named: Field.mailingAddress2)
        mailingCity = row.value(named: Field.mailingCity)
        mailingState = row.value(named: Field.mailingState)
        mailingZip = row.value(named: Field.mailingZip)
        mailingCountry = row.value(named: Field.mailingCountry)
        mailingSameAs = row.value(named: Field.mailingSameAs)
        imageUrl = row.value(named: Field.imageUrl)
        spouseImageUrl = row.value(named: Field.spouseImageUrl)
        registrationId = row.value(named: Field.registrationId)
        isPostAdmin = row.value(named: Field.isPostAdmin)
        isPhoneListed = row.value(named: Field.isPhoneListed)
        isEmailListed = row.value(named: Field.isEmailListed)
        version = row.value(named: Field.version)
        deleted = row.value(named: Field.deleted)
        dirty = row.value(named: Field.dirty)
        new = row.value(named: Field.new)
        super.init(row: row)
    }
    
    override var persistentDictionary: [String : DatabaseValueConvertible?] {
        // NOTE: using an array literal here causes Xcode 8.1 to spin forever,
        // chewing up memory and CPU.  It's an Xcode bug.  Workaround: create
        // the dictionary long-form.
        var dictionary: [String : DatabaseValueConvertible?] = [ Field.id : id]

        dictionary[Field.givenNames] = givenNames
        dictionary[Field.surnames] = surnames
        dictionary[Field.preferredFirstName] = preferredFirstName
        dictionary[Field.preferredFullName] = preferredFullName
        dictionary[Field.cell] = cell
        dictionary[Field.email] = email
        dictionary[Field.website] = website
        dictionary[Field.linkedIn] = linkedIn
        dictionary[Field.biography] = biography
        dictionary[Field.expertise] = expertise
        dictionary[Field.spouseGivenNames] = spouseGivenNames
        dictionary[Field.spouseSurnames] = spouseSurnames
        dictionary[Field.spousePreferredFirstName] = spousePreferredFirstName
        dictionary[Field.spousePreferredFullName] = spousePreferredFullName
        dictionary[Field.spouseCell] = spouseCell
        dictionary[Field.spouseEmail] = spouseEmail
        dictionary[Field.status] = status
        dictionary[Field.yearJoined] = yearJoined
        dictionary[Field.homeAddress1] = homeAddress1
        dictionary[Field.homeAddress2] = homeAddress2
        dictionary[Field.homeCity] = homeCity
        dictionary[Field.homeState] = homeState
        dictionary[Field.homeZip] = homeZip
        dictionary[Field.homeCountry] = homeCountry
        dictionary[Field.organizationName] = organizationName
        dictionary[Field.jobTitle] = jobTitle
        dictionary[Field.workAddress1] = workAddress1
        dictionary[Field.workAddress2] = workAddress2
        dictionary[Field.workCity] = workCity
        dictionary[Field.workState] = workState
        dictionary[Field.workZip] = workZip
        dictionary[Field.workCountry] = workCountry
        dictionary[Field.mailingAddress1] = mailingAddress1
        dictionary[Field.mailingAddress2] = mailingAddress2
        dictionary[Field.mailingCity] = mailingCity
        dictionary[Field.mailingState] = mailingState
        dictionary[Field.mailingZip] = mailingZip
        dictionary[Field.mailingCountry] = mailingCountry
        dictionary[Field.mailingSameAs] = mailingSameAs
        dictionary[Field.imageUrl] = imageUrl
        dictionary[Field.spouseImageUrl] = spouseImageUrl
        dictionary[Field.registrationId] = registrationId
        dictionary[Field.isPostAdmin] = isPostAdmin
        dictionary[Field.isPhoneListed] = isPhoneListed
        dictionary[Field.isEmailListed] = isEmailListed
        dictionary[Field.version] = version
        dictionary[Field.deleted] = deleted
        dictionary[Field.dirty] = dirty
        dictionary[Field.new] = new

        return dictionary
    }
    
    func update(from json: JSONObject) {
        id = Int(json[Field.id] as! NSNumber)
        givenNames = json[Field.givenNames] as! String
        surnames = json[Field.surnames] as! String
        preferredFirstName = json[Field.preferredFirstName] as! String
        preferredFullName = json[Field.preferredFullName] as! String
        cell = json[Field.cell] as! String
        email = json[Field.email] as! String
        website = json[Field.website] as! String
        linkedIn = json[Field.linkedIn] as! String
        biography = json[Field.biography] as! String
        expertise = json[Field.expertise] as! String
        spouseGivenNames = json[Field.spouseGivenNames] as! String
        spouseSurnames = json[Field.spouseSurnames] as! String
        spousePreferredFirstName = json[Field.spousePreferredFirstName] as! String
        spousePreferredFullName = json[Field.spousePreferredFullName] as! String
        spouseCell = json[Field.spouseCell] as! String
        spouseEmail = json[Field.spouseEmail] as! String
        status = json[Field.status] as! String
        yearJoined = json[Field.yearJoined] as! String
        homeAddress1 = json[Field.homeAddress1] as! String
        homeAddress2 = json[Field.homeAddress2] as! String
        homeCity = json[Field.homeCity] as! String
        homeState = json[Field.homeState] as! String
        homeZip = json[Field.homeZip] as! String
        homeCountry = json[Field.homeCountry] as! String
        organizationName = json[Field.organizationName] as! String
        jobTitle = json[Field.jobTitle] as! String
        workAddress1 = json[Field.workAddress1] as! String
        workAddress2 = json[Field.workAddress2] as! String
        workCity = json[Field.workCity] as! String
        workState = json[Field.workState] as! String
        workZip = json[Field.workZip] as! String
        workCountry = json[Field.workCountry] as! String
        mailingAddress1 = json[Field.mailingAddress1] as! String
        mailingAddress2 = json[Field.mailingAddress2] as! String
        mailingCity = json[Field.mailingCity] as! String
        mailingState = json[Field.mailingState] as! String
        mailingZip = json[Field.mailingZip] as! String
        mailingCountry = json[Field.mailingCountry] as! String
        mailingSameAs = json[Field.mailingSameAs] as! String
        imageUrl = json[Field.imageUrl] as! String
        spouseImageUrl = json[Field.spouseImageUrl] as! String
        registrationId = json[Field.registrationId] as! String
        isPostAdmin = json[Field.isPostAdmin] as! String == Flag.admin
        isPhoneListed = json[Field.isPhoneListed] as! String == Flag.listed
        isEmailListed = json[Field.isEmailListed] as! String == Flag.listed
        version = Int(json[Field.version] as! String) ?? 0
    }
}
