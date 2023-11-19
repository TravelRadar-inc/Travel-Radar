import SwiftUI

struct MenuView: View {
    
    var CountryImage1: String
    var CountryImage2: String
    var CountryImage3: String
    var CountryImage4: String
    
    let country: Country
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Text(country.name)
                        .padding()
                        .font(.largeTitle)
                        .background(Color("conditionsColor"))
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
                
                VStack {
                    HStack {
                        Text("📜 Описание")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)
                        
                        Spacer()
                    }
                    
                    Text(country.discription)
                        .font(.title2)
                }
                .padding()
                .background(Color("conditionsColor"))
                .cornerRadius(16)
                .padding([.top, .leading, .trailing], 20)
                
                VStack {
                    HStack {
                        Text("🗺️ Границы")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(country.borders)
                            .font(.title2)
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color("conditionsColor"))
                .cornerRadius(16)
                .padding([.top, .leading, .trailing], 20)
                
                VStack {
                    HStack {
                        Text("✈️ Билеты")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)
                        
                        Spacer()
                    }
                    
                    Text(country.tickets)
                        .font(.title2)
                }
                .padding()
                .background(Color("conditionsColor"))
                .cornerRadius(16)
                .padding([.top, .leading, .trailing], 20)
                
                VStack {
                    HStack {
                        Text("🪪 Виза")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)
                        
                        Spacer()
                    }
                    
                    Text(country.visa)
                        .font(.title2)
                }
                .padding()
                .background(Color("conditionsColor"))
                .cornerRadius(16)
                .padding([.top, .leading, .trailing], 20)
                
                VStack {
                    HStack {
                        Text("📑 Документы")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)
                        
                        Spacer()
                    }
    
                    HStack {
                        Text("• " + country.documents1)
                            .font(.title2)
                        
                        Spacer()
                    }
                        
                    HStack{
                        Text("• " + country.documents2)
                            .font(.title2)
                        
                        Spacer()
                    }
                    
                    
                }
                .padding()
                .background(Color("conditionsColor"))
                .cornerRadius(16)
                .padding([.top, .leading, .trailing], 20)
            }
        }
    }
}
