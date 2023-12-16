import UIKit

class User {
    
    var login: String
    var name: String
    var status: String
    var password: String
    var avatar: UIImage
    
    init(login: String, password: String, name: String, status: String, avatar: UIImage) {
        self.login = login
        self.password = password
        self.name = name
        self.status = status
        self.avatar = avatar
    }
    
}

protocol UserService: AnyObject {
    var delegate: UserServiceDelegate? { get set }
    func getUser(by login: String) -> User?
    func loginUser(login: String, password: String) -> Bool
    func logoutUser()
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void)
}

protocol UserServiceDelegate: AnyObject {
    func userDidLogin(_ user: User)
    func userDidLogout()
}

class CurrentUserService: UserService {
    
    static let shared = CurrentUserService()
    
    weak var delegate: UserServiceDelegate?
    
    var currentUser: User?
    
    private var users: [User] = []
    
    private init () {
        self.users.append(User(login: "Grut", password: "password1", name: "Я есть грут", status: "i am Groot", avatar: UIImage(named: "Grut")!))
        self.users.append(User(login: "Grut2", password: "password2", name: "Я есть грут2", status: "i am Groot2", avatar: UIImage(named: "Grut02")!))
        self.users.append(User(login: "user", password: "password", name: "Я есть user", status: "i am user", avatar: UIImage(named: "Grut03")!))
        
    }
    
    func getUser(by login: String) -> User? {
        
        return users.first { $0.login == login } ?? nil
    }
    
    func loginUser(login: String, password: String) -> Bool {
        
        if let user = getUser(by: login), user.password == password {
            
            currentUser = user
            delegate?.userDidLogin(user)
            return true
        }
        return false
    }
    
    func logoutUser() {
        currentUser = nil
        delegate?.userDidLogout()
    }
    
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        // Имитирует запрос данных из сети (делая паузу в 3 секунды)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            guard let self = self else { return }
            // Главное
            completion(.success(self.currentUser!))
        })
    }
}

//class TestUserService: UserService {
//    
//    private var currentUser: User
//    
//    init () {
//        self.currentUser = User(login: "TestGrut", password: "password4", name: "Test Я есть грут", status: "Test i am Groot", avatar: UIImage(named: "Grut01")!)
//    }
//    
//    func getUser(by login: String) -> User? {
//        
//        if login != currentUser.login {
//            return nil
//        }
//        
//        return currentUser
//    }
//}
