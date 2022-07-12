//
//  OnepayIPGDelegate.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-06-03.
//

import Foundation

public protocol OnepayIPGDelegate: Any{
    
    func onPaymentSuccess(response: OnepayIPGSuccess)
    func onPaymentFailed(error: OnepayIPGError)
}
