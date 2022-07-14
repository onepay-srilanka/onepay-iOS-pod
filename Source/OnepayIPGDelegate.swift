//
//  OnepayIPGDelegate.swift
//  OnepayIPG
//
//  Created by onepay on 2022-06-03.
//

import Foundation

/**
 This delegate will be provided when the transaction completes callbacks.
 */
public protocol OnepayIPGDelegate: Any{
    
    /**
     This method will call whenever transaction success.
     */
    func onPaymentSuccess(response: OnepayIPGSuccess)
    
    /**
     This method will call whenever transaction success.
     */
    func onPaymentFailed(error: OnepayIPGError)
}
