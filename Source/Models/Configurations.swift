//
//  IPGInit.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

public struct OnepayIPGInit{
    
    /// A Unicode string value that is a collection of characters.
    ///
    
    let userDetails: Customer
    
    
    let secDetails: Configurations
    let proDetails: Product
}

public struct Customer{

    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    
    public init(firstName: String, lastName: String, phone: String, email: String){
        
        self.firstName          = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lastName           = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.phone              = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        self.email              = email.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public struct Configurations{
    
    let token: String
    let appID: String
    let hashKey: String
    
    public init(token: String, appID: String, hashKey: String){
        
        self.token          = token
        self.appID          = appID
        self.hashKey        = hashKey
    }
}

public struct Product{
    
    let amount: Double
    let currency: CurrencyTypes
    let reference: String
    let transactionOrder: [TransactionOrder]?

    public init(amount: Double, curency: CurrencyTypes, reference: String, transactionOrder: [TransactionOrder]? = nil){
        
        self.amount             = amount
        self.currency           = curency
        self.reference          = reference
        self.transactionOrder   = transactionOrder
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
}

public class IPGInitBuilder{
    
    private(set) var user: Customer? = nil
    private(set) var security: Configurations? = nil
    private(set) var product: Product? = nil
    
    public init(){}
    
    public func setUser(_ user: Customer) {
        
        self.user = user
    }
    
    public func setSecurity(_ secDetails: Configurations) {
        
        self.security = secDetails
    }
    
    public func setProduct(_ productDetails: Product) {
        
        self.product = productDetails
    }
    
    public func build() -> OnepayIPGInit{
        
        if let user = self.user, let security = self.security, let product = self.product{
            
            if security.token.isEmpty{
                
                fatalError(IPGError.invalidToken.rawValue)
            }
            
            if security.appID.isEmpty{
                
                fatalError(IPGError.appIDEmpty.rawValue)
            }
            
            if security.hashKey.isEmpty{
                
                fatalError(IPGError.hashKeyError.rawValue)
            }
            
            if user.firstName.isEmpty{
                
                fatalError(IPGError.fnameEmpty.rawValue)
            }
            
            if user.lastName.isEmpty{
                
                fatalError(IPGError.lnameEmpty.rawValue)
            }
            
            if !user.email.isValidEmail(){
                
                fatalError(IPGError.invalidEmail.rawValue)
            }
            
            if !user.phone.isAValidPhone(){
                
                fatalError(IPGError.invalidPhone.rawValue)
            }
            
            if product.amount <= 0{
                
                fatalError(IPGError.zeroAmount.rawValue)
            }
            
            if product.reference.isEmpty{
                
                fatalError(IPGError.referenceEmpty.rawValue)
            }
            
            if let transOrder = product.transactionOrder{
                
                transOrder.forEach{ transOrder in
                    
                    if transOrder.itemName.isEmpty || transOrder.itemCode.isEmpty{
                        
                        fatalError(IPGError.transOrderEmptyValues.rawValue)
                    }
                }
            }
            
            return OnepayIPGInit(userDetails: user, secDetails: security, proDetails: product)
            
        }else{
            
            fatalError(IPGError.initError.rawValue)
        }
    }
}


