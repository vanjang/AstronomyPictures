//
//  PictureDetailView.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import SwiftUI

struct PictureDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        Image("test")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width, height: geo.size.width * 3/4)
                            .clipped()
                            .padding(.bottom, 10)

                        TitleDescriptionView(title: .constant("Very long title for test, very very long title"), description: .constant("Very long Description for test, very very long Description"))
                            .padding(.horizontal, 16)
                        
                        Spacer(minLength: 14)
                        
                        TitleDescriptionView(title: .constant("Date"), description: .constant("Description"))
                            .padding(.horizontal, 16)
                        
                        Spacer(minLength: 14)
                        
                        TitleDescriptionView(title: .constant("Explanation"), description: .constant("Explanation content comes here"))
                            .padding(.horizontal, 16)
                    }
                }
                .background(Color.black)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .accentColor(Color(.white))
                    }
                    ToolbarItem(placement: .principal) {
                        Text("title")
                            .font(.system(size: 17))
                            .foregroundColor(Color(.white))
                    }
                }
            }
        }
    }
}

struct PictureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PictureDetailView()
    }
}
