//
//  MovieDetailRemoteDataManager.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

//MARK: - protocol MovieDetailRemoteDataManagerInputProtocol
protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
    func getMovie(
        movieID: Int,
        success: @escaping ((MovieDetailResponse) -> ()),
        failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: MovieDetailRemoteDataManagerInputProtocol
final class MovieDetailRemoteDataManager: MovieDetailRemoteDataManagerInputProtocol {
    func getMovie(
        movieID: Int,
        success: @escaping ((MovieDetailResponse) -> ()),
        failure: @escaping ((NetworkErrors) -> ())) {
            
            let urlString = "\(Constants.API.URL.urlMainSite)\(Constants.API.Endpoints.urlEndpointDetailMovie)\(movieID)\(Constants.API.apiKeyParam)\(Constants.API.apiKeyValue)"
            //print("URL - getMovie: \(urlString)")
            
            guard let url = URL(string: urlString) else {
                failure(.urlError)
                return
            }
            
            let urlRequest = URLRequest(url: url)
            ConnectionManager.shared.getData(urlRequest: urlRequest) { data in
                do {
                    let decoder = JSONDecoder()
                    let movieDetailResponse = try decoder.decode(MovieDetailResponse.self, from: data)
                    let movie = movieDetailResponse
                    success(movie)
                } catch {
                    failure(.decodingJSONError)
                }
            } failure: { networkError in
                failure(networkError)
            }
        }
}
