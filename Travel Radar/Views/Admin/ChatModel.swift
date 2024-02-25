import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import Combine

enum FetchMessagesError: Error{
    case snapshotError
    case dataError
}
                                    

final class ChatModel {
    //static let shared = ChatModel(messageRef: CollectionReference)
    
    var id: String
    var messageRef: CollectionReference
    init(id: String){
        self.id = id
        self.messageRef = Firestore.firestore().collection("chats").document(id).collection("messages")
    }
    
    var messagesPublisher = PassthroughSubject<[Message], Error>()

    func fetchMessages() async throws -> [Message] {
        let snapshot = try await messageRef.order(by: "createdAt").getDocuments()
        let messages = self.createMessagesFromFirebaseSnapshot(snapshot: snapshot)
        return messages
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
    
    func listenForNewMessagesInDatabase() {
        messageRef.addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot = snapshot, let strongSelf = self, error == nil else{
                return
            }
            let messages = strongSelf.createMessagesFromFirebaseSnapshot(snapshot:  snapshot)
            strongSelf.messagesPublisher.send(messages)
        }
    }
    
    func createMessagesFromFirebaseSnapshot(snapshot: QuerySnapshot) -> [Message]{
        let docs = snapshot.documents
        var messages = [Message]()
        for doc in docs{
            let data = doc.data()
            let text = data["text"] as? String ?? "Error"
            let userUid = data["userUid"] as? String ?? "Error"
            let photoURL = data["photoURL"] as? String
            let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
            let message = Message (userUid: userUid, text: text, photoURL: photoURL, createdAt: createdAt.dateValue())
            messages.append(message)
        }
        return messages
    }
    
}

struct Chat: Hashable{
    let id: String
    let participant: Array<String>
    //let messages: Message
}
