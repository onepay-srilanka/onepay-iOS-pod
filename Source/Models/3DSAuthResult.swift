//
//  3DSAuthResult.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-07-08.
//

import Foundation

public struct OnepayIPGSuccess{
    
    public let status: Int
    public let description: String
    public let firstName: String
    public let lastName: String
    public let phone: String
    public let reference: String
    public let email: String
    public let amount: String
    public let currency: String
}

public struct OnepayIPGError{
    
    public let responseCode: Int?
    public let description: String?
}
