//
//  SchoolApiService.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import Foundation

// MARK: - Interface
protocol ISchoolsApi {
    func loadSchoolData(completion:@escaping (Result<[School], Error>) -> ())
    func loadSatData(completion:@escaping (Result<[SatData], Error>) -> ())
}

// MARK: - Implementation
class SchoolsApi: ISchoolsApi, ObservableObject {
    
    let urlSession: URLSession
    @Published var schools = [School]()
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    //to improve performance, we can page the data as the api supports paging via the $limit and $offset query parameters
    func loadSchoolData(completion:@escaping (Result<[School], Error>) -> ()){
        guard let url = URL(string: SCHOOLS_API_ENDPOINT) else {
            //log the error using logging utility
            Logger.error(msg: "bad url", error: ApiResponseError.badUrl as NSError)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            // process the response on the main thread
            DispatchQueue.main.async {
                do{
                    // Check if any error occurred.
                    if let error = error {
                        throw error
                    }
                    
                    // Check response code.
                    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                        completion(.failure(ApiResponseError.network))
                        return
                    }
                    
                    // Check data is not null
                    if let data = data {
                        if var schools = try? JSONDecoder().decode([School].self, from: data) {
                            Logger.info(message: "retrieved \(schools.count) colleges from api")
                            schools.sort{
                                $0.school_name < $1.school_name
                            }
                            completion(.success(schools))
                        }else{
                            completion(.failure(ApiResponseError.parsing))
                        }
                    }else{
                        completion(.failure(ApiResponseError.nodata))
                    }
                    
                }catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func loadSatData(completion:@escaping (Result<[SatData], Error>) -> ()){
        guard let url = URL(string: SAT_API_ENDPOINT) else {
            //log the error using logging utility
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            // process the response on the main thread
            DispatchQueue.main.async {
                do{
                    // Check if any error occurred.
                    if let error = error {
                        throw error
                    }
                    
                    // Check response code.
                    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                        completion(.failure(ApiResponseError.network))
                        return
                    }
                    
                    // Check data is not null
                    if let data = data {
                        do {
                            let satData = try JSONDecoder().decode([SatData].self, from: data)
                            Logger.info(message: "retrieved \(satData.count) sat data from api")
                            completion(.success(satData))
                        }catch let jsonError as NSError {
                            Logger.error(msg: jsonError.localizedDescription, error: jsonError)
                            completion(.failure(ApiResponseError.parsing))
                        }
                    }else{
                        completion(.failure(ApiResponseError.nodata))
                    }
                }catch {
                    completion(.failure(error))
                }
                
            }
        }.resume()
    }
}

enum ApiResponseError : Error {
    case network
    case parsing
    case badUrl
    case request
    case nodata
}
