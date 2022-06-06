//
//  Constant.swift
//  onepay_merchant
//
//  Created by Spemai-Macbook on 7/1/20.
//  Copyright © 2020 Spemai-Macbook. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    //MARK: -  Server URL
    //    public static var API_BASE_URL =  ""
    static var API_BASE_URL =  ""
    static var RESOURCE_BASE_URL = "https://onepayserviceimages.s3.amazonaws.com/"
    
    //MARK:- Token Expire Time
    static var TOKEN_EXPIRE_TIME = 30
    
    //MARK: - Alerts Headers
    static let USER_INPUTS_VALIDATION_ERROR_MESSAGE_HEADER   = "Error"
    static let USER_INPUTS_VALIDATION_SUCCESS_MESSAGE_HEADER = "Success"
    static let REQUEST_PAYMENT_SUCCESS_HEADER                = "Payment Request"
    
    //MARK: - Logged User
    static var USER_BUSINESS_TYPE  = ""
    static var USER_FCM_TOKEN      = ""
    
    //MARK: - Regex
    static let PHONE_REGEX = "^(?:0)[0-9]{9,10}$"
    
    //MARK: - Common IDENTIFIERS
    static let MainGatewayVC            = "GatewayMainVC"
    static let MainStoryboard           = "OnepayIPG"
}
