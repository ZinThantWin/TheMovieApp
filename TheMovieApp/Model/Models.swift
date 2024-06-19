import SwiftUI
import WebKit

struct MovieListModel : Codable ,Hashable {
    
    let results : [MovieModel]
}

struct MovieModel : Codable, Hashable {
    let id: Int
    let backdropPath : String
    let posterPath : String
    let title : String
    let popularity : Double
    let voteAverage : Double
    let voteCount : Int
    let overview : String
    
    static let sampleDefaultMovie = MovieModel(id: 78787,backdropPath: "/coATv42PoiLqAFKStJiMZs2r6Zb.jpg", posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg", title: "Inside Out 2", popularity: 9017.097, voteAverage: 7.9, voteCount: 300,overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.")
}


struct MovieTrailerList : Codable {
    let results : [MovieTrailers]
}

struct MovieTrailers : Codable, Hashable {
    let id : String
    let name : String
    let key : String
}

final class MovieViewModel: ObservableObject {
    @Published var selectedMovie: MovieModel?
    @Published var isSelected = false
}

struct YTVideo: UIViewRepresentable {
    let youtubeId: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(youtubeId)") else { return }
        
        DispatchQueue.global().async {
            let request = URLRequest(url: youtubeURL)
            DispatchQueue.main.async {
                uiView.scrollView.isScrollEnabled = false
                uiView.load(request)
            }
        }
    }
}

