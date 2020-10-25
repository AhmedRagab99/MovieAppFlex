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
    @State private var cancells = Set<AnyCancellable>()
    @StateObject var  viewModel = AllMoviesViewModel()
    @State  var selectorIndex = 0
    @State  var numbers = ["One","Two","Three"]
    @State var index = "Home"
    @State var show = false
    let width = UIScreen.screens.first?.bounds.width ?? 0
    let height = UIScreen.screens.first?.bounds.height ?? 0
    var body: some View {
        if viewModel.isLoading.value == true{
            ProgressView().frame(width: 200, height: 200, alignment: .center)
        }
        NavigationView {
            ScrollView{
                
                
                PopularView(movies: viewModel.movies,width: 130,heigth: 275)
                    .padding()
                
                
                PopularView(movies: viewModel.movies,width: 130,heigth: 275)
                    .padding()
                
                
                PopularView(movies: viewModel.movies,width: 130,heigth: 275)
                    .padding()
                
                
                
            }
            .onAppear {
                viewModel.fetchDiscoverMovies(page: 1)
            }
            .navigationBarTitle(viewModel.isLoading.value == false ? "MovieApp":"")
            
        }
        
    }
}


//        ForEach(viewModel.movies,id:\.id){ m in
//
//            PopularCard(movie:m)
//
//                .padding()
//        }

//
//        ScrollView(){
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200, maximum: height))],spacing:20){
//                ForEach(viewModel.movies,id:\.id){ m in
//
//                    PopularCard(movie:m)
//
//                        .padding()
//                }
//            }
//        }
//        .onAppear{viewModel.fetchDiscoverMovies(page: 3)}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//        GeometryReader{ reader in
//            ScrollView{
//                if viewModel.isLoading.value == true{
//                    VStack {
//                        HStack {
//                            Spacer()
//                            ProgressView().frame(width: 200, height: 200, alignment: .center)
//                        }}
//                }
//        if viewModel.movies.count > 0{
//
//            ForEach(viewModel.movies,id:\.id){ m in
//                Text(m.title ?? "")
//            }
//        }
//
//
//        }
//            .onAppear{reader.size.height > 200 ? viewModel.fetchDiscoverMovies(page: viewModel.page): viewModel.isloadMore()}
//        }
//    }
//
//    }

//
//        NavigationView {
//            List(1..<100) { i in
//                       Text("Row \(i)")
//                   }
//            .listStyle(SidebarCommands())
//        }
//        Menu("Options") {
//            Button("Order Now", action: {})
//            Button("Adjust Order", action: {})
//            Menu("Advanced") {
//                Button("Rename", action: {})
//                Button("Delay", action: {})
//            }
//            Button("Cancel", action: {})
//        }
//        Text("Hello, world!")
//            .padding()
//            .onAppear{
//                TVShowsApi.shared.getTVShowCast(TVShowId: 62560).sink { (result) in
//                    switch result{
//                    case .finished:
//                        print("finished")
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                } receiveValue: { (data) in
//
//                    print( data.cast)
//                }
//                .store(in: &cancells)
//
//            }



struct SegmentControlView: View {
    @Binding  var selectorIndex:Int
    @Binding  var numbers :[String]
    var body: some View {
        VStack {
            // 2
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0 ..< numbers.count) { index in
                    Text(self.numbers[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}
