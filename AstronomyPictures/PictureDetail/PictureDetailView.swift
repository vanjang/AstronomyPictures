//
//  PictureDetailView.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import SwiftUI
import Kingfisher

struct PictureDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let item: MainAtronomyPictureCellItem.DetailItem
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        KFImage(item.url)
                            .placeholder{
                                   ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                               }
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width, height: geo.size.width * 3/4)
                            .padding(.bottom, 10)

                        Spacer(minLength: 14)
                        
                        TitleDescriptionView(title: "Date", description: item.date)
                            .padding(.horizontal, 16)
                            .accessibilityIdentifier("TitleDescriptionViewDate")
                        
                        Spacer(minLength: 14)
                        
                        TitleDescriptionView(title: "Explanation", description: item.explanation)
                            .padding(.horizontal, 16)
                            .accessibilityIdentifier("TitleDescriptionViewExplanation")
                        
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
                        .accessibilityIdentifier("PictureDetailViewCloseButton")
                    }
                    ToolbarItem(placement: .principal) {
                        Text(item.title)
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
        PictureDetailView(item: MainAtronomyPictureCellItem.DetailItem(url: URL(string: "https://picsum.photos/200/300")!, title: "Some Random Image", date: "2024-1-23", explanation: "Some brilliant random image explanation comes here"))
    }
}
