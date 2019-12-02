//
//  Details.swift
//  Matrix
//
//  Created by Siddhant Nigam on 03/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import Foundation

struct Details: Codable {
    let emailId: String?
    let lastName: String?
    let imageUrl: String?
    let firstName: String?
}

struct Items: Codable {
    let items: [Details]
}


struct RequestParams: Codable {
    let emailId: String
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
