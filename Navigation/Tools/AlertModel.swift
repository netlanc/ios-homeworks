import UIKit

protocol AlertRun {
    func runAlert(textAlert: String, titleAlert: String, buttonAlert: String)
}

extension AlertRun where Self: UIViewController {
    func runAlert(textAlert: String = NSLocalizedString("alert.text-default", comment: "Неизвестная ошибка"),
                  titleAlert: String = NSLocalizedString("alert.title-default", comment: "Ошибка"),
                  buttonAlert: String = NSLocalizedString("sys.ok", comment: "Ok")) {
        let alert = UIAlertController(title: titleAlert, message: textAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonAlert, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension LogInViewController: AlertRun {
    
}

extension FeedViewController: AlertRun {
    
}
extension MapViewController: AlertRun {
    
}
