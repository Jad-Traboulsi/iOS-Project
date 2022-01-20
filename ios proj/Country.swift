//
//  Response.swift
//  ios proj
//
//  Created by Epita on 18/01/2022.
//

import Foundation


struct Country:Codable{
    init(name: String? = nil, alpha2Code: String? = nil, flags: [String : String]? = nil, capital: String? = nil, area: Double? = nil, population: Int? = nil, currencies: [Currency]? = nil, region: String? = nil, timezones: [String]? = nil, languages: [Language]? = nil, latlng: [Double]? = nil) {
        self.name = name
        self.alpha2Code = alpha2Code
        self.flags = flags
        self.capital = capital
        self.area = area
        self.population = population
        self.currencies = currencies
        self.region = region
        self.timezones = timezones
        self.languages = languages
        self.latlng = latlng
    }
    
    let name:String?
    let alpha2Code:String?
    let flags:[String:String]?
    let capital:String?
    let area:Double?
    let population:Int?
    let currencies:[Currency]?
    let region:String?
    let timezones:[String]?
    let languages:[Language]?
    let latlng:[Double]?
    
    
    

}

struct Currency:Codable{
    let code:String?
    let name:String?
    let symbol:String?
}
struct Language:Codable{
    
    let iso639_1:String?
    let iso639_2:String?
    let name:String?
    let nativeName:String?
}
