//
//  SelectDestinationLocationView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 1/2/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

struct SelectDestinationLocationView:View{
    @Binding var isShowing:Bool
    @EnvironmentObject var directionEnv:DirectioinsEnviroment
    @State var searchQuery = ""
   
    @ObservedObject var viewModel:MapSearchViewModel
    var body:some View{
        
        VStack(spacing:12){
            HStack(spacing:8) {
                Button(action:{self.isShowing = false}){
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                 
                }
                TextField("Destenation location ",text:$searchQuery)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).debounce(for: .milliseconds(500), scheduler: RunLoop.main), perform: { _ in
                        viewModel.performLocalSearch(queary: self.searchQuery)

                    })
                    .padding(.horizontal,16)
                    .padding(.vertical,10)
                    .background(Color(UIColor.systemGray2))
                    .shadow(radius: 5)
                    .cornerRadius(5)
            }
            
            if viewModel.mapItems.count > 0{
                ScrollView{
                    ForEach(viewModel.mapItems,id:\.self){item in
                        
                        Button(action:{
                            self.directionEnv.destinationMapItem = item
                            self.isShowing = false
                        }){
                        HStack{
                            VStack(alignment:.leading){
                                Text("\(item.name ?? "")")
                                    .font(.headline)
                                Text("\(item.address())")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                        .foregroundColor(Color.primary)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
