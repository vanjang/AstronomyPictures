//
//  PictureDetailDescriptionView.swift
//  AstronomyPictures
//
//  Created by myung hoon on 22/01/2024.
//

import SwiftUI

struct TitleDescriptionView: View {
    @Binding var title: String
    @Binding var description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(Color.gray)
            
            Spacer(minLength: 4)
            
            Text(description)
                .font(.system(size: 17))
                .foregroundColor(Color.white)
        }
        .background(Color.white.opacity(0.0))
    }
}
