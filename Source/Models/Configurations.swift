//
//  IPGInit.swift
//
//
//  Created by onepay on 2022-07-04.
//

import Foundation
import UIKit

/**
 This class will initialise transaction details for payment gateway
 */
public struct OnepayIPGInit{

    let userDetails: Customer
    let secDetails: Configurations
    let proDetails: Product
}

/**
 This class will initialise product purchased customer details
 */
public struct Customer{
    
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    
    /**
     
     You can insert the customer information related to the product purchase here.
     
     
     - parameter firstName: Customer first name should be string. No spaces allow.
     - parameter lastName: Customer last name should be string. No spaces allow.
     - parameter phone: Customer phone should be string. Phone number should follow this formate "+947********".
     - parameter email: Customer email should be a string. No spaces allow.
     
     */
    public init(firstName: String, lastName: String, phone: String, email: String){
        
        self.firstName          = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lastName           = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.phone              = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        self.email              = email.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

/**
 This class will initialise SDK configurations
 */
public struct Configurations{
    
    let token: String
    let appID: String
    let hashKey: String
    
    /**
     You can insert the SDK configuration details here. Additionally, you can get configuration details via our onepay portal.
     
     
     - parameter token: Toke should be string. Please find your token in the onepay portal.
     - parameter appID: App Id should be string. Please find your app id  in the onepay portal.
     - parameter hashKey: hashKey should be string. Please find your app id  in the onepay portal.
     
     */
    public init(token: String, appID: String, hashKey: String){
        
        self.token          = token
        self.appID          = appID
        self.hashKey        = hashKey
    }
}

/**
 This class will initialise purchased product details
 */
public struct Product{
    
    let amount: String
    let currency: CurrencyTypes
    let reference: String
    let transactionOrder: [TransactionOrder]?
    
    
    /**
     You can insert the purchased product details here related to the payment gateway.
     
     
     - parameter amount: amount should be string. The amount format should be like "10.00"; the minimum amount is LKR 10.00 and USD 1.00.
     - parameter currency: Currency should be CurrencyTypes data type.
     - parameter reference: reference should be string.  Reference should have a minimum of ten characters. Spaces are not allowed.
     - parameter transactionOrder: transactionOrder should be array of TransactionOrder. This parameter is optional.
     
     */
    public init(amount: String, currency: CurrencyTypes, reference: String, transactionOrder: [TransactionOrder]? = nil){
        
        self.amount             = amount
        self.currency           = currency
        self.reference          = reference
        self.transactionOrder   = transactionOrder
    }
    
    /**
     This class will initialise purchased product details here related to the product.
     */
    public struct TransactionOrder: Encodable{
        
        let itemName: String
        let itemCode: String
        let quantity: Int
        let unitPrice: Float
        
        /**
         You can insert the purchased product details here related to the product.
         
         
         - parameter itemName: itemName should be string. Spaces are not allowed.
         - parameter itemCode: itemCode should be string. Spaces are not allowed.
         - parameter quantity: quantity should be int.
         - parameter unitPrice: unitPrice should be float.
         
         */
        public init(itemName: String, itemCode: String, qty: Int, unitPrice: Float){
            
            self.itemName          = itemName
            self.itemCode          = itemCode
            self.quantity          = qty
            self.unitPrice         = unitPrice
        }
    }
}

/**
 This enum will provide a currency type for a particular transaction. For example, you may need this when you build product details in a transaction.
 */
public enum CurrencyTypes: String{
    case LKR  =  "LKR"
    case USD  =  "USD"
}

/**
 This class will build SDK configuration for one transaction.
 */
public class IPGInitBuilder{
    
    private(set) var user: Customer? = nil
    private(set) var security: Configurations? = nil
    private(set) var product: Product? = nil
    
    public init(){}
    
    /**
     This method will set product purchased customer details.
     */
    public func setUser(_ user: Customer) {
        
        self.user = user
    }
    
    /**
     This method will set SDK configurations.
     */
    public func setConfigurations(_ secDetails: Configurations) {
        
        self.security = secDetails
    }
    
    /**
     This method will set purchased product details.
     */
    public func setProduct(_ productDetails: Product) {
        
        self.product = productDetails
    }
    
    
    /**
     This method will validate and build payment gateway requirements and return OnepayIPGInit.
     
     - returns: OnepayIPGInit
     
     */
    
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
            
            if product.amount.isEmpty{
                
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


