//
//  CustomBackToolbar.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 28/08/2025.
//

import SwiftUI

struct CustomBackToolbar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    var text: String? = nil

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        BarBackButton(text: text)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func customBackToolbar(text: String? = nil) -> some View {
        self.modifier(CustomBackToolbar(text: text))
    }
}
