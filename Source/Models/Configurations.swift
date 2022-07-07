//
//  IPGInit.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

public struct IPGInit{
    
    let token: String
    let firstName: String
    let lastName: String
    let phone: String
    let reference: String
    let appID: String
    let email: String
    let hashKey: String
    let amount: Float
    let currency: CurrencyTypes
    var transactionOrder: [TransactionOrder]? = nil
    
    
    public init(token: String, firstName: String, lastName: String, phone: String, reference: String, appID: String, email: String, hashKey: String, amount: Float, currency: CurrencyTypes, transactionOrder: [TransactionOrder]? = nil){
        
        self.token             = token
        self.firstName         = firstName
        self.lastName          = lastName
        self.phone             = phone
        self.reference         = reference
        self.appID             = appID
        self.email             = email
        self.hashKey           = hashKey
        self.amount            = amount
        self.currency          = currency
        self.transactionOrder  = transactionOrder
        
    }
}

public struct TransactionOrder: Encodable{
    
    let itemName: String
    let itemCode: String
    let quantity: Int
    let unitPrice: Float
    
    public init(itemName: String, itemCode: String, qty: Int, unitPrice: Float){
        
        self.itemName          = itemName
        self.itemCode          = itemCode
        self.quantity          = qty
        self.unitPrice         = unitPrice
    }
}

public enum CurrencyTypes: String{
    
    case LKR  =  "LKR"
    case USD  =  "USD"
}
