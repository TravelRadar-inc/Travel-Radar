import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    }

struct AlertContext {
    static let invalidData      = AlertItem(title: Text("Ошибка сервера"),
                                            message: Text("Информация, полученная от сервера недействительна."),
                                            dismissButton: . default(Text("0K")))
    
    static let invalidURL       = AlertItem(title: Text("Ошибка сервера"),
                                            message: Text("Произошла ошибка при подключении к серверу. Повторите запрос позже"),
                                            dismissButton: .default(Text("0K")))
    
    static let invalidResponse  = AlertItem(title: Text("Ошибка сервера"),
                                            message: Text("Ответ от сервера оказался недействительным. Повторите запрос позже."),
                                            dismissButton: .default(Text("0K")))
    
    static let unableToComplete = AlertItem(title: Text("Ошибка сервера"),
                                            message: Text("Невозможно выполнить Ваш запрос. Проверьте подключение к интернету."),
                                            dismissButton: .default(Text("0K")))
    }
