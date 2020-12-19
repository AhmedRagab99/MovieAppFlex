//
//  CastViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/7/20.
//

import Foundation

import Combine


class CastViewModel:ObservableObject{
    
    @Published var castInfo :ActorDetail?
    @Published var ActorWork = [Work]()
    @Published var isLoading = CurrentValueSubject<Bool,Never>(true)
    private var disposeBag = Set<AnyCancellable>()
    
    
    func getCastWork(castId:Int){
        CastApi.shared.getActorWork(castId: castId)
            .sink { (result) in
                self.isLoading.value = false
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finshed")
                }
            } receiveValue: { (actorInfo) in
                self.isLoading.value = false
                self.ActorWork = actorInfo.cast ?? [Work]()
            }
            .store(in: &disposeBag)

    }
    
    
    
    func getCastInfo(castId:Int){
        CastApi.shared.getActorDetail(castId: castId)
            .sink { (result) in
                self.isLoading.value = false
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finshed")
                }
            } receiveValue: { (actorInfo) in
                self.isLoading.value = false
                self.castInfo = actorInfo
            }
            .store(in: &disposeBag)

    }
    
    
    
}
