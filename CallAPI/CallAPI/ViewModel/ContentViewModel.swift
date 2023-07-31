//
//  ContentViewModel.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import Foundation

class ViewModel: ObservableObject {
    private var networkSession: NetworkInterface
    
    @Published var error: NetworkErrors?
    @Published var isError: Bool = false
    
    var url:URL?
    
    @Published var articles: [Article]? = []
    
    init(url: URL? = URL(string: "https://www.gdtr.fr")!, networkSession: NetworkInterface = NetworkSession()) {
        
        self.url = url
        self.networkSession = networkSession
    }
    
    func gettingUrl(search: String?) {
        createUrl(search: search) { result in
            switch result {
                case .success(let url):
                    self.url = url
                case .failure(let error):
                    self.error = error
                    self.isError = true
            }
        }
    }
    
    private func createUrl(search: String?, completionHandler: @escaping (Result<URL, NetworkErrors>) -> Void ) {
        guard let search = search else {
            completionHandler(.failure(.isNil))
            return
        }
        guard search != "" else {
            completionHandler(.failure(.empty))
            return
        }
        // Il faut s'assurer que tous les caractères classiques soient acceptés (Taïwan ne passe pas par exemple).
        guard let httpString = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completionHandler(.failure(.strangeCaracters))
            return
        }
        let url = URL(string: ApiData.url1 + httpString + ApiData.url2 + ApiData.apiKey)!
        
        completionHandler(.success(url))
    }
    
    @MainActor
    func getNews() async throws {
        guard let url = url else {
            self.error = error
            isError = true
            throw NetworkErrors.invalidURL
        }
        
        var responseData = Data()
        do {
            responseData = try await networkSession.fetchData(url: url)
        } catch {
            if let error = error as? NetworkErrors {
                self.error = error
                self.isError = true
                throw error
            }
        }
        
        do {
            let articlesResponse = try JSONDecoder().decode(NewsGot.self, from: responseData)
            articles = articlesResponse.articles
        } catch {
            throw NetworkErrors.decodingError
        }
    }
}
