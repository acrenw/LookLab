//
//  InfoBoxView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-02.
//

import SwiftUI

struct InfoBoxView: View {
    var text: String
    var data: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(hex: "#45404A"))
                .frame(maxWidth: .infinity, maxHeight: 35)
            HStack {
                Text(text)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                Text(data)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    InfoBoxView(text: "Text", data: "Data")
}
