import Fluent
import FluentPostgresDriver
import Vapor
import Leaf


extension Application {
    static let databaseUrl = URL(string: Environment.get("DB_URL")!)!
}

// configures your application
public func configure(_ app: Application) throws {
    //app.http.server.configuration.hostname = "192.168.1.119"
    print(Application.databaseUrl)

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    try app.databases.use(.postgres(url: Application.databaseUrl), as: .psql)
    
//    app.databases.use(.postgres(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .psql)
//
//    app.migrations.add(CreateTodo())
//
    app.views.use(.leaf)
    
    // register routes
    try routes(app)
    
    //app.middleware.use(
//    let gameSystem = GameSystem(eventLoop: app.eventLoopGroup.next())
//    
//    DispatchQueue.global().async {
//        do {
//            startUDP(system: gameSystem)
//        }
//    }
//    
//    app.webSocket("channel") { req, ws in
//        print("WEBSOCKET CHANNEL")
//        gameSystem.connect(ws)
//    }
}
