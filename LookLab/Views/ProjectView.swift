//
//  ProjectView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-02.
//

import SwiftUI

struct ProjectView: View {
//    @StateObject var viewModel = ProjectViewViewModel()
    var content: String // TODO: make into image
    var title: String
    
    // Handlers passed in from parent since we need to communicate with parent
    var onProjectTapped: () -> Void
    var onTitleTapped: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "#45404A"))
                    .frame(maxWidth: UIScreen.main.bounds.width / 3, minHeight: UIScreen.main.bounds.width / 3)
                
                Text(content)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
            }
            .onTapGesture {
                onProjectTapped()
            }
            Text(title)
                .foregroundColor(.white)
                .onTapGesture {
                    onTitleTapped()
                }
        }
        
        
    }
}

#Preview {
    ProjectView(content: "Content", title: "Title", onProjectTapped: {}, onTitleTapped: {})
}
