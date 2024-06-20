import SwiftUI

struct GreetingMessage : View {
    var title: String
    var body: some View {
        
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("watch your favourite movies here!")
                        .font(.body)
                }.padding(.trailing, 20)
                Spacer()
                NavigationLink{
                    ProfileImage()
                }label: {
                    AsyncImage(url: URL(string: "https://images.genius.com/f3f77222e1b615e0a10354ea6282ff22.1000x1000x1.png")) { state in
                        let imageSize : Double = 80
                        switch state {
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
}

#Preview {
    GreetingMessage(title: "ဟယ်လို")
}
