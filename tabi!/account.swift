import UIKit
import Foundation
import FirebaseAuth

class account: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //リスナーをアタッチ
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        //リスナーをデタッチ
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }


}

var handle: AuthStateDidChangeListenerHandle?

