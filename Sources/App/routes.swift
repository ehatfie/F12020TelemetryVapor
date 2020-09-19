import Fluent
import Vapor

struct Item: Codable {
    var title: String
    var description: String
}

struct Page: Codable {
    var content: String
}

func routes(_ app: Application) throws {
    
    app.get { req -> EventLoopFuture<View> in
        struct Context: Codable {
            var items: [Item]
        }
        let context = Context(items: [
            .init(title: "#01", description: "Description #01"),
            .init(title: "#02", description: "Description #02"),
            .init(title: "#03", description: "Description #03"),
            .init(title: "#04", description: "Description #04"),
        ])
        
        return req.view.render("page", context)
    }
    
//     app.get { req in
//        req.view.render("page", [
//            "title": "My Page",
//            "description": "This is my own page.",
//            "content": "Welcome to my page!"
//        ])
//    }
    
    app.webSocket("echo") { req, ws in
        // Connected WebSocket.
        print(ws)
    }

    try app.register(collection: TodoController())
}
