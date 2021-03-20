//
//  recruit_confirm.swift
//  tabi!
//
//  Created by 藤元彩花 on 2021/03/20.
//

import Foundation


import UIKit

import GoogleSignIn
import FirebaseAuth
//import FirebaseDatabase
import Firebase

class recruit_confirm : UIViewController{
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var destination_label: UILabel!
    @IBOutlet weak var about_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
//        print(defaults.string(forKey: "destination")!)
//        print(defaults.string(forKey: "title")!)
        title_label.text=defaults.string(forKey: "title")!
        destination_label.text = defaults.string(forKey:"destination")!
        
    }
}
