//
//  BaseService.swift
//  onepay_merchant
//
//  Created by Spemai-Macbook on 2021-11-16.
//  Copyright © 2021 Spemai-Macbook. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
    
    static let shared = BaseService()
    
    private var request = URLRequest(url: URL(string: Constant.API_BASE_URL)!)
    
    private init() { }
    
    public func generateRequest(url: String, method: HTTPMethod, body: Data?, contentType: ContentType?, isAuthorized: Bool) -> URLRequest {
        
        guard let formateUrl = URL(string: url) else {
            fatalError("Invalid URL")
        }
        
        request.url          = formateUrl
        request.httpMethod   = method.rawValue
        
        switch contentType {
        case .Json:
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        case .PlainText:
            request.httpBody = body
            request.setValue("text/plain; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
        case .none:
            request.httpBody = nil
            break
        }
        
        if isAuthorized {
            
            if let token = Constant.token {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }

        }
    
        return request
    }
}

enum ContentType {
    case Json
    case PlainText
}
