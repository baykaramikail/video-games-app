//
//  NetworkManager.swift
//  Video Games App
//
//  Created by Mikail Baykara on 9.01.2023.
//



import UIKit

protocol NetworkManagerDelegate{
    func getGames(model:[GameModel])
}

class NetworkManager{
    
    var delegate: NetworkManagerDelegate?
    private let apiKey = "d578fc59bae14c89908b8541b5014ee8"
    
    func getGames(page: Int){
        let urlString = "https://api.rawg.io/api/games?key=\(self.apiKey)&page=\(page)"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    print("Unable to complete your request. Please check your internet connection")
                    return
                }
                
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedData = try decoder.decode(GameData.self, from: data)
                        self.makeGameModel(gameData: decodedData)
                    }catch{
                        print("The data received from the server was invalid. Please try again.")
                    }
                }
            }.resume()
        }
    }
    
    func makeGameModel(gameData: GameData){
        var gameModel = [GameModel]()
        for i in 0..<gameData.results.count{
            let id = gameData.results[i].id
            let name = gameData.results[i].name
            let released = gameData.results[i].released
            let backgroundImage = gameData.results[i].backgroundImage
            let rating = gameData.results[i].rating
            
            
            let model = GameModel(id: id, name: name, released: released, backgroundImage: backgroundImage, rating: rating)
            gameModel.append(model)
        }
        self.delegate?.getGames(model: gameModel)
    }
    
    func getGameDescription(id: Int, label: UILabel){
        let apiKey = "d578fc59bae14c89908b8541b5014ee8"
        let urlString = "https://api.rawg.io/api/games/\(id)?key=\(apiKey)"
        
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil { return }
                guard let _ = response else { return }
                
                if let data = data{
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(GameDescription.self, from: data)
                        let str =  decodedData.description.removeHTMLtags
                        DispatchQueue.main.async {
                            label.text = str
                        }
                    }catch{
                        print("Error occured when getting game description.")
                    }
                }
            }.resume()
        }
    }
    
    func getScreenshots(id: Int, completion: @escaping ([Images]) -> Void){
        let urlString = "https://api.rawg.io/api/games/\(id)/screenshots?key=\(apiKey)"
        if let url = URL(string: urlString){
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {return }
                guard response != nil else { return }
                
                if let data = data{
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(Screenshot.self, from: data)
                        completion(decodedData.results)
                        
                    }catch{
                        print("there was an error while parsing screenshots")
                    }
                }
            }.resume()
        }
    }
    
}
