//
//  SignInView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 08/01/2021.
//

import SwiftUI
import Combine
import FirebaseAuth

struct SignInView: View {
    @StateObject var viewModel = UserViewModel(mode: .linkAnonmasyley)
    @State var cancel = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            
            
            
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                TextField("Your Email".uppercased(), text: $viewModel.emailText)
                    .keyboardType(.emailAddress)
                    .font(.subheadline)
                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                    .frame(height: 44)
                    .onTapGesture {
                        
                    }
            }
            
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                SecureField("Password".uppercased(), text: $viewModel.passwordText)
                    .keyboardType(.default)
                    .font(.subheadline)
                    
                    .padding(.leading)
                    .frame(height: 44)
                
            }
            
            
            Button(action:{
                viewModel.getCurrentUserId()
                    .sink { (_) in
                        print("asdasd")
                    } receiveValue: { (val) in
                        print(val)
                    }
                    .store(in: &cancel)

            }){
                Text("SignIn Anon")
            }
            
            Button(action:{
               viewModel.tappedActionMode()
            }){
                Text("SignIn here")
            }
        }
        
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
