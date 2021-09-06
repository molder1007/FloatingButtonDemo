//
//  ViewController.swift
//  FloatingButtonDemo
//
//  Created by Molder on 2021/9/6.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.borderWidth = 8
        self.view.layer.borderColor = UIColor.red.cgColor
        let floatingButton = FloatingButtonView()
        floatingButton.delegate = self
        floatingButton.addFloatingButton(target: self.view)
    }
}

extension ViewController : FloatingButtonViewDelegate {
    func btnViewAciton() {
        guard let link_url = URL(string: "https://www.apple.com") else { return }
        let isCanOpne :Bool =  UIApplication.shared.canOpenURL(link_url)
        if isCanOpne == true {
            UIApplication.shared.open(link_url, options: [:])
        }
    }
}
