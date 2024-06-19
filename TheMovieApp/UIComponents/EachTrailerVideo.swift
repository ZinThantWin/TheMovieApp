import SwiftUI

struct EachTrailerVideo : View {
    @State var eachTrailer : MovieTrailers
    var body: some View {
        YTVideo(youtubeId: eachTrailer.key)
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.5)
            .background(Color.black)
            .cornerRadius(10)
    }
}
