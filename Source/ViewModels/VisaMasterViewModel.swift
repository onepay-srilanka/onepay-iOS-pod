//
//  VisaMasterViewModel.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import UIKit


class VisaMasterViewModel{
    
    
    func validateData(initData: OnepayIPGInit, nameOnCard: String, cardNumber: String, cardType: CardType, isValidExpireDate: Bool, expDate: String, cvv: String, completion: (Result<_3DSRequestData, IPGError>) -> Void){
        
        if nameOnCard.isEmpty{
            
            completion(.failure(.emptyName))
            return
        }
        
        if (cardType != .Visa && cardType != .MasterCard){
            
            completion(.failure(.invalidCardNumber))
        }
        
        if cvv.count != 3{
            
            completion(.failure(.invalidCVV))
            return
        }
        
        if !isValidExpireDate{
            
            completion(.failure(.invalidExpireDate))
            return
        }
        
    
        let splitedDate = expDate.components(separatedBy: "/")
        let month = splitedDate[0]
        let year  = splitedDate[1]
        
        let data = _3DSRequestData(appId: initData.secDetails.appID,
                                   cardNumber: "5164020168735008",
                                   customerEmail: initData.userDetails.email,
                                   reference: initData.userDetails.reference,
                                   customerFirstName: initData.userDetails.firstName,
                                   customerLastName: initData.userDetails.lastName,
                                   customerPhoneNumber: initData.userDetails.phone,
                                   cardMonth: "05",
                                   cardYear: "27",
                                   cardCvv: "200",
                                   cardName: "CHAMATH RATHNAYAKE",
                                   deviceId: UIDevice.current.identifierForVendor!.uuidString,
                                   deviceModel: UIDevice.current.model,
                                   deviceOs: "iOS",
                                   currency: initData.proDetails.currency.rawValue,
                                   amount: initData.proDetails.amount,
                                   transactionOrder: initData.proDetails.transactionOrder)
        
        completion(.success(data))
    }
    
    func validateAndGet3DS(reqData: _3DSRequestData, completion: @escaping (Result<_3DS, ApiErrors>) -> Void){
        
        IPGAPI.get3DS(data: reqData){ result in
            
            switch result{
                
            case .success(let response):
                
                completion(.success(response))
                
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
}
