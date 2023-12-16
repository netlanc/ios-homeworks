import UIKit

final class Checker: UserServiceDelegate {
    static let shared = Checker()
    

    var userService: UserService = CurrentUserService.shared

    private init() {
        userService.delegate = self
    }

    func userDidLogin(_ user: User) {
        // Обработка успешного входа пользователя, если нужно
    }

    func userDidLogout() {
        // Обработка выхода пользователя, если нужно
    }

    func check(login: String, password: String) -> Bool {
        return userService.loginUser(login: login, password: password)
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
//    func getCurrentUser() -> User?
}

struct LoginInspector: LoginViewControllerDelegate {
    init() {
        Checker.shared.userService = CurrentUserService.shared
     }

     func check(login: String, password: String) -> Bool {
         return Checker.shared.check(login: login, password: password)
     }

//     func getCurrentUser() -> User? {
//         return Checker.shared.userService?.currentUser
//     }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate
}


struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate {
        return LoginInspector()
    }
}
