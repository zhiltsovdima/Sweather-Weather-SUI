//
//  MaterialEffectView.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct MaterialEffectView: UIViewRepresentable {
    var effect: UIVisualEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
