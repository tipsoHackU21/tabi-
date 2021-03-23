//
//  recruit.swift
//  tabi!
//
//  Created by 百塚真弥 on 2021/03/17.
//

import Foundation
import UIKit

import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase
import Firebase
import UIKit

var tableData = [[("キタテハ","タテハチョウ科"),("クロアゲハ","アゲハチョウ科"),("あ", "い")]]

class recruit: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //データベース
    var ref: DatabaseReference!
    var userName = Auth.auth().currentUser?.displayName
    fileprivate var _refHandle: DatabaseHandle!
    var messages: [DataSnapshot] = []
    
    // テーブルビューに表示するデータ
    let sectionTitle = ["作成中のプラン"]
    var section0 = [("キタテハ","タテハチョウ科")]
    
    // テーブルビューを作る
    let myTableView = UITableView(frame: CGRect(x:50,y:280,width:314,height:532), style: .grouped)
    
    @IBAction func appear(_ sender: Any) {
        
        // データの更新
        tableData = [section0]

        // テーブルビューのデリゲートを設定する
            myTableView.delegate = self
        // テーブルビューのデータソースを設定する
            myTableView.dataSource = self
        
        
        if(myTableView.isHidden==false){
            // テーブルビューを表示する
            view.addSubview(myTableView)
            myTableView.isHidden = !myTableView.isHidden
        }else{
            print("猫です")
            //tap = false
            myTableView.isHidden = !myTableView.isHidden
        }
    }
    
    
    //@IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        //プラン一覧を表示したい
        tableData = [section0]
        configureDatabase()
        tableData = [section0]
    }
    
    //データベース確認
    func configureDatabase() {
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
    // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Users/\(userID)/MyPlans").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                guard let strongSelf = self else { return }
            // プランをsection0に追加する
            self!.section0 = []
            strongSelf.messages.append(snapshot)
            print("個数 : \(strongSelf.messages.count)")
            var count = 0
            while count < strongSelf.messages.count {
                print("どうですかね")
                guard let x = strongSelf.messages[count].value as? String else { return }
                self!.section0.append((x, "プラン"))
                count += 1
            }
            print("どうですかああ\(self!.section0)")
            print("どうですかああ\(type(of : self!.section0))")
            
            
        })
        print("表示してくれええええええ\(self.messages)")
        
  }
    
    /*　UITableViewDataSourceプロトコル */
    // セクションの個数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
//        return 1
    }

    // セクションごとの行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
        print("行数\(messages.count)")
//        return messages.count
    }

    // セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
//        return "plans"
    }

    // セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.myTableView .dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
//        let sectionData = "セクション"
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }

    /* UITableViewDelegateデリゲートメソッド */
    // 行がタップされると実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData[indexPath.section]
        let cellData = sectionData[indexPath.row]
//        let cellData = messages[indexPath.row]
        print("\(title)\(cellData.1)")
        print("\(cellData.0)")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination.modalPresentationStyle = .fullScreen
//    }

}

