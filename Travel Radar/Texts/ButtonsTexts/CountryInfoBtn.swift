import SwiftUI

struct CountryInfoBtn: View {
    @State var isShowedSomething: Bool
    @State var textOfButton: String
    @State var textOfElement: String
    
    var body: some View {
        VStack{

                /*Button(textOfButton) {
                    withAnimation {
                        isShowedSomething.toggle()
                    }
                }
                .foregroundColor(.black)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)*/
            
            Button(action: {
                withAnimation {
                    isShowedSomething.toggle()
                }
            }, label: {
                Text(textOfButton)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .font(.title)
            })
            
            if isShowedSomething {
                HStack{
                    Text(textOfElement)
                            .font(.title2)
                            .padding(.top, 10)
                            .foregroundColor(.black)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color("transperentWhite"))
        .cornerRadius(16)
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
}

