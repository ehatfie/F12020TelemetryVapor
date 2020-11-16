import Fluent
import Vapor

extension FieldKey {
    static var title: Self { "title" }
    static var status: Self { "status" }
    static var labels: Self { "labels" }
    static var due: Self { "due " }
}



final class Todo: Model, Content {
    static let schema = "todos"
    
    enum Status: String, Codable, CaseIterable {
        static var name: FieldKey { .status }
        case pending
        case completed
    }
    
    struct Labels: OptionSet, Codable {
        var rawValue: Int
        
        static let red = Labels(rawValue: 1 <<  0)
        static let purple = Labels(rawValue: 1 << 1)
        static let orange = Labels(rawValue: 1 << 2)
        static let yellow = Labels(rawValue: 1 << 3)
        static let green = Labels(rawValue: 1 << 4)
        static let blue = Labels(rawValue: 1 << 5)
        static let gray = Labels(rawValue: 1 << 6)
        
        static let all: Labels = [.red, .purple, .orange, .yellow, .green, .blue, .gray]
    }
    
    @ID() var id: UUID?
    @Field(key: .title) var title: String
    @Field(key: .status) var status: Status
    @Field(key: .labels) var labels: Labels
    @Field(key: .due) var due: Date?
    
    init() { }
    
    init(id: UUID? = nil, title: String, status: Status = .pending, labels: Labels = [], due: Date? = nil) {
        self.id = id
        self.title = title
        self.status = status
        self.labels = labels
        self.due = due
    }
//    @ID(key: .id)
//    var id: UUID?
//
//    @Field(key: "title")
//    var title: String
//
//    init() { }
//
//    init(id: UUID? = nil, title: String) {
//        self.id = id
//        self.title = title
//    }
}

struct CreateToDo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        return database.schema(Todo.schema)
            .id()
            .field(.title, .string, .required)
            .field(.status, .string, .required)
            .field(.labels, .int, .required)
            .field(.due, .datetime)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Todo.schema).delete()
    }
}
