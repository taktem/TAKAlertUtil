//
//  ViewController.swift
//  TAKAlertSample
//
//  Created by 西村 拓 on 2015/09/16.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func alertButtonTapped(sender: UIButton) {
        TAKAlertView.show(
            title: "Title",
            message: "Sample message.",
            buttonTitles: ["OK", "Cancel"]
        ).subscribeNext { index -> Void in
            print(index)
        }
    }
}
