//
//  MoodEntryViewController.swift
//  MoodTracker
//
//  Created by Kelly Morales on 3/16/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

class MoodEntryViewController: UIViewController {
    
    let moodLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NEW ENTRY"
        self.view.backgroundColor = UIColor.white
        setupGreetingLabel()
        setupSlider()
        setupMoodLabel()
        setupSubmitButton()
    }
    
    // MARK: Helpers
    func setupGreetingLabel() {
        let greetingLabel = UILabel(frame: CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: 80))
        greetingLabel.font = UIFont.systemFont(ofSize: 26)
        greetingLabel.textAlignment = .center
        greetingLabel.text = "HOW ARE YOU FEELING?"
        self.view.addSubview(greetingLabel)
    }
    
    func setupMoodLabel() {
        moodLabel.frame = CGRect(x: 50, y: 300, width: 280, height: 50)
        moodLabel.font = UIFont.systemFont(ofSize: 20.0)
        moodLabel.textAlignment = .center
        moodLabel.text = "CONTENT"
        moodLabel.textColor = UIColor.green
        self.view.addSubview(moodLabel)
    }
    
    func setupSlider() {
        let slider = UISlider(frame: CGRect(x: 50, y: 260, width: 280, height: 20))
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.isContinuous = true
        slider.value = 3
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(slider)
    }
    
    func setupSubmitButton() {
        let submitButton = UIButton(frame: CGRect(x: 90, y: 370, width: 200, height: 60))
        submitButton.backgroundColor = UIColor.blue
        submitButton.layer.cornerRadius = 3.0
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(submitButton)
    }
    
    // MARK: Selectors
    @objc func sliderValueChanged(_ sender: UISlider!) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        switch roundedValue {
        case 1:
            moodLabel.text = "AWFUL"
            moodLabel.textColor = UIColor.purple
        case 2:
            moodLabel.text = "SUBPAR"
            moodLabel.textColor = UIColor.blue
        case 3:
            moodLabel.text = "CONTENT"
            moodLabel.textColor = UIColor.green
        case 4:
            moodLabel.text = "GREAT"
            moodLabel.textColor = UIColor.orange
        case 5:
            moodLabel.text = "WONDERFUL"
            moodLabel.textColor = UIColor.red
        default:
            moodLabel.text = "CONTENT"
            moodLabel.textColor = UIColor.green
        }
    }
    
    @objc func buttonTapped() {
        guard let text = moodLabel.text else {
            // ensures text != nil
            return
        }
        entries.append((text, moodLabel.textColor))
        navigationController?.popViewController(animated: true)
    }
}
