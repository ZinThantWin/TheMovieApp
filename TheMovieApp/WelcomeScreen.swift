import SwiftUI

struct WelcomeScreen: View {
    
    @State private var nowPlayingMovies: MovieListModel?
    @State private var upcomingMovies: MovieListModel?
    @State private var popularMovies: MovieListModel?
    @State private var topRatedMovies: MovieListModel?
    @State private var trendingMovies: MovieListModel?
    @State private var isFetching = false
    @State private var showHomeScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isFetching {
                    ProgressView()
                } else {
                    Button("Fetch Movies and move to home screen") {
                        Task {
                        
                                isFetching = true
//                                defer { isFetching = false }
                            await fetchNowPlayingMovies()
                            await fetchUpcomingMovies()
                            await fetchTopRatedMovies()
                            await fetchPopularMovies()
                            await fetchTrendingMovies()
                            showHomeScreen = true
                        }
                    }
                }
                NavigationLink(destination: HomeScreen(nowPlayingMovies: nowPlayingMovies,upcomingMovies: upcomingMovies,topRatedMovies: topRatedMovies,popularMovies: popularMovies,trendingMovies: trendingMovies), isActive: $showHomeScreen) {
                    EmptyView()
                }
            }
            
        }
    }
    
    func fetchNowPlayingMovies() async {
        
        do {
            nowPlayingMovies = try await ApiService().fetchData(from: "https://api.themoviedb.org/3/movie/now_playing", as: MovieListModel.self)
        } catch ApiError.invalidResponse {
            print("response error")
        } catch ApiError.invalidData {
            print("data error")
        } catch ApiError.invalidURL {
            print("url error")
        } catch {
            print("error")
        }
    }
    
    func fetchUpcomingMovies() async {
        
        do {
            upcomingMovies = try await ApiService().fetchData(from: "https://api.themoviedb.org/3/movie/upcoming", as: MovieListModel.self)
        } catch ApiError.invalidResponse {
            print("response error")
        } catch ApiError.invalidData {
            print("data error")
        } catch ApiError.invalidURL {
            print("url error")
        } catch {
            print("error")
        }
    }
    
    func fetchTopRatedMovies() async {
        
        do {
            topRatedMovies = try await ApiService().fetchData(from: "https://api.themoviedb.org/3/movie/top_rated", as: MovieListModel.self)
        } catch ApiError.invalidResponse {
            print("response error")
        } catch ApiError.invalidData {
            print("data error")
        } catch ApiError.invalidURL {
            print("url error")
        } catch {
            print("error")
        }
    }
    
    func fetchPopularMovies() async {
        
        do {
            popularMovies = try await ApiService().fetchData(from: "https://api.themoviedb.org/3/movie/popular", as: MovieListModel.self)
        } catch ApiError.invalidResponse {
            print("response error")
        } catch ApiError.invalidData {
            print("data error")
        } catch ApiError.invalidURL {
            print("url error")
        } catch {
            print("error")
        }
    }
    
    func fetchTrendingMovies() async {
        
        do {
            trendingMovies = try await ApiService().fetchData(from: "https://api.themoviedb.org/3/trending/movie/week", as: MovieListModel.self)
        } catch ApiError.invalidResponse {
            print("response error")
        } catch ApiError.invalidData {
            print("data error")
        } catch ApiError.invalidURL {
            print("url error")
        } catch {
            print("error")
        }
    }
}

#Preview {
    WelcomeScreen()
}
