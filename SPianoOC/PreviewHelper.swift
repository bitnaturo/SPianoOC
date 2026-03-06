//
//  PreviewHelper.swift
//  SPianoOC
//
//  Created by Nick on 3/5/26.
//

import SwiftUI

struct VCPreview<T: UIViewController>: UIViewControllerRepresentable {

    let builder: () -> T

    init(_ builder: @escaping () -> T) {
        self.builder = builder
    }

    func makeUIViewController(context: Context) -> T {
        return builder()
    }

    func updateUIViewController(_ vc: T, context: Context) {}
}
