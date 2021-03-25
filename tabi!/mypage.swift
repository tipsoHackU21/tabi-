

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class mypage: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var MyPage: UINavigationBar!
    fileprivate var _refHandle: DatabaseHandle!
    
    var ref: DatabaseReference!
    var messages: [DataSnapshot] = []
    var count : Int = 0
    var section0 = [("キタテハ","タテハチョウ科")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .blue
        //ユーザー名の表示
        UserName.text = Auth.auth().currentUser?.displayName
        count = 0
        //コメント
//        ref = Database.database().reference()
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        self.ref.child("Users/\(userID)/Comments").observe(.value) { (snapShot) -> Void in
//            print("どうかな")
//
//        }
        configureDatabase()
        print("どうかなaaaaa")
//        var count = 0
//        while count < self.messages.count{
//            guard let x = self.messages[count].value as? String else { return }
//                        print("ぐあああああああああああああああああ\(x)")
//                        count += 1
//                    }
        print("個数 : \(self.messages.count)")
        print("表示してくれええええええhey\(self.messages)")
    }
    
//    //データベース確認
//    func configureDatabase() {
//        ref = Database.database().reference()
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//    // Listen for new messages in the Firebase database
//        _refHandle = self.ref.child("/Users/\(userID)/").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
//                guard let strongSelf = self else { return }
//            strongSelf.count += 1
//            print("にじゅー\(strongSelf.count)")
//
//            strongSelf.messages.append(snapshot)
//
//        })
//
//        print("ケツアゴ\(self.messages)")
//
//  }
    
    //データベース確認
    func configureDatabase() {
        ref = Database.database().reference()
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)

        dispatchGroup.enter()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
    // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Users/\(userID)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
            dispatchQueue.async(group: dispatchGroup) {
            // プランをsection0に追加する
            self!.section0 = []
            strongSelf.messages.append(snapshot)
            
            var count = 0
            while count < strongSelf.messages.count {
                print("どうですかね")
                guard let x = strongSelf.messages[count].value as? String else { return }
//                self!.section0.append((x, "プラン"))
                count += 1
            }
            }
            // 全ての非同期処理完了後にメインスレッドで処理
            dispatchGroup.notify(queue: .main) {
    //            guard let strongSelf = self else { return }
                print("All Process Done!")
    //            print("hey\(strongSelf.section0)")
    //            print("どうですかああhey\(type(of : strongSelf.section0))")
                
            }
            
        })

    }
        
        
  
    


}

