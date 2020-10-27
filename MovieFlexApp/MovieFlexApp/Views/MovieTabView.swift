//
//  MovieTabView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/26/20.
//

import SwiftUI

struct MovieTabView: View {
    var body: some View {
        TabView{
            NavigationView{
                ContentView()
                    .padding(.vertical)
                    .navigationTitle("Movies")
                    .navigationBarTitleDisplayMode(.large)
                                }
              .tabItem {
                Image(systemName: "heart.fill")
                    .imageScale(.large)
                Text("posts")
            }
            
            NavigationView{
                Text("ahmed ragab")
                    .navigationTitle("Search")
           
            
         
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                Text("search")
            }
        }
    }
}


struct MovieTabView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTabView()
    }
}
