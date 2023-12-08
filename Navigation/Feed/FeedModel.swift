import UIKit

class FeedModel {
    
    public var secretWord = "12345"
    
    func check(_ word: String)->Bool {
        
        return word == secretWord ? true: false
        
    }
    
}
