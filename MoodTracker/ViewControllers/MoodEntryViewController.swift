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

    // MARK: UI Properties
    private let greetingLabel = UILabel()
    private let moodLabel = UILabel()
    private let slider = UISlider()
    private let submitButton = UIButton()

    // MARK: Data Properties
    private var moodEntry = MoodEntry(mood: .average)
    private let minSliderValue = Moods.worst.rawValue
    private let maxSliderValue = Moods.best.rawValue
    private let defaultSliderValue = Moods.average.rawValue

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .Entry_Title
        self.view.backgroundColor = UIColor.white
        setupGreetingLabel()
        setupSlider()
        setupMoodLabel()
        setupSubmitButton()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        setGreetingLabelConstraints()
        setSliderConstraints()
        setMoodLabelConstraints()
        setSubmitButtonConstraints()
    }

    // MARK: View Initializers
    private func setupGreetingLabel() {
        greetingLabel.font = UIFont.systemFont(ofSize: 26)
        greetingLabel.textAlignment = .center
        greetingLabel.text = .Entry_GreetingLabelText
        self.view.addSubview(greetingLabel)
        setGreetingLabelConstraints()
    }

    private func setupSlider() {
        slider.minimumValue = Float(minSliderValue)
        slider.maximumValue = Float(maxSliderValue)
        slider.isContinuous = true
        slider.value = Float(defaultSliderValue)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(slider)
        setSliderConstraints()
    }

    private func setupMoodLabel() {
        moodLabel.font = UIFont.systemFont(ofSize: 20.0)
        moodLabel.textAlignment = .center
        moodLabel.text = moodEntry.getText()
        moodLabel.textColor = moodEntry.getColor()
        self.view.addSubview(moodLabel)
        setMoodLabelConstraints()
    }

    private func setupSubmitButton() {
        submitButton.backgroundColor = UIColor.blue
        submitButton.layer.cornerRadius = 3.0
        submitButton.setTitle(.Entry_SubmitButtonText, for: .normal)
        submitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(submitButton)
        setSubmitButtonConstraints()
    }

    // MARK: Constraint Helpers
    private func setGreetingLabelConstraints() {
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.topMargin, multiplier: 2, constant: 0)
        let width = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: greetingLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }

    private func setSliderConstraints() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: slider, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: slider.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: slider, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: greetingLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 35)
        let width = NSLayoutConstraint(item: slider, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: slider.superview, attribute: NSLayoutAttribute.width, multiplier: 0.8, constant: 0)
        let height = NSLayoutConstraint(item: slider, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: slider.superview, attribute: NSLayoutAttribute.height, multiplier: 0.05, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }

    private func setMoodLabelConstraints() {
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: moodLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: moodLabel.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: moodLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: slider, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 5)
        let width = NSLayoutConstraint(item: moodLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: moodLabel.superview, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: moodLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: moodLabel.superview, attribute: NSLayoutAttribute.height, multiplier: 0.1, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }

    private func setSubmitButtonConstraints() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: submitButton.superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: moodLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 25)
        let width = NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: submitButton.superview, attribute: NSLayoutAttribute.width, multiplier: 0.5, constant: 0)
        let height = NSLayoutConstraint(item: submitButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: submitButton.superview, attribute: NSLayoutAttribute.height, multiplier: 0.08, constant: 0)
        NSLayoutConstraint.activate([centerX, top, width, height])
    }

    // MARK: Selectors
    @objc private func sliderValueChanged(_ sender: UISlider!) {
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

    @objc private func buttonTapped() {
        entries.append(moodEntry)
        navigationController?.popViewController(animated: true)
    }
}
