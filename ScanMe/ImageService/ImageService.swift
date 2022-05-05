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
        let imageSource = AppSettings.instance.imageSource
        
        switch imageSource {
        case .fileSystem:
            return FileSystemService().getImage()
        case .camera:
            return CameraService().getImage()
        case .cameraRoll:
            return CameraRollService().getImage()
        }
        
    }
}
