//
//  ImageGetter.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import Foundation
import Combine
import UIKit

enum ImageGetterError: Error {
    case fetchError
}
protocol ImageGetter {
    func getImage() -> Future<UIImage, ImageGetterError>
}
