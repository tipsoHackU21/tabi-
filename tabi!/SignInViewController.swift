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

@objc(SignInViewController)
class SignInViewController: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
  var handle: AuthStateDidChangeListenerHandle?
    
    var databaseRef: DatabaseReference! = Database.database().reference()
    var db: Firestore! = Firestore.firestore()
       
    
    override func viewDidLoad() {
      super.viewDidLoad()
      GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        var userdesu2 = Auth.auth().currentUser?.displayName;
        print("ユーザー情報")
        print(userdesu2)
        
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
        db.collection("Users").whereField("ID", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }

        //AuthのID → Databaseのuserにいれば参照
        
        //AuthのID → いなければ追加 → 登録画面
    }

  deinit {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}
