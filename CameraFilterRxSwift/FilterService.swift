//
//  FilterService.swift
//  CameraFilterRxSwift
//
//  Created by Decagon on 06/08/2021.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            
            self.applyFilter(to: inputImage) { filterdImage in
                observer.onNext(filterdImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> Void)) {
        
        guard let sepiaFilter = CIFilter(name: "CISepiaTone") else {return}
        sepiaFilter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            
            sepiaFilter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            guard let outputImage = sepiaFilter.outputImage else {return}
            
            if let cgImg = self.context.createCGImage(outputImage, from: outputImage.extent) {
                let processedImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
        
    }
}
