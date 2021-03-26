//
//  mypageEdit.swift
//  tabi!
//
//  Created by c_seikyo75 on 2021/03/26.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class mypageEdit: UIViewController {
    
    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var usermessage: UITextView!
    @IBOutlet weak var updateButton: UIButton!

    override func viewDidLoad(){
        super.viewDidLoad()
        
        username.layer.borderColor = UIColor.blue.cgColor
        username.layer.borderWidth = 5.0
        usermessage.layer.borderColor = UIColor.blue.cgColor
        usermessage.layer.borderWidth = 5.0
    
    }
    @IBAction func TapButton(_ sender: Any) {
        //ここにプロフィール更新記述処理
        
        
        //更新後にViewを破棄して戻る
        self.dismiss(animated: true, completion: nil)
    }
}


        
