import SwiftUI
struct TestDrag: View {
  
    
    var body: some View {
      
           
                List {
                HStack{
                    Text("Actor Rating")
                    Spacer()
                    Text("ahmed ragab")
                        
                }
                .padding()
                
                HStack{
                    Text("Date Of Birth")
                    Spacer()
                    Text("ahmed ragab")
                }
                .padding()
                
                HStack{
                    Text("biography")
                    Spacer()
                    Spacer()
                    VStack {
                        Text("ahmed ragabksdfbsdbvsblsdbvlsdblsdbldbvldskbvbkdjbvdbvldskbvkldbfvlkdsbvdlksbvkldbfvldskv")
                            .font(.subheadline)
                    }
                }
                .padding()
                
                //gender  knownForDepartment
                HStack{
                    Text("gender")
                    Spacer()
                    Text("ahmed ragab")
                }
                .padding()
                
                
                HStack{
                    Text("knownForDepartment")
                    Spacer()
                    Text("ahmed ragab")
                }
                .padding()
               
              
               
             
            }
                .padding()
        
        
    }
}

struct TestDrag_Previews: PreviewProvider {
    static var previews: some View {
        TestDrag()
           


    }
}
