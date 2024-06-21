

import SwiftUI

struct ProfileImage: View {
    @State var image : Image
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.ignoresSafeArea()
                image.resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: UIScreen.main.bounds.width * 0.8,
                           height: UIScreen.main.bounds.width * 0.8)
            }
        }.navigationTitle("Profile Image")
            
    }
}
