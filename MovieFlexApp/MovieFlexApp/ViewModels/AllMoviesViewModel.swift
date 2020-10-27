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
    @Published var discoverMovies = [Movie]()
    @Published var upComingMovies = [Movie]()
    @Published var movies = [Movie]()
    @Published var isLoading = CurrentValueSubject<Bool,Never>(true)
    var loadMore = PassthroughSubject<Bool,Never>()
    var isSearched = CurrentValueSubject<Bool,Never>(false)
    @Published var page = 1;
    @Published var   scroll_Tabs = ["Popular","TopRated","UPComing"]
     var  selected = CurrentValueSubject<String,Never>("discover")
    
    
    func filterMovies(quary:String,movies:[Movie])->[Movie]{
        return movies.filter{($0.title!.contains(quary) )}
    }
    
    func ChangeApiCall(page:Int = 1){
        selected.sink { (value) in
            print(value)
            switch value{
            case "Popular":
                self.discoverMovies = self.movies
                print("popular")
            default:
                print("discover")
                self.movies = self.discoverMovies
                
            }
        }
        .store(in: &disposeBag)
    }
    
    func getTopRatedMovies(page:Int){
        AllMovieApi.shared.getTopRatedMovies(page: page).sink { (completion) in
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
           
            self.movies = movies.results ?? [Movie]()
            
           
        }
        .store(in: &disposeBag)
    }
    
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
            self.discoverMovies.append(contentsOf: movies.results ?? [Movie]())
            self.discoverMovies.removeDuplicates()
            
           // print(self.discoverMovies.first?.title)
            
        }
        .store(in: &disposeBag)
    }
    
    
    func fetchUpComeingMovies(page:Int){
        AllMovieApi.shared.getUpcomingMovies(page: page).sink { (completion) in
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
            self.upComingMovies = movies.results ?? [Movie]()

        }
        .store(in: &disposeBag)
    }

    
    
}

