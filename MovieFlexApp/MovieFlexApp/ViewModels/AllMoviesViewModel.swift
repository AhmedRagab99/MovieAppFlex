//
//  AllMoviesViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/24/20.
//

import Foundation
import Combine


class AllMoviesViewModel:ObservableObject{
    var disposeBag = Set<AnyCancellable>()
    @Published var movies = [Movie]()
    @Published var isLoading = CurrentValueSubject<Bool,Never>(true)
    var loadMore = PassthroughSubject<Bool,Never>()
    var isSearched = CurrentValueSubject<Bool,Never>(false)
    @Published var page = 1;
    
    func fetchDiscoverMovies(page:Int){
        AllMovieApi.shared.discoverMovies(page: page).sink { (completion) in
            switch completion {
            case .failure(let error):
                self.isLoading.value = false
                print(error.localizedDescription)
                
            case .finished:
                self.isLoading.value = false
                print("finshed")
            }
        } receiveValue: { (movies) in
            self.isLoading.value = false
            if self.movies.count > 20 {
                self.loadMore.send(false)
            }
            self.movies.append(contentsOf: movies.results ?? [Movie]())
        }
        .store(in: &disposeBag)
    }
    
    func isloadMore(){
       
        loadMore.sink { (value) in
            
            if value == true {
                print("fetch more")
                self.page = self.page + 1
                self.fetchDiscoverMovies(page: self.page)
            } else {
                print("here")
            }
        }
        .store(in: &disposeBag)
    }
    
    
}

