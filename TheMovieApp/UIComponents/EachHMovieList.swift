import SwiftUI

struct EachHMovieList: View {
    @State var movieList : MovieListModel?
    let movieListTitle : String
    var body: some View{
        VStack(alignment: .leading){
            Text(movieListTitle)
                .font(.title)
                .fontWeight(.semibold)
            if let movies = movieList?.results {
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(movies, id: \.id) { movie in
                                        EachNowPlayingMovies(eachMovieModel: movie)
                                    }
                                }
                            }.frame(height: 300)
                        } else {
                            Text("No movies available")
                        }
        }.padding(.bottom, 30)
    }
}
