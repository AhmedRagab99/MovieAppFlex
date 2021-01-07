//
//  AllTVShowsViewModel.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/23/20.
//

import Foundation
import Combine
import Alamofire

class AllTVShowsViewModel:ObservableObject{
    
    private var disposeBag = Set<AnyCancellable>()
    @Published var isLoading = CurrentValueSubject<Bool,Never>(true)
    @Published var isError = CurrentValueSubject<Bool,Never>(false)
    @Published var error = ""
    @Published var genreModel = [Genre]()
    @Published var popularTVShows = [TvShows]()
    @Published var topRatedTVShows = [TvShows]()
    
    
    func fetchPopularTvShows(page:Int  = 1){
        AllTVShowsApi.shared.getPopularTVShows(page: page)
            .sink { (result) in
                switch result{
                case .finished:
                    print("finished")
                case .failure(let error):
                    self.isLoading.value = false
                    print(error.localizedDescription)
                    self.error = error.localizedDescription
                    self.isError.value = true
                }
            } receiveValue: { (tvData) in
                self.isLoading.value = false
                self.popularTVShows = tvData.results ?? [TvShows]()
            }
            .store(in: &disposeBag)
    }
    
    
    func fetchTopRatedTVShows(page:Int = 1){
        AllTVShowsApi.shared.getTopRatedTVShows(page: page).sink { (result) in
            switch result{
            case .finished:
                print("finished")
            case .failure(let error):
                self.isLoading.value = false
                print(error.localizedDescription)
                self.error = error.localizedDescription
                self.isError.value = true
                
            }
        } receiveValue: { (tvData) in
            self.isLoading.value = false
            self.topRatedTVShows = tvData.results ?? [TvShows]()
        }
        .store(in: &disposeBag)

    }

    func fetchTVGenre(){
        guard let url  = URL(string: "\(constants.BASEURL)/genre/tv/list") else {return}
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
}
