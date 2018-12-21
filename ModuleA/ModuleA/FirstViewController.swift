//
//  FirstViewController.swift
//  ModuleA
//
//  Created by 赵一超 on 2018/12/20.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 40))
        label.text = "FirstViewController"
        label.textAlignment = .center
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
