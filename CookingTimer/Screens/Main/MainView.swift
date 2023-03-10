import UIKit

class MainView: UIView, MainViewProtocol {

    weak var delegate: MainViewDelegate?
    private var timerCollectionView: UICollectionView = {
        
        let timerCollectionView = UICollectionView(frame: .zero, collectionViewLayout:  UICollectionViewFlowLayout())
        timerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        timerCollectionView.backgroundColor = .secondarySystemBackground
        timerCollectionView.register(TimerCollectionViewCell.self, forCellWithReuseIdentifier: TimerCollectionViewCell.reuseIdentifier)
    
        
        return timerCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(timerCollectionView)
        NSLayoutConstraint.activate([
            timerCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            timerCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            timerCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            timerCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        
        ])
        
        
        timerCollectionView.register(TimerCollectionViewCell.self, forCellWithReuseIdentifier: TimerCollectionViewCell.reuseIdentifier)
        timerCollectionView.delegate = self
        timerCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - MainViewProtocol
    func refreshCollection() {
        timerCollectionView.reloadData()
    }
    
    func updateTimeLabelInCells() {

        let visibleRowsIndexPaths =  timerCollectionView.indexPathsForVisibleItems
        for indexPath in visibleRowsIndexPaths {
          if let cell = timerCollectionView.cellForItem(at: indexPath) as? TimerCollectionViewCell {
              let (_, currentTime, endTime) : (String, Int, Int) = delegate?.getTimerWithIndex(indexPath.row) ?? ("", 0, 0)
              if endTime == currentTime {
                  cell.updateTime(time: "completed")
                  cell.endAnimation()
              } else {
                  cell.updateTime(time: (endTime - currentTime).getTimeString())
              }
          }
        }
    }

}



// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // ???????????????????? ??????????
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.getNumOfTimers() ?? 0
    }
    
    
    // ?????????????????????????? ????????????
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimerCollectionViewCell.reuseIdentifier, for: indexPath) as! TimerCollectionViewCell
        
        let (name, currentTime, endTime): (String, Int, Int) = delegate?.getTimerWithIndex(indexPath.row) ?? ("", 0, 0)
        cell.setupTimer(name: name, currentTime: currentTime, endTime: endTime)
        if endTime == currentTime {
            cell.updateTime(time: "completed")
            cell.endAnimation()
        } else {
            cell.updateTime(time: (endTime - currentTime).getTimeString())
        }
        
        return cell
    }
}


extension MainView: UICollectionViewDelegateFlowLayout {
    // ???????????? ????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 32) / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }

    // ?????????????? ?????????? ????????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    

    // ?????????????? ???? ?????????? UICollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    //?????????????? ???? ????????????
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.toggleWorkingTimerWithIndex(indexPath.row)
        // ?????????????????????????? ????????????????
        let cell = collectionView.cellForItem(at: indexPath) as! TimerCollectionViewCell
        cell.toggleAnimation()
       
    }
    
    // ???????????????????? ?????????? ???????????????????????? ????????????
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! TimerCollectionViewCell
        let (_, currentTime, endTime): (String, Int, Int) = delegate?.getTimerWithIndex(indexPath.row) ?? ("", 0, 0)
        if endTime == currentTime {
            cell.updateTime(time: "completed")
            cell.endAnimation()
        } else {
            cell.updateTime(time: (endTime - currentTime).getTimeString())
        }
    }
}
