import SwiftUI

struct TestMenuView: View {
    var body: some View {
        
        Home()
    }
}

struct TestMenuView_preview: PreviewProvider {
    static var previews: some View {
        TestMenuView()
        
    }
}

struct Home : View {
    
    @State var index = 0
    @State var show = false
    
    var body: some View{
        
        ZStack{
            
            // Menu...
            
            HStack{
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Image("test")
                        .resizable()
                        .frame(width:60,height: 60)
                        .cornerRadius(20)
                    
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
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(self.index == 0 ? Color.pink.opacity(0.6) : Color.primary)
                            
                            
                            Text("Home")
                                .foregroundColor(self.index == 0 ? Color.pink.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 0 ? Color.pink.opacity(0.6) : Color.secondary.opacity(0.2))
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
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(self.index == 1 ? Color.pink.opacity(0.6): Color.primary)
                            
                            
                            Text("Movies")
                                .foregroundColor(self.index == 1 ? Color.pink.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 1 ? Color.pink.opacity(0.6) : Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        
                        self.index = 2
                        
                        withAnimation{
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(self.index == 2 ? Color.pink.opacity(0.6) : Color.primary)
                            
                            
                            Text("Favourites")
                                .foregroundColor(self.index == 2 ? Color.pink.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 2 ? Color.pink.opacity(0.6) : Color.secondary.opacity(0.2))
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
                                .foregroundColor(self.index == 3 ? Color.pink.opacity(0.6) : Color.primary)
                            
                            
                            Text("TVShows")
                                .foregroundColor(self.index == 3 ? Color.pink.opacity(0.6) : Color.primary)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(self.index == 3 ? Color.pink.opacity(0.6) : Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                    }
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.primary)
                        .padding(.vertical,30)
                    
                    Button(action: {
                        
                        
                    }) {
                        
                        HStack(spacing: 25){
                            
                            Image(systemName: "heart.fill")
                             
                            
                            
                            Text("Sign Out")
                                .foregroundColor(Color.primary)
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
                    
                    Text(self.index == 0 ? "Home" : (self.index == 1 ? "Movies" : (self.index == 2 ? "TVShows" : "Map")))
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
                            
                            ContentView()
                                .onTapGesture {
                                    withAnimation{
                                        self.show = false
                                    }
                                }
                        }
                        else if self.index == 1{
                            
                            Text("ragab")
                        }
                        else if self.index == 2{
                            
                            Text("ahmed ")
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
            // Rotating Slighlty...
            .rotationEffect(.init(degrees: self.show ? -5 : 0))
            
        }
        .background(Color(UIColor.systemBackground)).edgesIgnoringSafeArea(.all)
        .edgesIgnoringSafeArea(.all)
        
    }
}

// Mainpage View...


