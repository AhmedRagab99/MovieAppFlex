//
//  SignInView.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 08/01/2021.
//

import SwiftUI
import Combine
import FirebaseAuth

struct SignUpView: View {
    @StateObject var viewModel = UserViewModel(mode: .signUp)
    @State var cancel = Set<AnyCancellable>()
    @State var color = Color.blue.opacity(0.7)
    @State var visible = false
    @State var revisible = false

    var body: some View {
        
            
            GeometryReader{ reader in
          
     
                ScrollView{
                VStack(alignment:.center,spacing:12) {
                    
                    if viewModel.isLoading.value{
                        ProgressView()
                    }
                    
                    Image("signup")
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
                    
                    
                    
                    HStack(spacing:15){
                        
                        VStack(){
                            
                            TextField("Your Name".uppercased(), text: $viewModel.nameText)
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
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(width: 200,height: 50)
                            .background(self.color)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                        
                    }
                    .disabled(!viewModel.isVallid)
                    .opacity(viewModel.isVallid ? 1 : 0.2)
                    
                    
                    
                    
                    
                    
                    
//                    VStack(alignment:.center){
//                        HStack(spacing:2){
//                            Spacer()
//                            Text("already have account?")
//                            Button(action: {
//
//                            } ){
//
////                                NavigationLink(destination: SignUpView(), isActive: $show){}
//                                Text("Sign In")
//                                    .font(.headline)
//                                    .foregroundColor(Color.blue.opacity(0.9))
//                                    .padding()
//                            }
//                            Spacer()
//                        }
//                    }
                    Spacer()
                    
                    
                }
                }
                .navigationTitle("Create an Account")
                
                
               
               
            }
        
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("ERROR"), message: Text(viewModel.errorText), dismissButton: .default(Text("OK!")))
            
        }
    }
        
    
}
//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}
