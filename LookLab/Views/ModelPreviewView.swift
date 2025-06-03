//
//  ModelPreviewView.swift
//  LookLab
//
//  Created by Cera Wang on 2025-06-02.
//

import SwiftUI

struct ModelPreviewView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: "#FFE591"), Color(hex: "#FF99E5"), Color(hex: "#AD47FF")], startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea()
            
            HStack {
                // TODO: replace with actual model
                Text("🧍‍♀️")
                    .font(.system(size: 250))
                
                VStack{
                    VStack {
                        Button(action: {
                            // take off all outfits
                        }) {
                            Image(systemName: "arrow.trianglehead.clockwise")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#373539"))
                        }
                        
                        Button(action: {
                            // randomize outfit
                        }) {
                            Image(systemName: "dice.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#373539"))
                        }
                        
                        Button(action: {
                            // try on folder
                        }) {
                            Image(systemName: "folder.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#373539"))
                        }
                        
                        Button(action: {
                            // check out favourites
                        }) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#373539"))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ModelPreviewView()
}
