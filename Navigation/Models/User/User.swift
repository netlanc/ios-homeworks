import UIKit

class User {
    
    var login: String
    var password: String
    var name: String
    var status: String
    var avatar: UIImage
    
    init(login: String, password: String, name: String, status: String, avatar: UIImage) {
        self.login = login
        self.password = password
        self.name = name
        self.status = status
        self.avatar = avatar
    }
    
}

protocol UserService {
    func getUser(by login: String) -> User?
}

class CurrentUserService: UserService {
        
    private var users: [User] = []
    
    init () {
        self.users.append(User(login: "Grut", password: "password1", name: "Я есть грут", status: "i am Groot", avatar: UIImage(named: "Grut")!))
        self.users.append(User(login: "Grut2", password: "password2", name: "Я есть грут2", status: "i am Groot2", avatar: UIImage(named: "Grut02")!))
        self.users.append(User(login: "user", password: "password", name: "Я есть user", status: "i am user", avatar: UIImage(named: "Grut03")!))
    }
    
    func getUser(by login: String) -> User? {
        
        return users.first { $0.login == login } ?? nil
    }
}

class TestUserService: UserService {
        
    private var currentUser: User
    
    init () {
        self.currentUser = User(login: "TestGrut", password: "password4", name: "Test Я есть грут", status: "Test i am Groot", avatar: UIImage(named: "Grut01")!)
    }
    
    func getUser(by login: String) -> User? {
        
        if login != currentUser.login {
            return nil
        }
        
        return currentUser
    }
}
