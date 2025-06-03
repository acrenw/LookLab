//
//  WardrobeView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-05-25.
//

import SwiftUI

struct WardrobeView: View {
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 0) {
            // Model Preview
            ModelPreviewView()
                .frame(height: expanded ? UIScreen.main.bounds.height : UIScreen.main.bounds.height / 2)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height < -50 {
                                expanded = false  // Swiped up
                            } else if value.translation.height > 50 {
                                expanded = true // Swiped down
                            }
                        }
                )

            // Wardrobe folders (hidden when expanded)
            if !expanded {
                WardrobeFolderView()
                    .frame(height: UIScreen.main.bounds.height / 2)
            }
        }
        .animation(.easeInOut, value: expanded)
        .ignoresSafeArea()
    }
}

#Preview {
    WardrobeView()
}
