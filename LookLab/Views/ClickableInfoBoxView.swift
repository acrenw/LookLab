//
//  ClickableInfoBoxView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-02.
//

import SwiftUI

struct ClickableInfoBoxView: View {
    var text: String
    var onBoxPressed: () -> Void
    
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
            }
        }
        .onTapGesture {
            onBoxPressed()
        }
    }
}

#Preview {
    ClickableInfoBoxView(text: "Text", onBoxPressed: {})
}
