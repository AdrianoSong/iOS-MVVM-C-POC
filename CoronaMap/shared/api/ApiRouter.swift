//
//  ApiRouter.swift
//  CoronaMap
//
//  Created by Adriano Song on 4/2/20.
//  

import Foundation
import Alamofire

protocol ApiRouterProtocol: URLRequestConvertible {
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }

    func asURLRequest() throws -> URLRequest
}

///The header fields
enum HttpHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

///The content type (JSON)
enum ContentType: String {
    case json = "application/json"
}

///You can Create specific ApiRouter (ex: User) each one needs to conform ApiRouterProtocol
enum ApiRouter: ApiRouterProtocol {

    // MARK: - Endpoints
    case getAllBrazilCoronaData

    var path: String {
        switch self {
        case .getAllBrazilCoronaData:
            return ""
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getAllBrazilCoronaData:
            return nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAllBrazilCoronaData:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        //baseURL on this sample baseUrl is in project Build Settings
        let baseUrl =
            try "https://api.apify.com/v2/key-value-stores/TyToNta7jGKkpszMZ/records/LATEST?disableRedirect=true"
                .asURL()
        var urlRequest = URLRequest(url: baseUrl)

        urlRequest.httpMethod = method.rawValue

        //Request header
        urlRequest.setValue(ContentType.json.rawValue,
                                forHTTPHeaderField: HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue,
                                forHTTPHeaderField: HttpHeaderField.contentType.rawValue)

        // parameter enconding
        let enconding: ParameterEncoding = {
            return URLEncoding.default
        }()

        return try enconding.encode(urlRequest, with: parameters)
    }
}
