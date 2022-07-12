//
//  3DSRequestData.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-07-06.
//

import Foundation

struct _3DSRequestData: Encodable{
    
    let appId: String
    let cardNumber: String
    let customerEmail: String
    let reference: String
    let customerFirstName: String
    let customerLastName: String
    let customerPhoneNumber: String
    let cardMonth: String
    let cardYear: String
    let cardCvv: String
    let cardName: String
    let deviceId: String
    let deviceModel: String
    let deviceOs: String
    let currency: String
    let amount: String
    let transactionOrder: [Product.TransactionOrder]?
}

struct _3DS: Decodable{
    
    let status: Int
    let message: String
    let data: _3DSData?
}

struct _3DSData: Decodable{
    
    let tdsAuthenticationRedirect: String
    let onepayTransactionId: String
}
