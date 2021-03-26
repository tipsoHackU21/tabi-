//
//  account_4.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/27.
//
import UIKit
import Foundation

class account_4: UIViewController {
    @IBOutlet weak var plain: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let to = CGPoint(x: 100, y: 100)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseOut], animations: {self.plain.center = to}, completion: nil)
    }
}
