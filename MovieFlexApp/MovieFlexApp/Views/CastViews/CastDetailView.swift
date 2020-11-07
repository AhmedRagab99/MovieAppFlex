//
//  CastDetailView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 11/7/20.
//

import SwiftUI
import KingfisherSwiftUI

struct CastDetailView: View {
    @StateObject var castViewModel = CastViewModel()
    let screenHiegt:CGFloat  =
        (UIScreen.screens.first?.bounds.height)!
    
    @State var isBlured = false
    @State var pickerSelection:Int = 0
    var castId:Int
    @Binding var isFullScreen:Bool
    @State private var viewState = CGSize.zero
    var body: some View {
        NavigationView {
            ZStack{
                // images view stack
                VStack(spacing:5){
                    ActorHeaderView(screenHiegt: screenHiegt, viewModel: castViewModel, isBlured: $isBlured)
                        .onTapGesture{
                            withAnimation(){
                                self.viewState = .zero
                                self.isBlured = false
                            }
                        }
                        .blur(radius: isBlured ? 10:0)
                    VStack(){
                        HStack {
                            Spacer()
                            Capsule(style: .circular)
                                .frame(width: 25, height: 10, alignment: .center)
                                .foregroundColor(Color.gray)
                                .padding([.bottom],4)
                            
                            Spacer()
                        }
                        .frame(height: 20)
                        .edgesIgnoringSafeArea(.all)
                        .gesture(
                            DragGesture().onChanged{ (value) in
                                self.viewState = value.translation
                                self.isBlured = true
                            }
                            .onEnded({ (value) in
                                //  if value.width == 0{}
                                if value.translation.height > -10{
                                    withAnimation(){
                                        self.viewState = .zero
                                        self.isBlured = false
                                        
                                    }
                                    
                                }
                                withAnimation(){
                                    self.viewState = value.translation
                                    self.isBlured = true
                                    
                                }
                                
                                //value.translation
                            })
                        )
                        .onTapGesture{
                            withAnimation(.spring()){
                                self.viewState = .zero
                                self.isBlured = false
                            }
                        }
                        
                        HStack {
                            PickerView(pickerSelection: $pickerSelection)
                        }
                        .padding(.bottom,8)
                        
                        
                       
                            if pickerSelection == 1 {
                                ScrollView {
                                    
                                    ActorWorkView(castViewModel: castViewModel)
                                        .padding()
                                }
                            }
                            else {
                                
                                CastPioView(castViewModel: castViewModel)
                            }
                            
                        
                        //.padding()
                        
                    }
                    .frame(maxWidth:.infinity,minHeight: viewState.height == 0 ? .none:screenHiegt - 30)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(25)
                    
                    .offset(y:viewState.height > 200 ?  200:viewState.height)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                }
                .edgesIgnoringSafeArea(.all)
                
                
            }
            .onAppear{
                castViewModel.getCastInfo(castId: castId)
                castViewModel.getCastWork(castId: castId)
            }
            .navigationBarItems(leading:   Image(systemName: "clear.fill")
                                    .imageScale(.large)
                                    .foregroundColor(Color.pink)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            self.isFullScreen.toggle()
                                        }
                                    })
        }
    }
}


