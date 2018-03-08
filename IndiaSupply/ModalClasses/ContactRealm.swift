//
//  ContactRealm.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 12/5/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class  ContactRealm: NSObject, Mappable, NSCoding  {
    required init?(map: Map) {
        
    }

    var companies:Array<companiesDetail>?
    var filters:Array<FilterArray>?

    func mapping(map: Map) {
        
        self.companies <- map["companies"]
       self.filters <- map["filters"]

    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(companies,forKey:"companies")
        aCoder.encode(filters,forKey:"filters")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.companies = aDecoder.decodeObject(forKey: "companies") as! Array<companiesDetail>?
        self.filters = aDecoder.decodeObject(forKey: "filters") as! Array<FilterArray>?
        
    }
    
    
}


class companiesDetail: NSObject, Mappable, NSCoding  {
  
    required init?(map: Map) {
        
    }
    
    var company_id : Int?
    var company_name: String?
    var company_image : String?
    var company_website : String?
    var company_email: String?
    var company_description : String?
    var company_categories : String?
    
    var company_contacts:Array<companycontacts>?
    
    
    func mapping(map: Map) {
        
        self.company_id <- map["company_id"]
        self.company_name  <- map["company_name"]
        self.company_image <- map["company_image"]
        self.company_website  <- map["company_website"]
        self.company_email <- map["company_email"]
        self.company_description <- map["company_description"]
        self.company_categories  <- map["company_categories"]
        self.company_contacts <- map["company_contacts"]
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(company_id,forKey:"company_id")
        aCoder.encode(company_name,forKey:"company_name")
        aCoder.encode(company_image,forKey:"company_image")
        aCoder.encode(company_website,forKey:"company_website")
        aCoder.encode(company_email,forKey:"company_email")
        aCoder.encode(company_description,forKey:"company_description")
        aCoder.encode(company_categories,forKey:"company_categories")
        aCoder.encode(company_contacts,forKey:"company_contacts")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.company_id = aDecoder.decodeObject(forKey: "company_id") as? Int
        self.company_name = aDecoder.decodeObject(forKey: "company_name") as? String
        self.company_image = aDecoder.decodeObject(forKey: "company_image") as? String
        self.company_website = aDecoder.decodeObject(forKey: "company_website") as? String
        self.company_email = aDecoder.decodeObject(forKey: "company_email") as? String
        self.company_description = aDecoder.decodeObject(forKey: "company_description") as? String
        self.company_categories = aDecoder.decodeObject(forKey: "company_categories") as? String
        self.company_contacts = aDecoder.decodeObject(forKey: "company_contacts") as! Array<companycontacts>?
        
    }
}

class companycontacts: NSObject, Mappable, NSCoding  {
    required init?(map: Map) {
        
    }
    var contact_id : Int?
    var contact_name : String?
    var contact_image : String?
    var contact_phone : String?
    var contact_location : String?
    var contact_favourite : Int?
    var contact_email : String?
    var contact_website : String?
    var contact_type : Int?
    
    func mapping(map: Map) {
        
        self.contact_id     <- map["contact_id"]
        self.contact_name <- map["contact_name"]
        self.contact_image   <- map["contact_image"]
        self.contact_phone     <- map["contact_phone"]
        self.contact_location <- map["contact_location"]
        self.contact_favourite   <- map["contact_favourite"]
        self.contact_email   <- map["contact_email"]
        self.contact_website   <- map["contact_website"]
        self.contact_type   <- map["contact_type"]
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(contact_id,forKey:"contact_id")
        aCoder.encode(contact_name,forKey:"contact_name")
        aCoder.encode(contact_image,forKey:"contact_image")
        aCoder.encode(contact_phone,forKey:"contact_phone")
        aCoder.encode(contact_location,forKey:"contact_location")
        aCoder.encode(contact_favourite,forKey:"contact_favourite")
        aCoder.encode(contact_email,forKey:"contact_email")
        aCoder.encode(contact_website,forKey:"contact_website")
        aCoder.encode(contact_type,forKey:"contact_type")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.contact_id = aDecoder.decodeObject(forKey: "contact_id") as? Int
        self.contact_name = aDecoder.decodeObject(forKey: "contact_name") as? String
        self.contact_image = aDecoder.decodeObject(forKey: "contact_image") as? String
        self.contact_phone = aDecoder.decodeObject(forKey: "contact_phone") as? String
        self.contact_location = aDecoder.decodeObject(forKey: "contact_location") as? String
        self.contact_favourite = aDecoder.decodeObject(forKey: "contact_favourite") as? Int
        self.contact_email = aDecoder.decodeObject(forKey: "contact_email") as? String
        self.contact_website = aDecoder.decodeObject(forKey: "contact_website") as? String
        self.contact_type = aDecoder.decodeObject(forKey: "contact_type") as? Int
        
    }
}


class FilterArray: NSObject, Mappable, NSCoding  {
    required init?(map: Map) {
        
    }
    
    var group_name : String?
    var categories :Array<CategoryDetail>?
    
    func mapping(map: Map) {
        
        self.group_name     <- map["group_name"]
        self.categories <- map["categories"]
       
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(group_name,forKey:"group_name")
        aCoder.encode(categories,forKey:"categories")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.group_name = aDecoder.decodeObject(forKey: "group_name") as? String
        self.categories = aDecoder.decodeObject(forKey: "categories") as! Array<CategoryDetail>?
       
        
    }
}

class CategoryDetail: NSObject, Mappable, NSCoding  {
    required init?(map: Map) {
        
    }
    var category_id : Int?
    var category_name : String?
   
    
    func mapping(map: Map) {
        
        self.category_id     <- map["category_id"]
        self.category_name <- map["category_name"]
       
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(category_id,forKey:"category_id")
        aCoder.encode(category_name,forKey:"category_name")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.category_id = aDecoder.decodeObject(forKey: "category_id") as? Int
        self.category_name = aDecoder.decodeObject(forKey: "category_name") as? String
        
        
    }
}

