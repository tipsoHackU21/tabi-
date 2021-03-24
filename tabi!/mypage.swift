

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class mypage: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var MyPage: UINavigationBar!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .blue
        //ユーザー名の表示
        UserName.text = Auth.auth().currentUser?.displayName
        //コメント
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.ref.child("Users/\(userID)/Comments").observe(.value) { (snapShot) -> Void in
            print("どうかな")
//            let data = snapShot.value! as! String
//            print("何が入ってるかな\(data)")
        }
    }
    
    


}

