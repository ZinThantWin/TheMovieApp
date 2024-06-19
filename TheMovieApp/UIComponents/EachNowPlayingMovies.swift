import SwiftUI

struct EachNowPlayingMovies: View {
    @State var eachMovieModel: MovieModel
    @StateObject var viewModel = MovieViewModel()
    var widgetWidth: Double = 200
    var imageHeight: Double = 300
    
    var body: some View {
        
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(eachMovieModel.posterPath)")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: widgetWidth, height: imageHeight)
            case .success(let image):
                ZStack(alignment: .topLeading) {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: widgetWidth, height: imageHeight)
                        .cornerRadius(5)
                    
                    HStack{
                        Text(String(eachMovieModel.voteAverage))
                            .padding(6)
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(3)
                        Spacer()
                        Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.blue)
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                            .onTapGesture {
                                viewModel.selectedMovie = eachMovieModel
                                viewModel.isSelected = true
                            }
                    }
                }
                
            case .failure(let error):
                Text(error.localizedDescription)
            @unknown default:
                Text("Unexpected error occurred")
            }
        }
        
        
        
        .fullScreenCover(isPresented: $viewModel.isSelected) {
            EachMovieDetail(eachMovie: viewModel.selectedMovie ?? eachMovieModel, isPresenting: $viewModel.isSelected)
        }
        .frame(width: widgetWidth, height: imageHeight)
    }
}
