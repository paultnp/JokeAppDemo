//
//  JokePresenter.swift
//  JokeAppDemo
//
//  Created by Teenanath on 28/08/23.
//

import Foundation

class JokePresenter : JokePresenterProtocol{
    weak var view: JokeView?
    var model: JokeModel
    
    init(view: JokeView, model: JokeModel) {
        self.view = view
        self.model = model
        self.loadJokesFromLocalSaved()
    }
    
    func fetchJoke() {
        let url = URL(string: JOKE_URL)!
        let request = URLRequest.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            if let _ = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                if let stringResponse = String.init(data: data, encoding: .utf8) {
                    print("stringResponse : ",stringResponse)
                    let jokeString = stringResponse.replacingOccurrences(of: "\"", with: "")
                    self.addJokeInArray(joke: jokeString)
                }
            }
        }.resume()
    }
    
    private func addJokeInArray(joke:String) {
        self.model.jokeArray.insert(joke, at: 0)
        self.view?.insertRowOnTop()

        if self.model.jokeArray.count > 10 {
            self.model.jokeArray.removeLast()
            self.view?.removeRowFromLast()
        }
        
        saveJokeInUserDefaults()
    }
    
    //Since only 10 records has to be saved to using UserDefaults
    //Writing on a plist/json file and saving in document directory can also be used
    private func saveJokeInUserDefaults() {
        UserDefaults.standard.setValue(self.model.jokeArray, forKey: LOCAL_SAVED_JOKES)
        UserDefaults.standard.synchronize()
    }
    
    private func loadJokesFromLocalSaved() {
        if let jokes =  UserDefaults.standard.value(forKey: LOCAL_SAVED_JOKES) as? [String] {
            self.model.jokeArray = jokes
        }
    }
}
