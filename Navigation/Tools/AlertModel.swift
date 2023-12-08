import UIKit

protocol AlertRun {
    func runAlert(textAlert: String, titleAlert: String, buttonAlert: String)
}

extension AlertRun where Self: UIViewController {
    func runAlert(textAlert: String = "Неизвестная ошибка", titleAlert: String = "Ошибка", buttonAlert: String = "Ok") {
        let alert = UIAlertController(title: titleAlert, message: textAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonAlert, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension LogInViewController: AlertRun {
    
}

extension FeedViewController: AlertRun {
    
}
