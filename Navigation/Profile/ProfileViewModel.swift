import UIKit

protocol ProfileVMProtocol {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    func changeStateIfNeeded()
    var showProfile: Action? { get set }
    var showGallery: Action? { get set }
}

enum State {
    case initial
    case loading
    case loaded(User)
    case error
}

final class ProfileViewModel: ProfileVMProtocol {
    
    var showProfile: Action?
    var showGallery: Action?
    
    private let userService: UserService?
    var currentState: ((State) -> Void)?
    
    var currentUser: User?
    
    var state: State = .initial {
        didSet {
            print(state)
            currentState?(state)
        }
    }
    
    init () {
        self.userService = CurrentUserService.shared
    }
    
    func changeStateIfNeeded() {
        state = .loading
        userService?.getCurrentUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.state = .loaded(user)
            case .failure(_):
                self.state = .error
            }
        }
    }
    
}
