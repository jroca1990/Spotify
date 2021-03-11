//
//  AppContext.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import Foundation

class AppContext: NSObject {
    var countries: [Country] =  [Country]()
    
    private static var sharedAppContext: AppContext = {
        let appContext = AppContext()
        appContext.loadCountries()
        return appContext
    }()
    
    class func shared() -> AppContext {
        return sharedAppContext
    }
    
    func loadCountries() {
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "countries", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let listOfCountries = try! decoder.decode(Countries.self, from: data)
            self.countries = listOfCountries.countries
        }
    }
    
    func getCountryBy(code:String) -> Country {
        return (self.countries.first(where: {$0.code == code}))!
    }
}

