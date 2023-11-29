import UIKit

class User {
    
    var login: String
    var name: String
    var status: String
    var avatar: UIImage
    
    init(login: String, name: String, status: String, avatar: UIImage) {
        self.login = login
        self.name = name
        self.status = status
        self.avatar = avatar
    }
    
}

protocol UserService {
    func getUser(by login: String) -> User?
}

class CurrentUserService: UserService {
        
    private var currentUser: User
    
    init () {
        self.currentUser = User(login: "Grut", name: "Я есть грут", status: "i am Groot", avatar: UIImage(named: "Grut")!)
    }
    
    func getUser(by login: String) -> User? {
        
        if login != currentUser.login {
            return nil
        }
        
        return currentUser
    }
}

class TestUserService: UserService {
        
    private var currentUser: User
    
    init () {
        self.currentUser = User(login: "TestGrut", name: "Test Я есть грут", status: "Test i am Groot", avatar: UIImage(named: "Grut01")!)
    }
    
    func getUser(by login: String) -> User? {
        
        if login != currentUser.login {
            return nil
        }
        
        return currentUser
    }
}
