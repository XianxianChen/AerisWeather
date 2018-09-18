//
//  WeatherAPIClient.swift
//  AerisWeather
//
//  Created by C4Q on 9/18/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    // let count = arc4random_uniform(UInt32(12))
    func getWeather(from zipCode: String,
                    completionHandler: @escaping (InfoDict) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        let id = "dXsE5ICRAWLZCHTOh4Kga"
        
        //let secret = "flNjrasuBJ1FdjEXfcV9IKxeGgSTXdvEM1zqJFVJ"
       let secret =  "ckPhPCB4FUWNmoOflEBNJyTT1BZGWRg5samqOerZ"
        
        let urlStr = "https://api.aerisapi.com//forecasts/\(zipCode)?client_id=\(id)&client_secret=\(secret)"
        
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL(str: urlStr)); return }
        let request = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let result = try JSONDecoder().decode(WeatherInfo.self, from: data)
                guard !result.response.isEmpty else {
                    errorHandler(AppError.noData)
                    return
                }
                let infoDict = result.response[0]
                print("===============\n)")
                completionHandler(infoDict)
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
        
    }
}

