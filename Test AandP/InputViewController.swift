//
//  InputViewController.swift
//  Test AandP
//
//  Created by Siegfried Hirczy on 2/13/18.
//  Copyright © 2018 Siegfried Hirczy. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    var keyWord = ""
    var wordArray = [""]
    var buttonInfoDict = ["" : false]

    // when user is done responding return response data to the presenting view controller
    @IBAction func dismissalButton(_ sender: Any) {
        if let presenter = presentingViewController as? ViewController {
            presenter.buttonInfoDict = buttonInfoDict
            presenter.printInfo()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func actOnSpecialNotification() {
        print("notified")
        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(InputViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: myNotificiationKey), object: nil)
        
        // set popover size
        self.preferredContentSize = CGSize(width: 400, height: 400)
        
        // construct label for keyWord
        let label = UILabel()
        label.frame = CGRect(x: 200, y: 50, width: 50, height: 25)
        label.text = keyWord
        self.view.addSubview(label)
        
        // construct buttons for each attribute in the array
        var y = 0
        for element in wordArray {
            let button = UIButton()
            button.frame = CGRect(x: 250, y: 100 + y, width: 50, height: 15)
            y = y + 30
            button.backgroundColor = UIColor.gray
            button.setTitle(element, for: .normal)
            button.addTarget(self, action: #selector(buttonInfoCollector), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    // responds to user input, press x1 -> true(green), press x2 -> false(red), press x3 -> unknown(gray)
    @objc func buttonInfoCollector (button: UIButton) {
        if button.backgroundColor == UIColor.gray {
            buttonInfoDict[button.currentTitle ?? ""] = true
            button.backgroundColor = UIColor.green
        } else if button.backgroundColor == UIColor.green {
            
            buttonInfoDict[button.currentTitle ?? ""] = false
            button.backgroundColor = UIColor.red
        } else {
            buttonInfoDict.removeValue(forKey: button.currentTitle!)
            button.backgroundColor = UIColor.gray
        }
    }
    
}
