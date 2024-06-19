import SwiftUI

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ApiService {
    func fetchData<T: Decodable>(from endpoint: String, as type: T.Type) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYWY1MmQ5OGUxNTJiMmQ5MGI4NWM3YWUzZjgzNmIyNiIsInN1YiI6IjY2NmMxYWUzNTk1YjgwZmQ4NzcwZTg2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fQ03RnLaSKEaiKtHnbSkMcrgf8Re8zIGMdWhuGj09a4", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
}
