//
//  MorphingSymbolView.swift
//  ShapeMorphingEffect
//
//  Created by Solicy Ios on 30.07.24.
//

import SwiftUI

/// A view that animates a symbol morphing effect.
struct MorphingSymbolView: View {
    // The current symbol to display.
    var symbol: String
    // Configuration parameters for the view.
    var config: Config
    
    /// View Properties
    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""
    
    var body: some View {
        Canvas { ctx, size in
            // Apply an alpha threshold filter to the canvas context.
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            // Draw the rendered image if available.
            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            // The view that will be rendered as a symbol.
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue, newValue in
            // Trigger the animation when the symbol changes.
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            // Set the initial symbol to display.
            guard displayingSymbol.isEmpty else { return }
            displayingSymbol = symbol
        }
    }
    
    /// A view that animates the symbol using a keyframe animation.
    @ViewBuilder
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            // Create the symbol image with animation effects.
            Image(systemName: displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        // Perform the symbol change animation.
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = nextSymbol
                        }
                    }
                }
        } keyframes: { _ in
            // Define the animation keyframes.
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)
        }
    }
    
    /// Configuration parameters for the MorphingSymbolView.
    struct Config {
        var font: Font // The font of the symbol.
        var frame: CGSize // The size of the view.
        var radius: CGFloat // The blur radius during the animation.
        var foregroundColor: Color // The color of the symbol.
        var keyFrameDuration: CGFloat = 0.8 // Duration of each keyframe.
        var symbolAnimation: Animation = .smooth(duration: 0.8, extraBounce: 0) // Animation settings for symbol change.
    }
}

#Preview {
    MorphingSymbolView(symbol: "gearshape.fill", config: .init(font: .system(size: 100, weight: .bold), frame: CGSize(width: 250, height: 200), radius: 15, foregroundColor: .black))
}
