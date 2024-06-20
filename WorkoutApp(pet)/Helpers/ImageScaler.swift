//
//  ImageScaler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 13.05.2024.
//

import Foundation
import UIKit

final class ImageScaler {
    static func scaleImage(_ image: UIImage, toFit size: CGSize) -> UIImage {
            let aspectRatio = image.size.width / image.size.height
            var scaledSize = size
            
            if aspectRatio > 1 {
                scaledSize.height = size.width / aspectRatio
            } else {
                scaledSize.width = size.height * aspectRatio
            }
            
            UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: scaledSize))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return scaledImage ?? image
        }
}
