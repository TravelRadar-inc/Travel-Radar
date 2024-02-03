import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

enum FetchMessagesError: Error{
    case snapshotError
    case dataError
}
                                    

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    let messageRef = Firestore.firestore().collection("messages")
    
//    func fetchMessage(completiom: @escaping (Result<[Message], FetchMessagesError>) -> Void) {
//        messageRef.order(by: "createdAt", descending: true).limit(to: 25).getDocuments { snapshot, error in
//            guard let snapshot = snapshot, error == nil else {
//                completiom(.failure(.snapshotError))
//                return
//            }
//            let docs = snapshot.documents
//            var messages = [Message]()
//            for doc in docs {
//                let data = doc.data()
//                let text = data["text"] as? String ?? "Error"
//                let userUid = data["userUid"] as? String ?? "Error"
//                let photoURL = data["photoURL"] as? String ?? "Error"
//                let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
//                
//                let msg = Message(userUid: userUid, text: text, photoURL: photoURL, createdAt: createdAt.dateValue())
//                messages.append(msg)
//            }
//            completiom(.success(messages))
//        }
//    }

    func fetchMessages() async throws -> [Message] {
        let snapshot = try await messageRef.getDocuments()
        var messages = [Message]()
        for doc in snapshot.documents {
            let data = doc.data()
            let text = data["text"] as? String ?? "Error"
            let userUid = data["userUid"] as? String ?? "Error"
            let photoURL = data["photoURL"] as? String ?? "Error"
            let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
            
            let message = Message(userUid: userUid, text: text, photoURL: photoURL, createdAt: createdAt.dateValue())
            messages.append(message)
        }
        return messages.reversed()
    }
    
    func sendMessageToDatabase(message: Message) async throws{
        let data = [
            "text": message.text,
            "userUid": message.userUid,
            "photoURL": message.photoURL,
            "createdAt": Timestamp(date: message.createdAt)
            
        ] as [String: Any]
        try await messageRef.addDocument(data: data)
    }
    
//    func listenForNewMessagesInDatabase() {
//        messageRef.addSnapshotListener  { [weak .self], <#Error?#> in
//            <#code#>
//        }
//    }
    
}
