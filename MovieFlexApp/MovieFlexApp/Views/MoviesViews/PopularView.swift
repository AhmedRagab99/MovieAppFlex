//
//  PopularView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/25/20.
//

import SwiftUI
struct PopularView: View {
    var movies:[Movie]
    var loading:Bool
    var width:CGFloat
    @ObservedObject var viewModel:AllMoviesViewModel
    @State var title:String
    @State var movie:Movie?
    @State private var showDiscover = false
    @State private var showTopRated = false
    @State private var show = false
  

    var heigth:CGFloat
    var body: some View {
 
        VStack {
    
            if loading{
                ProgressView().frame(width: 200, height: 200, alignment: .center)
            }
           
            HStack{
                Text(title)
                    .font(.title)
                Spacer()
                Button(action: {
                    if title == "Discover"{self.showDiscover.toggle()}
                    else {self.showTopRated.toggle()}
                    
                }) {
                    NavigationLink(destination: ShowMoreMoviesView(movies: movies, viewModel: viewModel, title: "Discover")) {
                                      
                    Text("More...")
                        .font(.headline)
                }
                }
            }
        
            ScrollView(.horizontal,showsIndicators:false) {
                HStack(spacing:2) {
                    ForEach(movies,id:\.id){ m in
                        GeometryReader{ reader in
                            PopularCard(movie:m)
                                .onTapGesture(perform: {
                                    withAnimation{
                                        self.show.toggle()
                                        self.movie = m
                                     //   self.selectedMovie = m
                                    }
                                    
                                })
                          
                                .rotation3DEffect(
                                    Angle(degrees: Double(reader.frame(in: .global).minX - 30) / -20),
                                    axis: (x: 0, y: 10, z: 10)
                                )
                                .padding(.horizontal)
                              
                            
                        }
                        .frame(width: width, height: heigth)
                        
                        .fullScreenCover(isPresented: $show) {
                            
                            MovieDetailView(isFullScreen: $show, movie: movie ?? movies.first!)
                                .transition(.opacity)
                                }
                    }
                    
                }
                .padding(.top)
            }
            .listRowInsets(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
        }
          
    }
    }

