//
//  CustomSearchBar.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 30/08/2025.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    var hasCancel: Bool = true
    var action: () -> ()
    var onCancel: () -> ()
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 100)
                .frame(height: 35)
                .foregroundColor(.appDarkGray)
                .overlay(
                    HStack {
                        Image("SearchIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                        
                        TextField("Search", text: $searchText, prompt: Text("Search").foregroundColor(.white))
                            .onChange(of: searchText) {
                                action()
                            }
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white)
                            .submitLabel(.search)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    CustomSearchBar(
        searchText: $searchText,
        action: {},
        onCancel: {}
    )
}
