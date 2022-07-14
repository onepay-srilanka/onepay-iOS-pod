//
//  IPGErrors.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

enum IPGError: String, Error{
    
    case invalidToken = "Token not found"
    case hashKeyError = "Hash key not found"
    case initError = "IPG init data not found"
    case referenceEmpty = "Reference id not found"
    case appIDEmpty  = "App id not found"
    case fnameEmpty = "First name not found"
    case lnameEmpty = "Last name not found"
    case zeroAmount = "Invalid amount"
    case invalidLKRAmount = "LKR minimum amount should be LKR 100"
    case invalidUSDAmount = "LKR minimum amount should be USD 1"
    case invalidEmail = "Invalid email"
    case invalidPhone = "Invalid phone"
    case emptyName = "Name on card cannot be empty"
    case invalidCardNumber = "Invalid card number"
    case invalidExpireDate = "Invalid expire date"
    case invalidCVV = "Invalid CVV"
    case transOrderEmptyValues = "Transaction order contains invalid values"
    
}

enum APIErrors: String, Error{
    
    case encryptionError  = "Unable to encrypt to json"
    case jsonEncodeError  = "unable to encode the data"
    case invalidJson      = "Invalid Json"
    case invalidResponse  = "Invalid response from server. Please try again."
    case unableToComplete = "Unable to complete your request. Something went wrong."
}
