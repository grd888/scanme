//
//  AppSettings.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import Foundation

enum ImageSource: String {
    case fileSystem
    case camera
    case cameraRoll
}

enum Theme: String {
    case red
    case green
    
    var primaryColor: String {
        switch self {
        case .red:
            return "F22B29"
        case .green:
            return "0C7C59"
        }
    }
}

class AppSettings {
    static var instance = AppSettings()
    
    private init() {}
    
    var theme: Theme = .green
    var imageSource: ImageSource = .camera
    
}
