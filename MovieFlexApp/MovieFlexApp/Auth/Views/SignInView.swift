//
//  SignInView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 07/01/2021.
//

import SwiftUI
import Combine
import FirebaseAuth


struct SignInView: View {
    @StateObject var viewModel = UserViewModel(mode: .signIn)
    @State var cancel = Set<AnyCancellable>()
    @State var color = Color.blue.opacity(0.7)
    @State var visible = false
    @State var revisible = false
    @State var show:Bool = false
    var body: some View {
        NavigationView{
            
            GeometryReader{ reader in
            
                VStack(alignment:.center,spacing:16) {
                    
                    Image("auth")
                        .resizable()
                        .frame(width: reader.size.width * 0.7, height: reader.size.height * 0.4)
                    
                    
                    
                    HStack(spacing:15){
                        
                        VStack(){
                            
                            TextField("Your Email".uppercased(), text: $viewModel.emailText)
                                .keyboardType(.emailAddress)
                            
                        }
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(self.color)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).stroke(self.color,lineWidth: 3))
                    .padding()
                    
                    
                    
                    
                    
                    HStack(spacing: 15){
                        VStack{
                            
                            if self.visible{
                                
                                TextField("Password", text: $viewModel.passwordText)
                                    .autocapitalization(.none)
                            }
                            else{
                                
                                SecureField("Password", text: $viewModel.passwordText)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            
                            self.visible.toggle()
                            
                        }) {
                            
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                        
                    }
                    .padding()
                    
                    .background(RoundedRectangle(cornerRadius: 5).stroke(self.color,lineWidth: 3))
                    .padding()
                    
                    
                    Button(action: {
                        viewModel.tappedActionMode()
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(width: 200,height: 50)
                            .background(self.color)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                        
                    }
                    .disabled(!viewModel.isVallidLogIn)
                    .opacity(viewModel.isVallidLogIn ? 1 : 0.4)
                    
                    VStack(alignment:.center){
                        HStack(spacing:2){
                            Spacer()
                            Text("do not have an acount?")
                            Button(action: {
                           
                                self.show.toggle()
                            } ){
                                
                                NavigationLink(destination: SignUpView(), isActive: $show){}
                                Text("Sign Up")
                                    .font(.headline)
                                    .foregroundColor(Color.blue.opacity(0.9))
                                    .padding()
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    
                }
                .padding()
            
                .navigationTitle("Welcome back!")
                
               
               
            }
        }
   
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("ERROR"), message: Text(viewModel.errorText), dismissButton: .default(Text("OK!")))
            
        }
    }
}
//
//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView( )
//    }
//}
