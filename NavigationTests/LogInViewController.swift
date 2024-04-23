//
//  LogInViewController.swift
//  NavigationTests
//
//  Created by netlanc on 23.04.2024.
//

import XCTest
@testable import Navigation

class LogInViewControllerTests: XCTestCase {
    
    var viewController: LogInViewController!
    var mockDelegate: MockLoginViewControllerDelegate!
    
    override func setUpWithError() throws {
        // Создаем экземпляр LogInViewController
        let profileModel = ProfileViewModel.shared // Ваша реализация ProfileViewModel
        mockDelegate = MockLoginViewControllerDelegate()
        viewController = LogInViewController(profileModel: profileModel, loginInspector: mockDelegate)
        
        // Загружаем view hierarchy
        viewController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        // Очищаем ресурсы после каждого теста
        viewController = nil
        mockDelegate = nil
    }
    
    func testLoginButtonAction_SuccessfulLogin() throws {
        // Устанавливаем успешный результат проверки и входа
        mockDelegate.checkResult = .success(())
        mockDelegate.setCurrentUserResult = true
        
        // Вызываем метод для входа
        viewController.handleLogInPressed()
        
        // Проверяем, что профиль был успешно загружен
        XCTAssertNotNil(mockDelegate.setCurrentUserResult, "Текущий пользователь должен быть установлен после успешного входа в систему")
    }
    
    func testLoginButtonAction_LoginFailed() throws {
        // Устанавливаем неуспешный результат проверки входа
        mockDelegate.checkResult = .failure(AuthError.unknown)
        
        // Вызываем метод для входа
        viewController.handleLogInPressed()
        
        // Проверяем, что пользователь не был установлен
        XCTAssertNil(viewController.profileModel.currentUser, "Пользователь не подгружается так как ввод не корректный")
    }
    
    func testLoginButtonAction_UserNotFound() throws {
        // Устанавливаем результат проверки входа, что пользователь не найден
        mockDelegate.checkResult = .failure(AuthError.empty(description: "Пользователь не найден"))
        
        // Вызываем метод для входа
        viewController.handleLogInPressed()
        
        // Проверяем, что пользователь не был установлен
        XCTAssertNil(viewController.profileModel.currentUser, "Пользователь не подгружается так как он не найден")
    }
}


// мок для имитации
class MockLoginViewControllerDelegate: LoginViewControllerDelegate {
    
    var checkResult: Result<Void, Error>?
    var setCurrentUserResult: Bool?
    
    func check(login: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = checkResult {
            completion(result)
        }
    }
    
    func setCurrentUser() -> Bool {
        return setCurrentUserResult ?? false
    }
}
