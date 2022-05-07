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
    
    private static let COLOR_THEME = "COLOR_THEME"
    private static let IMAGE_SOURCE = "IMAGE_SOURCE"
    var theme: Theme = Theme(rawValue: Bundle.stringValue(forkey: COLOR_THEME)) ?? .red
    
    var imageSource: ImageSource = ImageSource(rawValue: Bundle.stringValue(forkey: IMAGE_SOURCE)) ?? .cameraRoll
    
}
