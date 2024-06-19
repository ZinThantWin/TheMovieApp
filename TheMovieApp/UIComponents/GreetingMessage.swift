import SwiftUI

struct GreetingMessage : View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Hello ကိုနေကိုတိုး")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("watch your favourite movies here!")
                    .font(.body)
            }.padding(.trailing, 20)
            Spacer()
            AsyncImage(url: URL(string: "https://images.genius.com/f3f77222e1b615e0a10354ea6282ff22.1000x1000x1.png")) { phase in
                let imageSize : Double = 80
                switch phase {
                    
                case .empty:
                    Circle()
                        .frame(width: imageSize, height: imageSize).foregroundColor(.secondary)
                case .success(let image):
                    image.resizable()
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(Circle())
                case .failure(_):
                    Circle()
                        .background(Color.red)
                        .frame(width: imageSize, height: imageSize)
                @unknown default:
                    EmptyView()
                }
            }
            
        }
    }
}
