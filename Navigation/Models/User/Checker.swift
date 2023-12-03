import UIKit

final class Checker {
    static let shared = Checker()
    private init() {}
    
    var currenUser: User?
    
//    private let validateLogin = "user"
//    private let validatePassword = "password"
    
    func check(login: String, password: String) -> Bool {
        
//        #if DEBUG // Схема - Navigation
//        let userService: UserService = TestUserService()
//        #else
        let userService: UserService = CurrentUserService()
//        #endif
        
        print("login:", login)
        print("password:", password)
        
        if let user = userService.getUser(by: login) {
            if password == user.password {
                self.currenUser = user
                return true
            }
        }
        
        return false
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
    func getCurrentUser() -> User?
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
    func getCurrentUser() -> User? {
        return Checker.shared.currenUser
    }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate
}


struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate {
        return LoginInspector()
    }
}
