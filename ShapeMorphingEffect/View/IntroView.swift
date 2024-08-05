//
//  IntroView.swift
//  ShapeMorphingEffect
//
//  Created by Solicy Ios on 30.07.24.
//

import SwiftUI

struct IntroView: View {
    
    /// The currently active page in the introduction view.
    @State private var activePage: Page = .page1
    
    var body: some View {
        
        GeometryReader { geometry in
            let size = geometry.size
            
            VStack {
                Spacer(minLength: 0)
                
                // Morphing symbol view with animation.
                MorphingSymbolView(
                    symbol: activePage.rawValue,
                    config: .init(
                        font: .system(size: 150, weight: .bold),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroundColor: .white
                    )
                )
                
                // Text contents view showing titles and subtitles.
                TextContents(size: size)
                
                Spacer(minLength: 0)
                
                // Indicator view showing page indicators.
                IndicatorView()
                
                // Continue button to navigate to the next page.
                ContinueButton()
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .background {
            // Background gradient.
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
    }
    /// View displaying titles, descriptions, and subtitles with animations.
    @ViewBuilder
    func TextContents(size: CGSize) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                // Display page titles.
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .lineLimit(1)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            // Sliding effect based on the active page.
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.6, extraBounce: 0.1), value: activePage)
            
            HStack(alignment: .top, spacing: 0) {
                // Display page descriptions.
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.description)
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .fontWeight(.regular)
                        .frame(width: size.width)
                        .multilineTextAlignment(.center)
                }
            }
            // Sliding effect based on the active page.
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.8, extraBounce: 0.1), value: activePage)
            .padding(.top, 8)
            
            HStack(alignment: .top, spacing: 0) {
                // Display page subtitles.
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.subTitle)
                        .font(.callout)
                        .foregroundStyle(.gray.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .frame(width: size.width)
                }
            }
            // Sliding effect based on the active page.
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 1, extraBounce: 0.1), value: activePage)
            .padding(.top, 6)
            
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    /// View displaying page indicators.
    @ViewBuilder
    func IndicatorView() -> some View {
        HStack(spacing: 6) {
            ForEach(Page.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.8, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
    
    /// Header view with navigation and skip buttons.
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                // Navigate to the previous page.
                activePage = activePage.previousPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("Skip") {
                // Skip to the final page.
                activePage = .page4
            }
            .fontWeight(.semibold)
            .opacity(activePage != .page4 ? 1 : 0)
        }
        .foregroundStyle(.white)
        .animation(.snappy(duration: 0.8, extraBounce: 0), value: activePage)
        .padding(15)
    }
    
    /// Continue button for navigating to the next page.
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            // Navigate to the next page.
            activePage = activePage.nextPage
        } label: {
            Text(activePage == .page4 ? "Login into PS App" : "Continue")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page4 ? 220 : 180)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.8, extraBounce: 0), value: activePage)
    }
}

#Preview {
    IntroView()
}
