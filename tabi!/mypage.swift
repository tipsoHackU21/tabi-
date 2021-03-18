

import Foundation
import UIKit
import FirebaseAuth

class mypage: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var MyPage: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .blue
        //ユーザー名の表示
        UserName.text = Auth.auth().currentUser?.displayName
        
    }
    
    


}

