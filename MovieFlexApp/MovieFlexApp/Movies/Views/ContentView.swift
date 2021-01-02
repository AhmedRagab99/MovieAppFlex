//
//  ContentView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/16/20.
//

import SwiftUI
import Alamofire
import KingfisherSwiftUI
import Combine
struct ContentView: View {
    
    @StateObject var  viewModel = AllMoviesViewModel()
    @State  var selectorIndex = 0
    @State  var numbers = ["One","Two","Three","four","five","six","seven","nine"]
    @State var index = "Home"
    let width = UIScreen.screens.first?.bounds.width ?? 0
    let height = UIScreen.screens.first?.bounds.height ?? 0
    var body: some View {
        
       
       
            VStack {
                ScrollView{
                        
                    PopularView(movies: viewModel.discoverMovies, loading: viewModel.isLoading.value,width: 130, viewModel: viewModel, title: "Discover",heigth: 275)
                            .padding()
                            
            
                        
                    PopularView(movies: viewModel.movies, loading: viewModel.isLoading.value,width: 130, viewModel: viewModel, title: "TopRated",heigth: 275)
                            .padding()
                          
                        
                        
                    GridView(movies: viewModel.upComingMovies,title:"Upcoming", loading: viewModel.isLoading.value, viewModel: viewModel)
                            .padding()
                    
                        
              
            }
                .onAppear{
                    viewModel.fetchUpComeingMovies(page: viewModel.page == 1 ? viewModel.page : 1)
                    viewModel.getTopRatedMovies(page: viewModel.page == 1 ? viewModel.page : 1)
                    viewModel.fetchDiscoverMovies(page: viewModel.page == 1 ? viewModel.page : 1)
                }
        }
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct SegmentControlView: View {
    @Binding  var selectorIndex:Int
    @Binding  var numbers :[String]
    var body: some View {
        VStack {
            // 2
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0 ..< numbers.count) { index in
                    Text(self.numbers[index]).tag(index)
                        .background(Color.secondary)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}
