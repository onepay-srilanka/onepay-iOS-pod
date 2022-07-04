//
//  IPGErrors.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation
import UIKit

enum IPGError: String, Error{
    
    case initError = "IPG init data not found"
    case referenceEmpty = "Reference could not be found in Init data"
    case appIDEmpty  = "App Id could not be found in Init data"
    case fnameEmpty = "First name in Init data cannot be empty"
    case lnameEmpty = "Last name in Init data cannot be empty"
    case zeroAmount = "Amount should be greater than 0.00"
    case invalidEmaill = "Your provided email isn't invalid. please re-check the email in Init data"
    case invalidPhone = "Your provided phone number isn't invalid. please re-check the phone number in Init data"
    case emptyName = "Name on card cannot be empty"
    case invalidCardNumber = "Invalid card number"
    case invalidExpireDate = "Invalid expire date"
    case invalidCVV = "invalid CVV"
}
