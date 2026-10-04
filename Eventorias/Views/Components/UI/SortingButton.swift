//
//  SortingButton.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 30/08/2025.
//

import SwiftUI

struct SortingButton: View {
    @Binding var selectedSortOption: SortOption
    var image: Image? = Image("SortIcon")
    
    var body: some View {
        HStack {
            Menu {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Button(option.rawValue) {
                        selectedSortOption = option
                    }
                }
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 105, height: 35)
                    .foregroundColor(.appDarkGray)
                    .overlay(
                        HStack {
                            image?
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12)
                            
                            Text("Sort")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white)
                        }
                    )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var sortOption = SortOption.dateAsc
    SortingButton(selectedSortOption: $sortOption)
}
