import Foundation

struct Item: Hashable {
    var id: String
    var text: String

    init(text: String) {
        self.id = UUID().uuidString
        self.text = text
    }
}
