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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

  var window: UIWindow?
  var myNavigationController: UINavigationController?

  @available(iOS 9.0, *)
  func application(_ application: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }

  func application(_ application: UIApplication,
                   open url: URL,
                   sourceApplication: String?,
                   annotation: Any) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    if let error = error {
      print("Error \(error)")
      return
    }
    guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      Auth.auth().signIn(with: credential) { (user, error) in
        if let error = error {
          print("Error \(error)")
          return
        }
      }
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    // -----????????????????????????----- //
    changeNavigationBarColor()
    // -----????????????????????????----- //
    return true
  }
    
    // -----????????????????????????----- //
       func changeNavigationBarColor() {
           // ?????????Navigation Bar?????????????????????
           // Navigation Bar ?????????????????????
           UINavigationBar.appearance().barTintColor = AppColors.primary
           // Navigation Bar ?????????????????????
           UINavigationBar.appearance().tintColor = AppColors.secondary
           // Navigation Bar ????????????????????????????????????
           UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.background]
       }
       // -----????????????????????????----- //
    
    
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions
//        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//    FirebaseApp.configure()
//    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
//    GIDSignIn.sharedInstance().delegate = self
//    return true
//  }
}
