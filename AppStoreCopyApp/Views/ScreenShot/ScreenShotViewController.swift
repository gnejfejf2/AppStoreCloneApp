//
//  ScreenShotViewController.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources

class ScreenShotViewController : SuperViewControllerSetting<ScreenShotViewModel>{
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    
    override func uiSetting() {
        screenShotCollectionView.register(UINib(nibName: ScreenShotCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: ScreenShotCollectionViewCell.id)
        
        screenShotCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func viewModelBinding() {
        let closeAction = cancelButton.rx.tapGesture().when(.recognized).asDriverOnErrorNever()
        
        
        let output = viewModel.transform(input: .init(
            closeAction : closeAction
        ))
        
        output.screenShotURLs
            .drive(screenShotCollectionView.rx.items(cellIdentifier: ScreenShotCollectionViewCell.id, cellType: ScreenShotCollectionViewCell.self)) { index, item, cell in
                
                cell.itemSetting(item: item)
            }
            .disposed(by: disposeBag)
        
        
        screenShotCollectionView.layoutIfNeeded()
        screenShotCollectionView.scrollToItem(at: IndexPath(item: output.selectedIndex, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
        
    }
    
}

extension ScreenShotViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width - 20) * 16 / 9)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = screenShotCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
         
        let cellWidthIncludingSpacing = UIScreen.main.bounds.width - ((layout.minimumLineSpacing))
        
        
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

