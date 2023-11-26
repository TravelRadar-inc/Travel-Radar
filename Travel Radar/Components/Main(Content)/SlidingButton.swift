import SwiftUI

struct SlidingButton: View {
    @State var isShowedSomething: Bool
    @State var textOfButton: String
    @State var textOfElement: String
    
    var body: some View {
        VStack{
            HStack{
                Button(textOfButton) {
                    withAnimation {
                        isShowedSomething.toggle()
                    }
                }
                .foregroundColor(.black)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }

            if isShowedSomething {
                    Text(textOfElement)
                        .font(.title2)
                        .padding(.top, 10)
            }
        }
        .padding()
        .background(Color("transperentWhite"))
        .cornerRadius(16)
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
}

