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

@objc(SignInViewController)
class SignInViewController: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
  var handle: AuthStateDidChangeListenerHandle?
    
    var databaseRef: DatabaseReference! = Database.database().reference()
//    var db: Firestore! = Firestore.firestore()
    var db: Firestore!
    //読み取り
    var ref: DatabaseReference!
    
       
    
    override func viewDidLoad() {
      super.viewDidLoad()
      GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        var userdesu2 = Auth.auth().currentUser?.displayName;
        print("ユーザー情報")
        print(userdesu2)
        db = Firestore.firestore()
        let userRef = db.collection("Users")
      handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
        if user != nil {
          MeasurementHelper.sendLoginEvent()
          print("セグエするぞ〜")
          self.performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
        }
      }
        
        //dbの一覧表示
        databaseRef.observe(.childAdded, with: { snapshot in
            dump(snapshot)
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
           }
        })
        //ユーザーのID
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("ユーザーのID")
        print(uid)

        let docRef1 = db.collection("Users").document("User1")
        let docRef2 = db.collection("Destinations").document("Japan")

        docRef1.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document dataですよ: \(dataDescription)")
                print("キャノコ")
            } else {
                print("Document does not exist")
                print("キャノコです")
            }
        }
        docRef2.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document dataです: \(dataDescription)")
                print("キャノコ〜〜〜〜")
            } else {
                print("Document does not exist")
                print("キャノコですかい")
            }
        }
        
        //AuthのID → Databaseのuserにいれば参照
        print("セットして〜！")
        // Add a new document in collection "cities"
        
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
        
        //AuthのID → いなければ追加 → 登録画面
    }

  deinit {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}
