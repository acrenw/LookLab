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
            
            VStack {
                Spacer()
                
                ZStack(alignment: .bottom) {
                    // TODO: replace with actual model
                    Text("🧍‍♀️")
                        .font(.system(size: 250))
                    
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
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 30)
                    .padding(.trailing, 60)
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(maxWidth: UIScreen.main.bounds.width / 3, maxHeight: 7, alignment: .bottom)
                    .padding()
            }
            
        }
    }
}

#Preview {
    ModelPreviewView()
}
