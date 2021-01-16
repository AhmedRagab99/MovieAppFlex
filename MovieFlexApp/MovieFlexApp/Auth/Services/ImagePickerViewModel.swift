//
//  ImagePickerViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 16/01/2021.
//

import SwiftUI
import Combine
import FirebaseAuth




final class ImagePickerViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var isPresentingImagePicker = false
    @Published var downloadedUrl:String = ""
    private(set) var sourceType: ImagePicker.SourceType = .photoLibrary
    private var storageServices:StorageServicesProtocol
    private var userService:UserServicesProtocol
    private var cancellabels = Set<AnyCancellable>()
    
    
    
    init(storageServices:StorageServicesProtocol = StorageServices(),userService:UserServicesProtocol = UserService()) {
        self.storageServices = storageServices
        self.userService = userService
    }
    func choosePhoto() {
        sourceType = .photoLibrary
        isPresentingImagePicker = true
    }
    func takePhoto() {
        sourceType = .camera
        isPresentingImagePicker = true
    }
    func didSelectImage(_ image: UIImage?) {
        selectedImage = image
        
        self.uploadImage(path: Auth.auth().currentUser?.uid ?? "").sink { (res) in
            switch res{
            case .finished:
                print("Finished")
            case let .failure(error):
                print(error.localizedDescription)
            }
        } receiveValue: { (val) in
            print(val)
            
            
            self.downloadUrl(path:Auth.auth().currentUser?.uid ?? "")
                .sink { (res) in
                    switch res{
                    case .finished:
                        print("Finished")
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { (value) in
                    self.downloadedUrl = value.description
                    print(self.downloadedUrl)
                    
                    self.isPresentingImagePicker = false

                }
                .store(in: &self.cancellabels)
            
        }.store(in: &cancellabels)
        
   
       
    }
    
    private func uploadImage(path:String)->AnyPublisher<String,Error>{
        return self.storageServices.putData((selectedImage?.jpegData(compressionQuality: 0.5)!)!, refPath: "/users/image_\(path)")
    }
    private func downloadUrl(path:String) -> AnyPublisher<URL,Error>{
        return self.storageServices.downloadUrl(refPath: "/users/image_\(path)")
    }
}
