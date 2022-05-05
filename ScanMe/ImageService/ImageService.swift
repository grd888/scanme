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
        return CameraRollService().getImage()
    }
}
