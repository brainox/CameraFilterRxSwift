//
//  ViewController.swift
//  CameraFilterRxSwift
//
//  Created by Decagon on 02/08/2021.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationNavController = segue.destination as? UINavigationController,
              let photoVC = destinationNavController.viewControllers.first as? PhotosCollectionViewController else {
            fatalError("Segue destination is not found")
        }
        
        photoVC.selectedPhoto
            .subscribe (onNext: { [weak self] photoImage in
                DispatchQueue.main.async {
                    self?.updateUI(photo: photoImage)
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    private func updateUI(photo: UIImage) {
        self.photoImageView.image = photo
        self.filterButton.isHidden = false
    }
    
}

