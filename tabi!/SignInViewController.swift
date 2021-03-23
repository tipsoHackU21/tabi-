//
//  Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
//import SwiftyJSON

@objc(SignInViewController)
class SignInViewController: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
    var handle: AuthStateDidChangeListenerHandle?
    
    //読み取り
    var databaseRef: DatabaseReference! = Database.database().reference()
    var db: Firestore!
    var ref: DatabaseReference!
    var docRef: DocumentReference!
    var snap : DataSnapshot!
    
    override func viewDidLoad() {
        //諸々
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        db = Firestore.firestore()
        ref = Database.database().reference()
        
        
        //ユーザー情報
        var username = Auth.auth().currentUser?.displayName;
        print("現在のユーザーは \(username)です")
        
        //ユーザーのIDがあればそのまま、なければ更新
        guard let userID = Auth.auth().currentUser?.uid else { return }
    
        self.ref.child("Users/\(userID)").observe(.value) { (snapShot) -> Void in
            print("どうかな")
            let data = snapShot.value!
            //snapShot.hasChild : 存在確認
            print("登録されてる？ -> \(snapShot.hasChild("Registered"))")
            
            if snapShot.hasChild("Registered"){
                //登録されている
            }
            else{
                //登録されてない
                self.ref.child("Users").child("\(userID)").setValue(["Registered" : "Yes","Comment": "未登録", "ID" : "未登録", "UserName" : username, "MyPlans" : ["Plan1"]])
                //mypageへセグエ → あとで！
                self.performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
            }
        }
        
        //謎
        let userRef = self.db.collection("Users")
        self.handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
        if user != nil {
          MeasurementHelper.sendLoginEvent()
          print("セグエするぞ〜")
          self.performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
        }
            print(type(of:  self.handle ))

      }
        
        
        
        //dbの一覧表示
//        databaseRef.observe(.childAdded, with: { snapshot in
//            dump(snapshot)
//            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
//           }
//        })
//

//
//        databaseRef.child("Users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//          // Get user value
//          let value = snapshot.value as? NSDictionary
//            _ = value?["username"] as? String ?? ""
////          let user = User(username: username)
//            print("ここだよ")
//
//          // ...
//          }) { (error) in
//            print(error.localizedDescription)
//        }
//        print("ユーザーのID")
//        print(uid)
//
//        let docRef1 = db.collection("Users").document("User1")
//        let docRef2 = db.collection("Destinations").document("Japan")
//
//        docRef1.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document dataですよ: \(dataDescription)")
//                print("キャノコ")
//            } else {
//                print("Document does not exist")
//                print("キャノコです")
//            }
//        }
//        docRef2.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document dataです: \(dataDescription)")
//                print("キャノコ〜〜〜〜")
//            } else {
//                print("Document does not exist")
//                print("キャノコですかい")
//            }
//        }
//
//        //AuthのID → Databaseのuserにいれば参照
//        print("セットして〜！")
//        // Add a new document in collection "cities"
        
//        let docRef_user = db.collection("Users").document("User1")

       
//        {(引数名1: 型, 引数名2: 型...) -> 戻り値の型 in
//          クロージャの実行時に実行される文
//          必要に応じてreturn文で戻り値を返却する
//        }
//        docRef_user.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        
    }

//  deinit {
//    if let handle = handle {
//      Auth.auth().removeStateDidChangeListener(handle)
//    }
//  }
}
