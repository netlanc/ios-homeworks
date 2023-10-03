import UIKit



class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    let paddedTextField = TextFieldWithPadding(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
    
    private let statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset.width = 4
        statusButton.layer.shadowOffset.height = 4
        statusButton.layer.shadowOpacity = 0.7
        statusButton.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        return statusButton
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Я есть Грут...Я есть Грут...Я есть Грут...Я есть..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.layer.masksToBounds = true
        statusLabel.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        return statusLabel
    }()
    
    private let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Я есть Грут"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        fullNameLabel.textColor = .black
        fullNameLabel.layer.masksToBounds = true
        fullNameLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        
        return fullNameLabel
    }()
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        let image = UIImage(named: "Grut")
        avatarImageView.image = image
        
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        
        return avatarImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        createTextField();
        
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        paddedTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        addSubview(paddedTextField)
    }
    
    func createTextField(){
        
        paddedTextField.placeholder = "Заполните текст…"
        
        paddedTextField.font = UIFont.systemFont(ofSize: 15)
        
        paddedTextField.backgroundColor = .white
        paddedTextField.layer.cornerRadius = 12
        paddedTextField.layer.borderWidth = 1
        paddedTextField.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let safeAreaInsets = self.safeAreaInsets
        let viewWidth = self.bounds.size.width
        let viewHeight = self.bounds.size.height
        let padding: CGFloat = 16
        var paddingOrientation: CGFloat = 0
        
        if (viewWidth > viewHeight) {
            paddingOrientation = 100
        }
        
        avatarImageView.frame = CGRect(
            x: safeAreaInsets.left + padding,
            y: safeAreaInsets.top + padding,
            width: 100,
            height: 100
        )
        
        statusButton.frame = CGRect(
            x: safeAreaInsets.left + padding,
            y: avatarImageView.frame.maxY + padding + 20,
            width: viewWidth - padding * 2 - paddingOrientation,
            height: 50
        )
        
        fullNameLabel.frame = CGRect(
            x: avatarImageView.frame.maxX + padding,
            y: safeAreaInsets.top + 27,
            width: viewWidth - avatarImageView.frame.maxX - 2 * padding,
            height: fullNameLabel.font.lineHeight
        )
        
        statusLabel.frame = CGRect(
            x: avatarImageView.frame.maxX + padding,
            y: statusButton.frame.minY - 54 - statusLabel.font.lineHeight,
            width: fullNameLabel.frame.width,
            height: statusLabel.font.lineHeight
        )
        
        paddedTextField.frame = CGRect(
            x: avatarImageView.frame.maxX + padding,
            y: statusButton.frame.minY - 50,
            width: fullNameLabel.frame.width,
            height: 40
        )
        
    }
    
    @objc func buttonPressed() {
        //print(statusLabel.text ?? "А статус пока не задан")
        
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

