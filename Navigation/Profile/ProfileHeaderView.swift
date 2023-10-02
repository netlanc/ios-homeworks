import UIKit


class ProfileHeaderView: UIView {

    
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
        
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        
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
            y: avatarImageView.frame.maxY + padding,
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
            y: statusButton.frame.minY - 34 - statusLabel.font.lineHeight,
            width: fullNameLabel.frame.width,
            height: statusLabel.font.lineHeight
        )
        
    }
    
    @objc func buttonPressed() {
        print(statusLabel.text ?? "А статус пока не задан")
    }
}
