import UIKit
import FirebaseAuth


enum AuthError: Error {
    case empty(description: String)
    case unknown
}

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError?, error.code == AuthErrorCode.userNotFound.rawValue || error.code == AuthErrorCode.invalidCredential.rawValue {
                // Если пользователь не найден( или code - 17004 - данные для проверки подлинности сформированы неправильно или срок их действия истек - при несуществующем пользователе в FirebaseAuth - вылетает эта ошибка), вызываем signUp
                self.signUp(email: email, password: password, completion: completion)
                //completion(.failure(AuthError.empty(description: "Пользователь не найден")))
                
            } else if let error = error {
                // Если возникла другая ошибка, передаем ее в completion
                //print("error", error)
                completion(.failure(error))
            } else {
                // Если ошибок нет, передаем успех в completion
                completion(.success(()))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

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
        
        print("check 555", login)
        
        return userService.loginUser(login: login, password: password)
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func setCurrentUser() -> Bool
    //    func getCurrentUser() -> User?
}

class LoginInspector: LoginViewControllerDelegate {
    
    var userService: UserService = CurrentUserService.shared
    private let checkerService: CheckerService
    
    init(checkerService: CheckerService) {
        self.checkerService = checkerService
    }
    
    func setCurrentUser() -> Bool {
        
        guard let emailUser = Auth.auth().currentUser else {
            return false
        }
        
        return userService.setUser(email: emailUser.email! as String)
    }
    
    func check(login email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        checkerService.checkCredentials(email: email, password: password, completion: completion)
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        checkerService.signUp(email: email, password: password, completion: completion)
    }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginViewControllerDelegate
}


struct MyLoginFactory: LoginFactory {
    let checkerService: CheckerServiceProtocol // Используется CheckerService
    
    func makeLoginInspector() -> LoginViewControllerDelegate {
        return LoginInspector(checkerService: checkerService as! CheckerService)
    }
}
