//
//  MovieViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/2/20.
//

import Foundation
import Combine
import Alamofire


class MovieViewModle:ObservableObject{
    private var disposeBag = Set<AnyCancellable>()
    @Published var isLoading = CurrentValueSubject<Bool,Never>(true)
    @Published var isError = CurrentValueSubject<Bool,Never>(false)
    @Published var error = ""
    @Published var cast = [Cast]()
    @Published var similarMovies = [Movie]()
    @Published var genreModel = [Genre]()
    
    
    func fetchMoviesGenre(){
        guard let url  = URL(string: "\(constants.BASEURL)/genre/movie/list") else {return}
        let decoder = JSONDecoder()
        AF.request(url)
                    .validate()
                    .publishDecodable(type:[Genre].self,decoder: decoder)
            .sink { (result) in
                switch  result{
                case .finished:
                    print("finshed")
                case .failure(let error):
                    self.isLoading.value = false
                    self.error = error.localizedDescription
                    self.isError.value = true
                    
                }
            } receiveValue: { (data) in
                self.genreModel = data.value ?? [Genre]()
                self.isLoading.value = false
            }
            .store(in: &disposeBag)

            
    }
    func getMovieCast(movieId:Int){
        MovieApi.shared.getMovieCast(movieId: movieId).sink { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading.value = false
                self.error = error.localizedDescription
                self.isError.value = true
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
                self.error = error.localizedDescription
                self.isError.value = true
                self.isLoading.value = false
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
