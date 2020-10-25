//
//  SlideMenuView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/25/20.
//

import SwiftUI

struct SlideMenuView: View {
    @State private var  showMenu = false
    var body: some View {
        ZStack{
            MenuItemsView()
                .background(Color.clear.opacity(0.1))
            ZStack{
                ContentView()
                    .onTapGesture{
                        if self.showMenu == true{self.showMenu.toggle()}
                    }
                VStack{
                    HStack{
                        Button(action:{self.showMenu.toggle()}){
                        Image(systemName: "heart.fill")
                            .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .scaleEffect(showMenu ? 0.9:1)
            .offset(x: showMenu ? 200 : 0)
            .animation(.easeInOut(duration: 0.1))
            .shadow(radius: 4)
        }
    }
}

struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView()
    }
}
