import Foundation

enum NetworkError: Error {
    case unexcpected(code: Int)
}

class NetworkService {
    
    func getHTML(for url: URL, completion: @escaping(Result<String, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { data, response , error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data, let content = String(data: data, encoding: .utf8) {
                    completion(.success(content))
                } else {
                    completion(.failure(NetworkError.unexcpected(code: -1)))
                }
            }
        }.resume()
    }
    
}
