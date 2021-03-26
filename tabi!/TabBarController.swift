//
//  TabBarController.swift
//  tabi!
//
//  Created by c_seikyo75 on 2021/03/26.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // -----＊＊追記部分＊＊----- //
        // アイコンの色を変更できます！
        UITabBar.appearance().tintColor = AppColor.secondary
        // 背景色を変更できます！
        UITabBar.appearance().barTintColor = AppColor.primary
        // -----＊＊追記部分＊＊----- //
    }

}

