//
//  JokePresenterProtocol.swift
//  JokeAppDemo
//
//  Created by Teenanath on 28/08/23.
//

import Foundation

protocol JokePresenterProtocol {
    var model: JokeModel { get set }
    func fetchJoke()
}
