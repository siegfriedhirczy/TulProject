//
//  ViewController.swift
//  Test AandP
//
//  Created by Siegfried Hirczy on 2/13/18.
//  Copyright © 2018 Siegfried Hirczy. All rights reserved.
//

import UIKit
let myNotificiationKey = "com.siegfriedhirczy.specialNotificationKey"

class ViewController: UIViewController, UITextViewDelegate {
    
    var wordArray = ["apple":["round", "red", "tasty"], "lemon":["oblong", "yellow", "sour"]]
    var buttonInfoDict = ["": false]
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segueButton: UIButton!
    
    @IBAction func segueButtonAct(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
//            // vc.keyWord = item.key
//            // vc.wordArray = item.value
//            present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
        
        // button for adding back to textview
        let printInfoButton = UIButton()
        printInfoButton.setTitle("Info button", for: .normal)
        printInfoButton.frame = CGRect(x: 100, y: 500, width: 40, height: 40)
        printInfoButton.backgroundColor = UIColor.green
        printInfoButton.addTarget(self, action: #selector(printInfo), for: .touchUpInside)
        self.view.addSubview(printInfoButton)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        // search for keywords and launch popover with associated information
        for item in wordArray {
            if textView.text.contains(item.key) {
                
                // replaces key to prevent retriggering
                textView.text = textView.text.replacingOccurrences(of: item.key, with: "KEY")
                
                // create popover of InputViewController
                let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
                let nav = UINavigationController(rootViewController: popoverContent)
                nav.modalPresentationStyle = .popover
                let popover = nav.popoverPresentationController
                popoverContent.preferredContentSize = CGSize(width: 400, height: 400)
                popover?.sourceView = self.view
                popover?.popoverLayoutMargins = UIEdgeInsets(top: 0.9, left: 0.9, bottom: 0.5, right: 0.5)
                popover?.sourceRect = CGRect(x: 500, y: 10, width: 10, height: 10)
                
                // information to send to InputViewController to generate visual elements
                popoverContent.keyWord = item.key
                popoverContent.wordArray = item.value
                
                // To Do: handling multiple calls to present/ finding multiple key words or no input after first keyword found
                present(nav, animated: true, completion: nil)
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: myNotificiationKey), object: self))
                print("posted")
                
            }
        }
    }
    
    @objc func printInfo() {
        buttonInfoDict.removeValue(forKey: "")
        for key in buttonInfoDict {
            var line = buttonInfoDict.popFirst()
            var lineP2 = ""
            if (line?.value)! {
                lineP2 = " - true"
            } else {
                lineP2 = " - false"
            }
            textView.text = textView.text + "\r" + (line?.0)! + lineP2
        
    }
    

}
}
