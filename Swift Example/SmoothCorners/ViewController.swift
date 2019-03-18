//
//  ViewController.swift
//  SmoothCorners
//
//  Created by Felix Lapalme on 2019-03-17.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let redView = UIView()
        let yellowView = UIView()

        redView.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        yellowView.backgroundColor = UIColor.yellow.withAlphaComponent(0.9)

        redView.frame = view.bounds.insetBy(dx: 20, dy: 50)
        yellowView.frame = redView.frame

        view.addSubview(redView)
        view.addSubview(yellowView)

        let radius : CGFloat = 90.0

        // red view with regular corners
        redView.layer.cornerRadius = radius

        // yellow view with smooth corners
        yellowView.flx_continuousCorners = true
        yellowView.layer.cornerRadius = radius

        let explanationLabel = UILabel()
        explanationLabel.frame = yellowView.frame
        explanationLabel.numberOfLines = 0
        explanationLabel.text = "Red = regular rounded corners\nYellow = smooth rounded corners"
        view.addSubview(explanationLabel)
    }
}

