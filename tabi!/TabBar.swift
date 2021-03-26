//
//  TabBar.swift
//  tabi!
//
//  Created by c_seikyo75 on 2021/03/26.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 選択時アイコンの色
        UITabBar.appearance().tintColor = AppColor.secondary
        // 非選択時アイコンの色
        UITabBar.appearance().unselectedItemTintColor = AppColor.background
        // 背景色
        UITabBar.appearance().barTintColor = AppColor.primary
    }

}
