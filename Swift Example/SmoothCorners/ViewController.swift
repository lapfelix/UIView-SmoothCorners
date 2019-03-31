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
        let blueView = SmoothView()

        redView.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        yellowView.backgroundColor = UIColor.yellow.withAlphaComponent(0.9)
        blueView.backgroundColor = UIColor.blue.withAlphaComponent(0.4)

        redView.frame = view.bounds.insetBy(dx: 20, dy: 50)
        yellowView.frame = redView.frame
        blueView.frame = redView.frame

        view.addSubview(redView)
        view.addSubview(yellowView)
        view.addSubview(blueView)

        let radius : CGFloat = 90.0

        // red view with regular corners
        redView.layer.cornerRadius = radius

        // using category/extension
        yellowView.flx_continuousCorners = true
        yellowView.layer.cornerRadius = radius

        // using subclass
        blueView.flx_smoothCorners = true
        blueView.layer.cornerRadius = radius

        let explanationLabel = UILabel()
        explanationLabel.frame = yellowView.frame
        explanationLabel.numberOfLines = 0
        explanationLabel.text = "Red = regular rounded corners\nBeige = smooth rounded corners"
        view.addSubview(explanationLabel)
    }
}

