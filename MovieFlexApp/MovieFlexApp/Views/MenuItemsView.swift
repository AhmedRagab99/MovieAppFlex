//
//  MenuItemsView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 10/25/20.
//

import SwiftUI

struct MenuItemsView: View {
    
    var body: some View {
        GeometryReader { reader in
            VStack{
                
                VStack {
                    HStack {
                       Spacer()
                        Image("test")
                            .resizable()
                            .clipShape(Circle(), style: FillStyle())
                            .frame(width: 60, height: 60)
                        Spacer()
                    }
                }
            }
            
        }
    }
}

struct MenuItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemsView()
    }
}
