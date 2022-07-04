//
//  VisaMasterViewModel.swift
//  Alamofire
//
//  Created by amilla fernando on 2022-07-04.
//

import UIKit


class VisaMasterViewModel{
    
    
    func validateData(initData: IPGInit, nameOnCard: String, cardNumber: String, isValidExpireDate: Bool, cvv: String, completion: (Result<Bool, IPGError>) -> Void){
        
        
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
        
    
        
        if true  {
            
            // check valid card no
        }
        
        if !isValidExpireDate{
            
            completion(.failure(.invalidExpireDate))
            return
        }
        
        if cvv.count != 3{
            
            completion(.failure(.invalidCVV))
            return
        }
        
    }
}
