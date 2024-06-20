import SwiftUI

struct EachMovieDetail : View {
    @State var eachMovie : MovieModel
    @State var trailerVideoList : MovieTrailerList?
    var widgetWidth : Double = UIScreen.main.bounds.width
    var imageHeight : Double = UIScreen.main.bounds.height
    var body: some View {
        NavigationView{
            ZStack{
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(eachMovie.backdropPath)")){
                    phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: widgetWidth, height: imageHeight)
                    case .success(let image):
                        ZStack(alignment: .topLeading){
                            image.resizable()
                                .scaledToFill()
                                .frame(width: widgetWidth, height: imageHeight)
                            LinearGradient(colors: [Color.black.opacity(0.8),Color.black.opacity(0)], startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
                            
                                VStack(alignment: .leading){
                                    Text(eachMovie.title).padding(.horizontal, 20).padding(.top, 100)
                                        .font(.system(size: 50))
                                        .foregroundColor(.yellow)
                                        .fontWeight(.semibold).padding(.bottom, 10)
                                    Text(eachMovie.overview)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white).padding(.horizontal, 20)
                                    HStack{
                                        Text("Rating").padding(.trailing, 10)
                                            .font(.system(size: 20))
                                            .foregroundColor(.yellow)
                                        Text(String(eachMovie.voteAverage))
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                    }.padding(.top, 10).padding(.horizontal, 20)
                                    HStack{
                                        Text("Vote Count")
                                            .padding(.trailing, 10)
                                            .font(.system(size: 20))
                                            .foregroundColor(.yellow)
                                        Text(String(eachMovie.voteCount))
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                    }.padding(.horizontal, 20)
                                    HStack{
                                        Text("Popularity")
                                            .padding(.trailing, 10)
                                            .font(.system(size: 20))
                                            .foregroundColor(.yellow)
                                        Text(String(eachMovie.popularity))
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                    }.padding(.horizontal, 20)
                                    Spacer()
                                    if trailerVideoList != nil {
                                        if let trailer = trailerVideoList?.results {
                                            ScrollView(.horizontal) {
                                                LazyHStack(spacing: 10) {
                                                    ForEach(trailer, id: \.self) { video in
                                                        EachTrailerVideo(eachTrailer: video)
                                                    }
                                                }.padding(.horizontal, 20)
                                            }.frame(height: 300)
                                        } else {
                                            Text("No movies available")
                                        }
                                    }
                                }
                            }
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        Text("Unexpected error occured")
                    }}
                .frame(width: widgetWidth,height: imageHeight)
                .ignoresSafeArea()
            }
        }.task {
            await fetchTrailerVideos()
        }
    }
    
    func fetchTrailerVideos() async {
        
        do {
            trailerVideoList = try await ApiService().fetchData(from: "https://api.themoviedb.org/3/movie/\(eachMovie.id)/videos", as: MovieTrailerList.self)
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
