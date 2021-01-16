//
//  ImagePicker.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 15/01/2021.
//

import SwiftUI
import FirebaseStorage

struct ImagePicker:UIViewControllerRepresentable {
    
    
    typealias UIViewControllerType = UIImagePickerController
    typealias SourceType = UIImagePickerController.SourceType
    
    
    let sourceType:SourceType
    let completionHandler:(UIImage?)->Void
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = sourceType
        imagePickerVC.delegate = context.coordinator
        imagePickerVC.allowsEditing = true
//        imagePickerVC.videoQuality = .typeMedium
        return imagePickerVC
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let completionHandler: (UIImage?) -> Void
        
        init(completionHandler: @escaping (UIImage?) -> Void) {
            self.completionHandler = completionHandler
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image: UIImage? = {
                if let image = info[.editedImage] as? UIImage {
                    return image
                }
                return info[.originalImage] as? UIImage
            }()
            
            
    
            completionHandler(image)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completionHandler(nil)
        }
    }
}



