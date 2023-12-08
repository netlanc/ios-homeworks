import UIKit

class CustomButton: UIButton {
    
    private var tapButton: (() -> Void)?
    
    init(_ title: String, _ titleColor: UIColor, _ background: UIColor, tapButton: (() -> Void)?) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        
        backgroundColor = background
        
        layer.cornerRadius = 4
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset.width = 4
        layer.shadowOffset.height = 4
        layer.shadowOpacity = 0.7
        
//        autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        translatesAutoresizingMaskIntoConstraints = false
        
        self.tapButton = tapButton
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        tapButton?()
    }
}
