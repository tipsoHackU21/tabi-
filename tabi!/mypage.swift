

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class mypage: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserIcon: UIImageView!
    @IBOutlet weak var ProfileEditButton: UIButton!
    @IBOutlet weak var MyPage: UINavigationBar!
    fileprivate var _refHandle: DatabaseHandle!
    
    var ref: DatabaseReference!
    var messages: [DataSnapshot] = []
    var count : Int = 0
//    var section0 : [__NSCFString] = []
    var section0 : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .blue
        //ユーザー名の表示
        UserName.text = Auth.auth().currentUser?.displayName
        count = 0
        configureDatabase()
        print("どうかなaaaaa")
        print("個数 : \(self.messages.count)")
        print("表示してくれええええええhey\(self.messages)")
    }
    
    //データベース確認
    func configureDatabase() {
        ref = Database.database().reference()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }

        _refHandle = self.ref.child("Users/\(userID)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
            
            // プランをsection0に追加する
            self!.section0 = []
            strongSelf.messages.append(snapshot)
            print("マイページい\(strongSelf.messages)")
            print("マイページい\(type(of : strongSelf.messages))")
            var count = 0
            while count < strongSelf.messages.count{
                if count < strongSelf.messages.count{
                    let myData = strongSelf.messages[count].value!
                    print("myデータ\(myData)")
                    print("myデータタイプ\(type(of:myData))")
//                    strongSelf.section0.append(myData as! String )
                }
                count += 1
            }
        })

    }
        
        
  
    


}

