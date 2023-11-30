import SwiftUI

struct CountryScreenView: View {
    
    var CountryImage1: String
    var CountryImage2: String
    var CountryImage3: String
    var CountryImage4: String
    @State private var ifShowedDiscription = false
    @State private var ifShowedBorders = false
    @State private var ifShowedTickets = false
    @State private var ifShowedVisa = false
    @State private var ifShowedDocuments = false
    
    let country: Country
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Text(country.name)
                        .padding()
                        .background(Color("transperentWhite"))
                        .font(.largeTitle)
                        .cornerRadius(16)
                }
                
                TabView {
                    Image(CountryImage1)
                        .resizable()
                        .cornerRadius(16)
                    Image(CountryImage2)
                        .resizable()
                        .cornerRadius(16)
                    Image(CountryImage3)
                        .resizable()
                        .cornerRadius(16)
                    Image(CountryImage4)
                        .resizable()
                        .cornerRadius(16)
                    
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: 350, height: 220)
                .padding(.top)
                
                CountryInfoBtn(isShowedSomething: ifShowedDiscription, textOfButton: "📜 Описание", textOfElement: country.discription)
                
                CountryInfoBtn(isShowedSomething: ifShowedBorders, textOfButton: "🗺️ Границы", textOfElement: country.borders)
                
                CountryInfoBtn(isShowedSomething: ifShowedTickets, textOfButton: "✈️ Билеты", textOfElement: country.tickets)
                
                CountryInfoBtn(isShowedSomething: ifShowedVisa, textOfButton: "🪪 Виза", textOfElement: country.visa)
                
                CountryInfoBtn(isShowedSomething: ifShowedDocuments, textOfButton: "📑 Документы", textOfElement: "• " + country.documents1 + "\n• " + country.documents2)
                
            }
        }
    }
}
