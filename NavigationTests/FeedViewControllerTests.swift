//
//  FeedViewControllerTests.swift
//  NavigationTests
//
//  Created by netlanc on 23.04.2024.
//
import XCTest
@testable import Navigation

class FeedViewControllerTests: XCTestCase {

    var feedViewController: FeedViewController!

    override func setUp() {
        super.setUp()
        feedViewController = FeedViewController()
        feedViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        feedViewController = nil
        super.tearDown()
    }

    // корректный ввод
    func testCheckGuessButtonActionWithCorrectText() {
        let correctText = "12345"

        feedViewController.textField.text = correctText
        feedViewController.checkGuessButton.buttonTapped()

        XCTAssertEqual(feedViewController.checkLabel.text, "Секретное слово введено правильно")
        XCTAssertEqual(feedViewController.checkLabel.textColor, .green)
    }

    // не корректный ввод
    func testCheckGuessButtonActionWithIncorrectText() {
 
        let incorrectText = "54321"

        feedViewController.textField.text = incorrectText
        feedViewController.checkGuessButton.buttonTapped()

        XCTAssertEqual(feedViewController.checkLabel.text, "Секретное слово не верно")
    }

    // пустое поле ввода
    func testCheckGuessButtonActionWithEmptyText() {

        feedViewController.textField.text = ""
        feedViewController.checkGuessButton.buttonTapped() // Simulate button tap

        XCTAssertEqual(feedViewController.checkLabel.text, "Проверка введенного слова")
    }
}
