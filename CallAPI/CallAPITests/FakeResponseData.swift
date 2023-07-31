//
//  FakeResponseData.swift
//  CallAPITests
//
//  Created by Guillaume on 31/07/2023.
//

import Foundation

class FakeResponseData { // Les différentes réponses possibles du call API

    static let responseOk = HTTPURLResponse(url: URL(string: "https://www.adresse.com")!, // La réponse renvoie un statut 200, tout va bien
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!
    
    static let responseKo = HTTPURLResponse(url: URL(string: "https://www.adresse.com")!, // La réponse renvoie un statut de code différent de 200 : une erreur
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)!
    
    class NewsError: Error {}
    static let error = NewsError() // On simule une erreur d'une manière générale
    
    static var NewsCorrectData: Data { // Les données renvoyées sont correctes et contiennent une informations
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DataNews", withExtension: "json")!
        let data = try! Data(contentsOf: url) // URL déballée de force car dossier présent
        return data
    }
    
    static let NewsIncorrectData = "Mauvaises données".data(using: .utf8)! // Les données renvoyées sont incorrectes et ne correspondent à rien
    
    static var correctURL: URL {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DataNews", withExtension: "json")!
        return url
    }
    
    static var urlForRightData: URL {
        let url = URL(string: "SendRightData")!
        return url
    }
    
    static var urlForBadData: URL {
        let url = URL(string: "SendBadData")!
        return url
    }
    
    static var urlForBasResponse: URL {
        let url = URL(string: "BadResponse")!
        return url
    }
}
