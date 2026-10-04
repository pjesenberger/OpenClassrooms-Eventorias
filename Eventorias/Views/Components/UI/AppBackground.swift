//
//  AppBackground.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 28/08/2025.
//

import SwiftUI

struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    var appBackground: some View {
        self.modifier(AppBackgroundModifier())
    }
}
