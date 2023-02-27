import UIKit



// TODO: в данный момент при окончании анимации отрисовывается контур, нужно ИМЕННО в момент окончания анимации убрать контур
class TimerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TimerCollectionViewCell"
    
    private let animation = CABasicAnimation(keyPath: "strokeEnd")
    private var isAnumationPaused = false
    private lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 3
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)

        label.text = "DD:HH:SS"
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)

        label.text = "typical name bla bla bla bla bla bla "
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(nameLabel)
        
        setupRoundRectLayer()
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            timeLabel.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //nameLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: self.frame.height / 2),

        ])
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupRoundRectLayer() {
        layer.cornerRadius = contentView.bounds.height / 4
        let cornerRectPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius)
        circleLayer.path = cornerRectPath.cgPath
        layer.addSublayer(circleLayer)
        

    }
    
    public func setupTimer(name: String, currentTime: Int, endTime: Int) {
        if currentTime == endTime {
            circleLayer.removeAllAnimations()
            return
        }
        
        nameLabel.text = name
        animation.duration = Double(endTime - currentTime) // время
        animation.fromValue = 1.0 - Double(currentTime) / Double(endTime)
        animation.toValue = 0.0
        
        circleLayer.add(animation, forKey: "drawCircleAnimation")
        
        
    }
    
    public func updateTime(time: Int) {
        timeLabel.text = time.getTimeString()

        
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
