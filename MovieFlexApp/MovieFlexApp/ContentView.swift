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
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear{
                SearchApi.shared.multiSearch(query: "Tom hanks").sink { (result) in
                    switch result{
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { (data) in
               
                    print( data.results)
                }
                .store(in: &cancells)

            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
