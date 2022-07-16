//
//  RestClient.swift
//  ASBInterviewExercise
//
//  Created by ASB on 29/07/21.
//

import Foundation
import RxSwift

class APIRequest {
    
    public enum RequestType: String {
        case GET, POST, PUT,DELETE
    }
    
    let baseURL = URL(string: "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json")!
    var method = RequestType.GET
    
    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

class RestClient {
    
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func apiRequest<T: Decodable>(_ apiRequest: APIRequest) -> Observable<T> {
        
        return Observable.create { [weak self] observer in
            let request = apiRequest.request(with: apiRequest.baseURL)
            
            guard let weakSelf = self else {
                observer.onError(NSError(domain: "Something went wrong", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            
            let sessionTask = weakSelf.session.dataTask(with: request) { data, response, error in
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
            }
            sessionTask.resume()
            
            return Disposables.create {
                sessionTask.cancel()
            }
        }
        
        
    }
    
    func cancelAllTasks() {
        session.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
    }
}
