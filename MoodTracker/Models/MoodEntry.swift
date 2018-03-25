//
//  MoodEntry.swift
//  MoodTracker
//
//  Created by Kelly Morales on 3/24/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

public enum Moods: Int {
    case worst = 0
    case worse
    case average
    case better
    case best
}

public class MoodEntry {

    private var mood: Moods = .average
    
    public init(mood: Moods) {
        self.mood = mood
    }
    
    func changeMood(to mood: Moods) {
        self.mood = mood
    }
    
    func getText() -> String {
        switch mood {
        case .worst: return .Mood_Worst
        case .worse: return .Mood_Worse
        case .average: return .Mood_Average
        case .better: return .Mood_Better
        case .best: return .Mood_Best
        }
    }
    
    func getColor() -> UIColor {
        switch mood {
        case .worst: return .purple
        case .worse: return .blue
        case .average: return .green
        case .better: return .orange
        case .best: return .red
        }
    }
}
