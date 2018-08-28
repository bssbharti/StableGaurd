//
//  CodableMadel.swift
//  JSONCodable
//
//  Created by Jitendra Kumar on 15/02/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit


extension Mappable {
    
    public func JKEncoder() -> Data? {
        return JSN.JSNEncoder(self)
    }
}

extension Data{
    
    func JKDecoder<T>(_ type:T.Type) ->T? where T:Decodable{
        return JSN.JSNDecoder(T.self, from: self)
    }
    
}
struct JSN{
    static func JSNDecoder<T>(_ type:T.Type,from data:Data)  ->T? where T:Decodable{
        let decoder  = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let obj  = try? decoder.decode(T.self, from: data)
        return obj
    }
    static func JSNEncoder<T>(_ value: T)  -> Data? where T : Encodable{
        let encodeData  = try? JSONEncoder().encode(value)
        return encodeData
    }
}



public protocol Mappable: Codable {
    func JKEncoder() -> Data?
    
}
