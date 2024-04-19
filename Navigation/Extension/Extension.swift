import UIKit

extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension String {
    var localizeDict: String {
        NSLocalizedString(self, tableName: "LocalizableDict", comment: "")
    }
}


extension UIColor {
    
    static func createColor(anyMode: UIColor, darkMode: UIColor) -> UIColor {
        
        guard #available(iOS 13.0, *) else {
            return anyMode
        }
        
        return UIColor { (traitCollection) -> UIColor in
            
            return traitCollection.userInterfaceStyle == .dark ?  darkMode:
            anyMode
            
        }
        
    }
    
}

