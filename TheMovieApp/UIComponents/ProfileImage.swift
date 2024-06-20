//
//  ProfileImage.swift
//  TheMovieApp
//
//  Created by ကင်ဇို on 20/06/2024.
//

import SwiftUI

struct ProfileImage: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.ignoresSafeArea()
                AsyncImage(url: URL(string: "https://images.genius.com/f3f77222e1b615e0a10354ea6282ff22.1000x1000x1.png")){phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.width * 0.8,
                                   height: UIScreen.main.bounds.width * 0.8)
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: UIScreen.main.bounds.width * 0.8,
                                   height: UIScreen.main.bounds.width * 0.8)
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        Text("Unexpected Error Occured")
                    }
                    
                }
            }
        }.navigationTitle("Profile Image")
            
    }
}

#Preview {
    ProfileImage()
}
