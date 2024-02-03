import Foundation
import SwiftUI
enum TabBarItem: Hashable{
    case list, map, settings, admin
    
    var iconName: String{
        switch self{
        case .list:return "list.bullet.clipboard"
        case .map:return "map"
        case .settings:return "gearshape"
        case .admin:return "person.crop.circle.badge.checkmark"
        }
    }
    
    var title: String{
        switch self{
        case .list:return "Список стран"
        case .map:return "Карта"
        case .settings:return "Настройки"
        case .admin:return "Админка"
        }
    }
}
