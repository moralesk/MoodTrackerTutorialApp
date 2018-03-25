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
    var moodEntry = MoodEntry(mood: .average)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .Entry_Title
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
        greetingLabel.text = .Entry_GreetingLabelText
        self.view.addSubview(greetingLabel)
    }

    func setupMoodLabel() {
        moodLabel.frame = CGRect(x: 50, y: 300, width: 280, height: 50)
        moodLabel.font = UIFont.systemFont(ofSize: 20.0)
        moodLabel.textAlignment = .center
        moodLabel.text = moodEntry.getText()
        moodLabel.textColor = moodEntry.getColor()
        self.view.addSubview(moodLabel)
    }

    func setupSlider() {
        let slider = UISlider(frame: CGRect(x: 50, y: 260, width: 280, height: 20))
        slider.minimumValue = 0
        slider.maximumValue = 4
        slider.isContinuous = true
        slider.value = 2
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(slider)
    }

    func setupSubmitButton() {
        let submitButton = UIButton(frame: CGRect(x: 90, y: 370, width: 200, height: 60))
        submitButton.backgroundColor = UIColor.blue
        submitButton.layer.cornerRadius = 3.0
        submitButton.setTitle(.Entry_SubmitButtonText, for: .normal)
        submitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(submitButton)
    }

    // MARK: Selectors
    @objc func sliderValueChanged(_ sender: UISlider!) {
        // snaps slider to integer value
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        
        guard let mood = Moods(rawValue: Int(roundedValue)) else {
            return
        }
        moodEntry.changeMood(to: mood)
        moodLabel.text = moodEntry.getText()
        moodLabel.textColor = moodEntry.getColor()
    }

    @objc func buttonTapped() {
        entries.append(moodEntry)
        navigationController?.popViewController(animated: true)
    }
}
