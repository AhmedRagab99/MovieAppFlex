//
//  MovieViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import Foundation
import Combine



class MovieViewModle:ObservableObject{
    var disposeBag = Set<AnyCancellable>()
    @Published var isLoading = CurrentValueSubject<Bool,Never>(true)
    @Published var cast = [Cast]()
    @Published var similarMovies = [Movie]()
    
    
    func getMovieCast(movieId:Int){
        MovieApi.shared.getMovieCast(movieId: movieId).sink { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("finshed")
            }
        } receiveValue: { (castData) in
            self.isLoading.value = false
            self.cast = castData.cast ?? [Cast]()
        }
        .store(in: &disposeBag)
    }
    
    func getSimilarMovies(movieId:Int){
        MovieApi.shared.getSimilarMovie(movieId: movieId).sink { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("finshed")
            }
        } receiveValue: { (movies) in
            self.isLoading.value = false
            self.similarMovies = movies.results ?? [Movie]()
        }
        .store(in: &disposeBag)

    }
    
}
