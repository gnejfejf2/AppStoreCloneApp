//
//  AppDetailViewController.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class AppDetailViewController : SuperViewControllerSetting<AppDetailViewModel> , StarSettingProtocol{
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var shareButton: UIImageView!
    @IBOutlet weak var appStarLabel: UILabel!
    @IBOutlet weak var appStarCountLabel: UILabel!
    
    @IBOutlet weak var minimumVersionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var versionHistoryButton: UILabel!
    @IBOutlet weak var versionTitleLabel: UILabel!
    @IBOutlet weak var versionTimeLabel: UILabel!
    @IBOutlet weak var readMoreLabelView: ReadMoreLabelView!
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    
    @IBOutlet weak var starImageView1: UIImageView!
    
    @IBOutlet weak var starImageView2: UIImageView!
    
    @IBOutlet weak var starImageView3: UIImageView!
    
    @IBOutlet weak var starImageView4: UIImageView!
    
    @IBOutlet weak var starImageView5: UIImageView!
    
    lazy var starViews: [UIImageView] = [starImageView1,starImageView2,starImageView3,starImageView4,starImageView5]
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    override func uiDrawing() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 8
        downloadButton.layer.masksToBounds = true
        downloadButton.layer.cornerRadius = downloadButton.frame.height / 2
    }
    
    override func uiSetting() {
        screenShotCollectionView.register(UINib(nibName: ScreenShotCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: ScreenShotCollectionViewCell.id)
        screenShotCollectionView.delegate = self
    }
    
    override func viewModelBinding() {
        let versionHistoryAction = versionHistoryButton.rx
            .tapGesture()
            .when(.recognized)
            .asDriverOnErrorNever()
        
        
        let output = viewModel.transform(input: .init(
            versionHistoryAction : versionHistoryAction
        ))
        
      
        
        output.appData
            .drive{ [weak self] item in
                guard let self = self else { return }
                self.appDataSetting(appData: item)
            }
            .disposed(by: disposeBag)
        
        
        output.appData
            .map{ $0.screenshotUrls }
            .drive(screenShotCollectionView.rx.items(cellIdentifier: ScreenShotCollectionViewCell.id, cellType: ScreenShotCollectionViewCell.self)) { index, item, cell in
                cell.itemSetting(item: item)
            }
            .disposed(by: disposeBag)
        
        
      
       
       
    }
    
    
    func appDataSetting(appData : AppModel){
        iconImageView.setImageUrl(appData.artworkUrl512)
        titleLabel.text = appData.trackName
        typeLabel.text = appData.primaryGenreName
        versionTitleLabel.text = appData.version
        readMoreLabelView.itemSetting(item: appData.releaseNotes)
        ageLabel.text = appData.contentAdvisoryRating
        minimumVersionLabel.text = appData.minimumOsVersion
        versionTimeLabel.text = appData.currentVersionReleaseDate.distanceTimeCal()
        appStarLabel.text = String(appData.averageUserRating.customRounds(count: 1))
        starSetting(item: appData)
        appStarCountLabel.text = appData.userRatingCount.countToString()
        
        
        
    }
    
    
}

extension AppDetailViewController : UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
         guard let layout = screenShotCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
         
         let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
         
         let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
         let index: Int
         if velocity.x > 0 {
             index = Int(ceil(estimatedIndex))
         } else if velocity.x < 0 {
             index = Int(floor(estimatedIndex))
         } else {
             index = Int(round(estimatedIndex))
         }
         
         targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
     }
}


