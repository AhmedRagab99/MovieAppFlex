import SwiftUI
import FirebaseAuth
struct SlideMenuView: View {
    var body: some View {
        Home()
    }
}

struct TestMenuView_preview: PreviewProvider {
    static var previews: some View {
        SlideMenuView()
        
    }
}

struct Home : View {
    @State var viewModel = UserViewModel(mode: .signOut)
    @StateObject var imageViewModel = ImagePickerViewModel()
    @State var index = 0
    @State var show = false
    
    var body: some View{
        
        ZStack{
            
            // Menu...
            
            HStack{
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    // images gallery
                    VStack {
                        Image(uiImage:((imageViewModel.selectedImage != nil ? imageViewModel.selectedImage: UIImage(systemName:"heart.fill"))!) )
                            .resizable()
                            .frame(width:120,height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 5 )
                            .onTapGesture {
                                imageViewModel.choosePhoto()
                            }
                            
                        HStack{
                        Button(action:{
                            self.imageViewModel.takePhoto()
                        }){
                            Text("with camera")
                        }
                        
                        Button(action:{
                            self.imageViewModel.choosePhoto()
                        }){
                            Text("with gallery")
                        }
                        }
                        .padding()
//                    controlBar()
                        }
                        .fullScreenCover(isPresented: $imageViewModel.isPresentingImagePicker, content: {
                            ImagePicker(sourceType: imageViewModel.sourceType, completionHandler: imageViewModel.didSelectImage)
                        })
                    
                        
                    
                    Text("Hey")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.primary)
                        .padding(.top, 10)
                    
                    Text("Ahmed")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        
                        self.index = 0
                        
                        // animating Views...
                        
                        // Each Time Tab Is Clicked Menu Will be Closed...
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "house.fill")
                                .foregroundColor(self.index == 0 ? Color.blue.opacity(0.6) : Color.primary)
                            
                            
                            Text("Home")
                                .foregroundColor(self.index == 0 ? Color.blue.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color.blue.opacity(0.6) : Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding(.top,25)
                    
                    Button(action: {
                        
                        self.index = 1
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "map.fill")
                                .foregroundColor(self.index == 1 ? Color.blue.opacity(0.6): Color.primary)
                            
                            
                            Text("Map")
                                .foregroundColor(self.index == 1 ? Color.blue.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color.blue.opacity(0.6) : Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 2
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "magnifyingglass.circle.fill")
                                .foregroundColor(self.index == 2 ? Color.blue.opacity(0.6) : Color.primary)
                            
                            
                            Text("Search")
                                .foregroundColor(self.index == 2 ? Color.blue.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color.blue.opacity(0.6) : Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 3
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(self.index == 3 ? Color.blue.opacity(0.6) : Color.primary)
                            
                            
                            Text("Favorites")
                                .foregroundColor(self.index == 3 ? Color.blue.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color.blue.opacity(0.6) : Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.primary)
                        .padding(.vertical,30)
                    
                    Button(action: {
                        
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "clear.fill")
                             
                            
                            
                            Text("Sign Out")
                                .foregroundColor(Color.primary)
                                .onTapGesture {
                                    viewModel.tappedActionMode()
                                }
                        }
                        
                        .foregroundColor(Color.secondary.opacity(0.2))
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,25)
                .padding(.horizontal,20)
                
                Spacer(minLength: 0)
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            // MainView...
            
            VStack(spacing: 0){
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        // close Button...
                        
                        Image(systemName: self.show ? "xmark" : "line.horizontal.3")
                            .resizable()
                            .frame(width: self.show ? 18 : 22, height: 18)
                            .foregroundColor(Color.primary.opacity(0.4))
                    }
                    
                    // Changing Name Based On Index...
                    
                    Text(self.index == 0 ? "Home" : (self.index == 1 ? "Maps" : (self.index == 2 ? "TVShows" : "Chat")))
                        .font(.title)
                        .foregroundColor(Color.primary.opacity(0.6))
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        // Changing Views Based On Index...
                        
                        if self.index == 0{
                            
                            NavigationView {
                                ContentView()
                                    .padding(.vertical)
                                    .navigationTitle("Movies")
                                    .navigationBarTitleDisplayMode(.large)
                                  
                            }
                            
                            
                        }
                        else if self.index == 1{
                            
                            MapSearchView()
                                .environmentObject(DirectioinsEnviroment())
                        }
                        else if self.index == 2{
                            
//                         SignInView()
                        }
                        else{
   
                            Text("mohamed")
                        }
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
            //Applying Corner Radius...
            .cornerRadius(self.show ? 30 : 0)
            // Shrinking And Moving View Right Side When Menu Button Is Clicked...
            .scaleEffect(self.show ? 0.8 : 1)
            
            .offset(x: self.show ? UIScreen.main.bounds.width / 2 : 0, y: self.show ? 15 : 0)
        }
        .background(Color(UIColor.systemBackground)).edgesIgnoringSafeArea(.all)
        .edgesIgnoringSafeArea(.all)
        
    }
}



