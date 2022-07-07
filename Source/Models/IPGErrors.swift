//
//  IPGErrors.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

enum IPGError: String, Error{
    
    case invalidToken = "You arn't authorized for this service"
    case hashKeyError = "hash key not found"
    case initError = "IPG init data not found"
    case referenceEmpty = "Reference could not be found in Init data. please check the mandatory fields"
    case appIDEmpty  = "App Id could not be found in Init data. please check the mandatory fields"
    case fnameEmpty = "First name in Init data cannot be empty. please check the mandatory fields"
    case lnameEmpty = "Last name in Init data cannot be empty. please check the mandatory fields"
    case zeroAmount = "Amount should be greater than 0.00"
    case invalidEmaill = "Your provided email isn't invalid. please re-check the email in Init data"
    case invalidPhone = "Your provided phone number isn't invalid. please re-check the phone number in Init data"
    case emptyName = "Name on card cannot be empty"
    case invalidCardNumber = "Invalid card number"
    case invalidExpireDate = "Invalid expire date"
    case invalidCVV = "invalid CVV"
    case transOrderEmptyValues = "Transaction Order must not contains empty values. check your transation order details and retry"
    
}

enum ApiErrors: String, Error{
    
    case encryptionError  = "Unable to encrypt to json"
    case invalidResponse  = "Invalid response from server. Please try again."
    case unableToComplete = "Unable to complete your request. Something went wrong."
}
