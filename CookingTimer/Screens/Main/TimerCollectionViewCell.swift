import UIKit


// TODO: реализовать 

class TimerCollectionViewCell: UICollectionViewCell, CAAnimationDelegate {
    
    static let reuseIdentifier = "TimerCollectionViewCell"
    
    private let strokeCircleLineColor = UIColor.green.cgColor
    private let lineWidth: CGFloat = 3
    
    private let animation = CABasicAnimation(keyPath: "strokeEnd")
    private var isAnumationPaused = false
    private lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = self.lineWidth
        layer.strokeColor = self.strokeCircleLineColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    private lazy var backgroundCircleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = self.lineWidth
        layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()


            
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        contentView.addSubview(timeLabel)
        contentView.addSubview(nameLabel)
        
        setupRoundRectLayer()
        animation.delegate = self
        backgroundColor = .systemGray3
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            timeLabel.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: self.frame.height / 2),

        ])
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - public functions
    private func setupRoundRectLayer() {
        layer.cornerRadius = contentView.bounds.height / 4
        let cornerRectPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius)
        backgroundCircleLayer.path = cornerRectPath.cgPath
        layer.addSublayer(backgroundCircleLayer)
        circleLayer.path = cornerRectPath.cgPath
        layer.addSublayer(circleLayer)
    }
    
    public func setupTimer(name: String, currentTime: Int, endTime: Int) {
        if currentTime == endTime {
            return
        }
        nameLabel.text = name
        circleLayer.strokeColor = self.strokeCircleLineColor
        animation.duration = Double(endTime - currentTime) // время
        animation.fromValue = 1.0 - Double(currentTime) / Double(endTime)
        animation.toValue = 0.0
        animation.isRemovedOnCompletion = false
        circleLayer.add(animation, forKey: "drawCircleAnimation")
        
        
    }
    
    public func updateTime(time: String) {
        timeLabel.text = time
    }
    
    public func endAnimation() {
        circleLayer.strokeColor = UIColor.clear.cgColor
    }

    public func toggleAnimation() {
        if !isAnumationPaused {
            let pausedTime = circleLayer.convertTime(CACurrentMediaTime(), from: nil)
            circleLayer.timeOffset = pausedTime
            circleLayer.speed = 0.0
            isAnumationPaused = true
        } else {
            let pausedTime = circleLayer.timeOffset
            circleLayer.speed = 1.0
            circleLayer.timeOffset = 0.0
            circleLayer.beginTime = 0.0
            let timeSincePause = circleLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            circleLayer.beginTime = timeSincePause
            isAnumationPaused = false

        }
    }
    
    
    
    
}
