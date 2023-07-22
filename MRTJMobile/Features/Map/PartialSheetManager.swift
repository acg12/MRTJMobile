//
//  PartialSheetManager.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 22/07/23.
//

import Foundation
import SwiftUI
import Combine

enum PartialSheetStyle {
    case fixed(height: CGFloat)
    case percent(percentage: CGFloat)
    case minTopMargin(margin: CGFloat)
}

class PartialSheetManager: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var content: AnyView?

    private var cancellable: AnyCancellable?

    init() {
        cancellable = $isPresented
            .sink(receiveValue: { [weak self] isPresented in
                if !isPresented {
                    self?.content = nil
                }
            })
    }

    func showPartialSheet<Content: View>(content: Content, style: PartialSheetStyle) {
        let sheetContent: AnyView

        switch style {
        case .fixed(let height):
            sheetContent = AnyView(content.frame(height: height))
        case .percent(let percentage):
            sheetContent = AnyView(content.frame(height: UIScreen.main.bounds.height * percentage))
        case .minTopMargin(let margin):
            sheetContent = AnyView(content.padding(.top, margin))
        }

        self.content = sheetContent
        self.isPresented = true
    }

    func dismissPartialSheet() {
        self.isPresented = false
    }
}
