import UIKit
import FirebaseDatabase

class chat: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!

    var databaseRef: DatabaseReference!
    
    let list = ["Aさん", "Bさん", "Cさん"]

    override func viewDidLoad() {
        super.viewDidLoad()
        

        /*databaseRef = Database.database().reference()

        databaseRef.observe(.childAdded, with: { snapshot in
            dump(snapshot)
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                let currentText = self.textView.text
                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })

        NotificationCenter.default.addObserver(self, selector: #selector(chat.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chat.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)*/

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*@IBAction func tappedSendButton(_ sender: Any) {
        view.endEditing(true)

        if let name = nameInputView.text, let message = messageInputView.text {
            let messageData = ["name": name, "message": message]
            databaseRef.childByAutoId().setValue(messageData)

            messageInputView.text = ""
        }
    }

    @objc func keyboardWillShow(_ notification: NSNotification){
        if let userInfo = notification.userInfo, let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            inputViewBottomMargin.constant = keyboardFrameInfo.cgRectValue.height
        }

    }

    @objc func keyboardWillHide(_ notification: NSNotification){
        inputViewBottomMargin.constant = 0
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        Cell.textLabel!.text = list[indexPath.row]
        return Cell
    }

}
