//
//  VisaMasterViewModel.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import UIKit


class VisaMasterViewModel{
    
    
    func validateData(initData: IPGInit, nameOnCard: String, cardNumber: String, cardType: CardType, isValidExpireDate: Bool, expDate: String, cvv: String, completion: (Result<_3DSRequestData, IPGError>) -> Void){
        
        if initData.token.isEmpty{
            
            completion(.failure(.invalidToken))
            return
        }
        
        if initData.firstName.isEmpty{
            
            completion(.failure(.fnameEmpty))
            return
        }
        
        if initData.lastName.isEmpty{
            
            completion(.failure(.lnameEmpty))
            return
        }
        
        if !initData.email.isValidEmail(){
            
            completion(.failure(.invalidEmaill))
            return
        }
        
        if !initData.phone.isAValidPhone(){
            
            completion(.failure(.invalidPhone))
            return
        }
        
        if initData.reference.isEmpty{
            
            completion(.failure(.referenceEmpty))
            return
        }
        
        if initData.appID.isEmpty{
            
            completion(.failure(.appIDEmpty))
            return
        }
        
        if initData.amount <= 0{
            
            completion(.failure(.zeroAmount))
            return
        }
        
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
        
        if let transOrder = initData.transactionOrder{
            
            transOrder.forEach{ transOrder in
                
                if transOrder.itemName.isEmpty || transOrder.itemCode.isEmpty{
                    
                    completion(.failure(.transOrderEmptyValues))
                    return
                }
            }
        }
       
        let splitedDate = expDate.components(separatedBy: "/")
        let month = splitedDate[0]
        let year  = splitedDate[1]
        
        let data = _3DSRequestData(appId: initData.appID,
                                   cardNumber: "5164020168735008",
                                   customerEmail: initData.email,
                                   reference: initData.reference,
                                   customerFirstName: initData.firstName,
                                   customerLastName: initData.lastName,
                                   customerPhoneNumber: initData.phone,
                                   cardMonth: "05",
                                   cardYear: "27",
                                   cardCvv: "200",
                                   cardName: "CHAMATH RATHNAYAKE",
                                   deviceId: UIDevice.current.identifierForVendor!.uuidString,
                                   deviceModel: UIDevice.current.model,
                                   deviceOs: "iOS",
                                   currency: initData.currency.rawValue,
                                   amount: initData.amount,
                                   transactionOrder: initData.transactionOrder)
        
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
