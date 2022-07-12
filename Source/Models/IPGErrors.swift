//
//  IPGErrors.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

enum IPGError: String, Error{
    
    case invalidToken = "token not found"
    case hashKeyError = "hash key not found"
    case initError = "IPG init data not found"
    case referenceEmpty = "reference id not found"
    case appIDEmpty  = "app id not found"
    case fnameEmpty = "first name not found"
    case lnameEmpty = "last name not found"
    case zeroAmount = "not a valid amount"
    case invalidEmaill = "invalid email"
    case invalidPhone = "invalid phone"
    case emptyName = "Name on card cannot be empty"
    case invalidCardNumber = "Invalid card number"
    case invalidExpireDate = "Invalid expire date"
    case invalidCVV = "invalid CVV"
    case transOrderEmptyValues = "transaction Order contains inavalid values"
    
}

enum ApiErrors: String, Error{
    
    case encryptionError  = "Unable to encrypt to json"
    case jsonEncodeError  = "unable to encode the data"
    case invalidJson      = "Invalid Json"
    case invalidResponse  = "Invalid response from server. Please try again."
    case unableToComplete = "Unable to complete your request. Something went wrong."
}
