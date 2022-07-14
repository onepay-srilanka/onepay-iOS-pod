//
//  APIService.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-07-05.
//

import Foundation
import Alamofire


struct IPGAPI{
    
    static func get3DS(data: _3DSRequestData, completed: @escaping (Result<_3DS, APIErrors>) -> Void){
        
        let hashData = [
            "app_id": data.appId,
            "card_number": data.cardNumber,
            "customer_email": data.customerEmail,
            "reference": data.reference
        ]
        

        guard let hash = DataWrapper.shared.encryptSHA256(hashData) else { return completed(.failure(.encryptionError)) }
        
        let url =  "\(Constant.API_BASE_URL)api/ipg/sdk/mpgs-onetime-transaction/?hash=\(hash)"
        
        guard let bodyData = DataWrapper.shared.getJsonData(data) else { return completed(.failure(.jsonEncodeError)) }
        
        let request = BaseService.shared.generateRequest(url: url, method: .post, body: bodyData, contentType: .Json, isAuthorized: true)
        
        AF.request(request).validate().responseString {
            
            response in
            
            switch response.result {
                
            case .success:
                
                DataWrapper.shared.decodeData(data: response.data, modelClass: _3DS.self){result in
                    switch result {
                        
                    case .success(let response):
                        
                        completed(.success(response))
                        
                    case .failure(let error):
                        print(error)
                        completed(.failure(error))
                    }
                }
                
            case .failure(let error):
                
                print("error", error.localizedDescription)
                completed(.failure(.unableToComplete))
            }
        }
    }
}
