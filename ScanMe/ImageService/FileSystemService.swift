//
//  FileSystemService.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import UIKit
import Combine

class FileSystemService: ImageGetter {
    func getImage() -> Future<UIImage, ImageGetterError> {
        return Future { promise in
            if let image = UIImage(systemName: "file") {
                promise(.success(image))
            } else {
                promise(.failure(.fetchError))
            }
        }
    }
}
