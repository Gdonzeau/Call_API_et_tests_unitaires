//
//  SafariView.swift
//  CallAPI
//
//  Created by Guillaume on 31/07/2023.
//

import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
