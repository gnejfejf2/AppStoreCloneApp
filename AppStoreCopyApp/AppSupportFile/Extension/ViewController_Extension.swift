//
//  ViewController_Extension.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/24.
//

import UIKit
extension UIViewController{
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }

}
