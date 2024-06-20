import SwiftUI

struct HomeScreen : View {
    @State var nowPlayingMovies : MovieListModel?
    @State var upcomingMovies : MovieListModel?
    @State var topRatedMovies : MovieListModel?
    @State var popularMovies : MovieListModel?
    @State var trendingMovies : MovieListModel?
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    GreetingMessage(title: "Hello ကိုနေကိုတိုး")
                    EachHMovieList(movieList: nowPlayingMovies, movieListTitle: "Now Playing Movies")
                    EachHMovieList(movieList: upcomingMovies, movieListTitle: "Upcoming Movies")
                    EachHMovieList(movieList: popularMovies, movieListTitle: "Popular Movies")
                    EachHMovieList(movieList: topRatedMovies, movieListTitle: "TopRated Movies")
                    EachHMovieList(movieList: trendingMovies, movieListTitle: "Trending Movies")
                }
                .navigationBarBackButtonHidden(true)
                .padding(.horizontal,20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
}

