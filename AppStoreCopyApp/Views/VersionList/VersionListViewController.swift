//
//  VersionListViewController.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class VersionListViewController : SuperViewControllerSetting<VersionListViewModel>{
    @IBOutlet weak var versionListTableView: UITableView!
    
    
    private lazy var sectionTableDatasource = RxTableViewSectionedReloadDataSource<VersionModelSection>(
        configureCell: { (dataSource, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: VersionTableViewCell.id, for: IndexPath(row: indexPath.row, section: 0)) as! VersionTableViewCell
            if(self.leadMoreCount[indexPath.row] == nil){
                cell.itemSetting(item: item)
            }else{
                cell.relaseLabel.numberOfLines = 0
                cell.moreButton.isHidden = true
                cell.itemSetting(item: item)
            }
            cell.row = indexPath.row
            cell.delegate = self
              
            return cell
        }, titleForHeaderInSection: { dataSource, index in
            let sectionModel = dataSource.sectionModels[index]
            return "\(sectionModel.name)"
        })
    
    
    var leadMoreCount: [Int:Bool] = [:]
    
    
    override func uiSetting() {
        versionListTableView.register(VersionTableViewCell.self, forCellReuseIdentifier: VersionTableViewCell.id)
        versionListTableView.rowHeight = UITableView.automaticDimension
        versionListTableView.estimatedRowHeight = 108.0
        versionListTableView.delegate = self
    }
    
    override func uiDrawing() {
        
    }
    
    override func viewModelBinding() {
        let output = viewModel.transform(input: .init())
        
        output.versionSection
            .drive(versionListTableView.rx.items(dataSource: sectionTableDatasource))
            .disposed(by: disposeBag)
    }
    
}

extension VersionListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundColor = .primaryColorReverse
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = .primaryColor
        (view as! UITableViewHeaderFooterView).textLabel?.sizeToFit()
    }

}
extension VersionListViewController : ReadMoreActionDelegate{
    func readMore(row: Int) {
        leadMoreCount.updateValue(true, forKey: row)
        versionListTableView.beginUpdates()
        versionListTableView.endUpdates()
    }
}
