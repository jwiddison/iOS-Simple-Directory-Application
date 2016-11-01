//
//  Founder.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

struct Address {
    var address1 = ""
    var address2 = ""
    var city = ""
    var state = ""
    var zip = ""
    var country = ""
}

struct Founder : TableMapping, RowConvertible {

    // MARK: - Properties

    var id = 0
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
    var mailingAddress = Address()
    var imageUrl = ""
    var spouseImageUrl = ""
    var version = 0
    var deleted = 0
    var dirty = 0
    var new = 0
    var isPhoneListed = true
    var isEmailListed = true

    // MARK: - Table mapping
    
    static let databaseTableName = "founder"

    // MARK: - Field names

    static let id = "ID"
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
    static let status = "status"
    static let yearJoined = "year_joined"
    static let homeAddress1 = "home_address1"
    static let homeAddress2 = "home_address2"
    static let homeCity = "home_city"
    static let homeState = "home_state"
    static let homeZip = "home_zip"
    static let homeCountry = "home_country"
    static let organizationName = "organization_name"
    static let jobTitle = "job_title"
    static let workAddress1 = "work_address1"
    static let workAddress2 = "work_address2"
    static let workCity = "work_city"
    static let workState = "work_state"
    static let workZip = "work_zip"
    static let workCountry = "work_country"
    static let mailingSameAs = "mailing_same_as"
    static let mailingAddress1 = "mailing_address1"
    static let mailingAddress2 = "mailing_address2"
    static let mailingCity = "mailing_city"
    static let mailingState = "mailing_state"
    static let mailingZip = "mailing_zip"
    static let mailingCountry = "mailing_country"
    static let imageUrl = "image_url"
    static let spouseImageUrl = "spouse_image_url"
    static let version = "version"
    static let deleted = "deleted"
    static let dirty = "dirty"
    static let new = "new"
    static let isPhoneListed = "is_phone_listed"
    static let isEmailListed = "is_email_listed"
    
    // MARK: - Initialization

    init() {
        // All properties have their proper default values already
    }

    init(row: Row) {
        givenNames = row.value(named: Founder.givenNames)
        surnames = row.value(named: Founder.surnames)
        preferredFirstName = row.value(named: Founder.preferredFirstName)
        preferredFullName = row.value(named: Founder.preferredFullName)
        cell = row.value(named: Founder.cell)
        email = row.value(named: Founder.email)
        website = row.value(named: Founder.website)
        linkedIn = row.value(named: Founder.linkedIn)
        biography = row.value(named: Founder.biography)
        expertise = row.value(named: Founder.expertise)
        spouseGivenNames = row.value(named: Founder.spouseGivenNames)
        spouseSurnames = row.value(named: Founder.spouseSurnames)
        spousePreferredFirstName = row.value(named: Founder.spousePreferredFirstName)
        spousePreferredFullName = row.value(named: Founder.spousePreferredFullName)
        spouseCell = row.value(named: Founder.spouseCell)
        status = row.value(named: Founder.status)
        yearJoined = row.value(named: Founder.yearJoined)
        homeAddress.address1 = row.value(named: Founder.homeAddress1)
        homeAddress.address2 = row.value(named: Founder.homeAddress2)
        homeAddress.city = row.value(named: Founder.homeCity)
        homeAddress.state = row.value(named: Founder.homeState)
        homeAddress.zip = row.value(named: Founder.homeZip)
        homeAddress.country = row.value(named: Founder.homeCountry)
        organizationName = row.value(named: Founder.organizationName)
        jobTitle = row.value(named: Founder.jobTitle)
        workAddress.address1 = row.value(named: Founder.workAddress1)
        workAddress.address2 = row.value(named: Founder.workAddress2)
        workAddress.city = row.value(named: Founder.workCity)
        workAddress.state = row.value(named: Founder.workState)
        workAddress.zip = row.value(named: Founder.workZip)
        workAddress.country = row.value(named: Founder.workCountry)
        mailingSameAs = row.value(named: Founder.mailingSameAs)
        mailingAddress.address1 = row.value(named: Founder.mailingAddress1)
        mailingAddress.address2 = row.value(named: Founder.mailingAddress2)
        mailingAddress.city = row.value(named: Founder.mailingCity)
        mailingAddress.state = row.value(named: Founder.mailingState)
        mailingAddress.zip = row.value(named: Founder.mailingZip)
        mailingAddress.country = row.value(named: Founder.mailingCountry)
        imageUrl = row.value(named: Founder.imageUrl)
        spouseImageUrl = row.value(named: Founder.spouseImageUrl)
        version = row.value(named: Founder.version)
        deleted = row.value(named: Founder.deleted)
        dirty = row.value(named: Founder.dirty)
        new = row.value(named: Founder.new)
        isPhoneListed = row.value(named: Founder.isPhoneListed)
        isEmailListed = row.value(named: Founder.isEmailListed)
    }
}
