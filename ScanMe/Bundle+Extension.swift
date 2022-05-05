//
//  Bundle+Extension.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import Foundation

extension Bundle {
    static func stringValue(forkey key: String) -> String {
        return dictionary[key] as? String ?? ""
    }
    
    private static var dictionary: [String: Any] {
        return Bundle.main.infoDictionary ?? [String: Any]()
    }
}
