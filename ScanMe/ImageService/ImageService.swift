//
//  ImageService.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import UIKit
import Combine

class ImageService: ImageGetter {
    func getImage() -> Future<UIImage, ImageGetterError> {
        return Future { promise in
            if let image = UIImage(systemName: "pin") {
                promise(.success(image))
            } else {
                promise(.failure(.fetchError))
            }
        }
    }
}
