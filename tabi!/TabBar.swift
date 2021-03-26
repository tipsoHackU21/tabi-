//
//  TabBar.swift
//  tabi!
//
//  Created by c_seikyo75 on 2021/03/26.
//

import Foundation
import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 選択時アイコンの色
        UITabBar.appearance().tintColor = AppColors.secondary
        // 非選択時アイコンの色
        UITabBar.appearance().unselectedItemTintColor = AppColors.background
        // 背景色
        UITabBar.appearance().barTintColor = AppColors.primary
    }

}
