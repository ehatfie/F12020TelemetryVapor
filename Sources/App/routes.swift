import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index")
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("hello1") { req in
        return req.view.render("index.html")
    }
    
    app.webSocket("echo") { req, ws in
        // Connected WebSocket.
        print(ws)
    }

    try app.register(collection: TodoController())
}
