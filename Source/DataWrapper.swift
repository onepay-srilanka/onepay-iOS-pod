//
//  DataWrapper.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-07-06.
//

import Foundation
import CommonCrypto

class DataWrapper{
    
    static let shared = DataWrapper()
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    private init () {
        
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        jsonEncoder.outputFormatting = .sortedKeys
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func encryptSHA256<T: Encodable>(_ model: T) -> String? {
       
        do {
            
            let json = try jsonEncoder.encode(model)
            
            guard let jsonString  = json.toString() else { return nil }
            
            let finalStr = jsonString + Constant.hashKey!
            
            return sha256(data: Data(finalStr.utf8))
            
        } catch let (error){
            
            debugPrint(error)
            return nil
        }
    }
    
    func getJsonData<T: Encodable>(_ model: T) -> Data? {
       
        do {
            let json = try jsonEncoder.encode(model)
            
            guard let jsonString  = json.toString() else { return nil }
            
            return try jsonEncoder.encode(model)
            
        } catch let (error){
            
            debugPrint(error)
            return nil
        }
    }
    
    
    func decodeData<T: Decodable>(data: Data?, modelClass: T.Type, completed: @escaping (Result<T, APIErrors>)->Void)  {
        
        if let resultData = data{
        
            do {
                let result =  try jsonDecoder.decode(modelClass, from: resultData)
            
                completed(.success(result))
            } catch (let error){
                
                print(error)
                completed(.failure(.invalidJson))
            }
        } else {
            completed(.failure(.invalidResponse))
        }
    }
    
    private func sha256(data : Data) -> String {
        
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        let data = Data(hash)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
}
