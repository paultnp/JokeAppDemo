//
//  JokeView.swift
//  JokeAppDemo
//
//  Created by Teenanath on 28/08/23.
//

import Foundation
import UIKit

protocol JokeView : AnyObject {
    func insertRowOnTop()
    func removeRowFromLast()
}
