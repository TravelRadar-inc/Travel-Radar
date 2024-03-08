import Foundation
import SwiftUI

struct UpdateUserSectionView:View {
    var body: some View{
        Section{
            NavigationLink{
                UpdateUserInfo()
            } label: {
                Text("Изменить информацию о пользователе")
            }
        } header: {
            Text("Информация о пользователе")
        }
    }
}
