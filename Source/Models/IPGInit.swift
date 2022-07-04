//
//  IPGInit.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

public struct IPGInit{
    
    let firstName: String
    let lastName: String
    let phone: String
    let reference: String
    let appID: String
    let email: String
    let hashKey: String
    let amount: Float
    let currency: CurrencyTypes
    
    
    public init(firstName: String, lastName: String, phone: String, reference: String, appID: String, email: String, hashKey: String, amount: Float, currency: CurrencyTypes){
        
        self.firstName         = firstName
        self.lastName          = lastName
        self.phone             = phone
        self.reference         = reference
        self.appID             = appID
        self.email             = email
        self.hashKey           = hashKey
        self.amount            = amount
        self.currency          = currency
    }
    
}
