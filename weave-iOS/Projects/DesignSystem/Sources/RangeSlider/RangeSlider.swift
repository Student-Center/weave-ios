//
//  RangeSlider.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/5/24.
//

import SwiftUI

public struct RangeSlider<V: BinaryFloatingPoint>: View {
    // MARK: - Properties

    /// The value of thumb on the left-hand-side.
    @Binding var lowValue: V

    /// The value of thumb on the right-hand-side.
    @Binding var highValue: V

    /// The zIndex for the thumb on the right-hand-side.
    @State private var zIndexRHS: Double = 0

    /// The x-coordinate at the start of a drag gesture.
    @State private var startX: CGFloat? = nil

    /// The title of the slider that is currently being displayed.
    @State private var displayTitle: String

    /// An optional title for the slider.
    let title: String?

    /// The range of the valid values.
    let bounds: ClosedRange<Double>

    /// An optional display range.
    let displayBounds: ClosedRange<Double>?

    /// The distance between each value. Defaults to nil.
    let step: V?

    /// Whether or not to display the low and high slider values.
    let showValues: Bool

    /// Whether or not to show the difference between the high and low values when editing.
    let showDifferenceOnEditing: Bool

    /// The main color of the slider.
    let color: Color

    /// The title font.
    let font: Font

    /// The width of the sliders track.
    let lineWidth: CGFloat

    /// A callback for when editing begins and ends.
    let onEditingChanged: (Bool) -> Void

    private let range: V
    private let lowerBound: V
    private let upperBound: V

    public var body: some View {
        VStack {
            if title != nil {
                ZStack {
                    // This prevents the displayTitle height from
                    // changing in the case that title is nil and
                    // showDifferenceOnEditing is true.
                    Text("hidden")
                        .fontWeight(.semibold)
                        .font(font)
                        .padding(.bottom, -3)
                        .hidden()

                    Text(displayTitle)
                        .fontWeight(.semibold)
                        .font(font)
                        .foregroundColor(.secondary)
                        .padding(.bottom, -3)
                        .transition(.opacity)

                    // We change the id parameter of the view when
                    // we change its title. This resets the views
                    // state, allowing us to animate this change.
                        .id("RangeSlider" + displayTitle)

                }
            }
            GeometryReader { geo in
                ZStack {
                    HStack(spacing: 0) {
                        // Track to the left of the LHS thumb.
                        Track(lineWidth: lineWidth)
                            .foregroundColor(Color.secondary)
                            .opacity(0.3)
                            .frame(width: xPosition(side: .lhs, geo))

                        // Track in-between the two thumbs.
                        Track(lineWidth: lineWidth)
                            .foregroundColor(color)

                        // Track to the right of the RHS thumb.
                        Track(lineWidth: lineWidth)
                            .foregroundColor(Color.secondary)
                            .opacity(0.3)
                            .frame(width: geo.size.width - xPosition(side: .rhs, geo))
                    }
                    .padding(.horizontal, -4.5)

                    Grabber(lineWidth: lineWidth) // lowValue
                        .position(CGPoint(
                            x: xPosition(side: .lhs, geo),
                            y: geo.size.height * 0.5))
                        .zIndex(1)
                        .gesture(dragGesture(side: .lhs, geo: geo))

                    Grabber(lineWidth: lineWidth) // highValue
                        .position(CGPoint(
                            x: xPosition(side: .rhs, geo),
                            y: geo.size.height * 0.5))
                        .zIndex(zIndexRHS)
                        .gesture(dragGesture(side: .rhs, geo: geo))
                }
            }
            .frame(height: 44)
            .padding(.horizontal, 5.5)

            HStack {
                if showValues {
                    Text(String(format: "%.2f", translate(scale(lowValue))))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text(String(format: "%.2f", translate(scale(highValue))))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top, -3)
                }
            }
        }
    }

    public init(
        _ title: String? = nil,
        lowValue: Binding<V>,
        highValue: Binding<V>,
        in bounds: ClosedRange<Double>,
        displayBounds: ClosedRange<Double>? = nil,
        step: V? = nil,
        showValues: Bool = false,
        showDifferenceOnEditing: Bool = false,
        color: Color = .blue,
        font: Font = .body,
        lineWidth: CGFloat = 7,
        onEditingChanged: @escaping (Bool) -> Void) {
            _lowValue = lowValue
            _highValue = highValue
            lowerBound = V(bounds.lowerBound)
            upperBound = V(bounds.upperBound)
            range = upperBound - lowerBound
            _displayTitle = State(initialValue: title ?? "")
            self.title = showDifferenceOnEditing && title == nil ? "" : title
            self.bounds = bounds
            self.displayBounds = displayBounds
            self.step = step
            self.showValues = showValues
            self.showDifferenceOnEditing = showDifferenceOnEditing
            self.color = color
            self.font = font
            self.lineWidth = lineWidth
            self.onEditingChanged = onEditingChanged
        }

    private func scale(_ value: V) -> V {
        guard let display = displayBounds else { return value }

        let normal = value / (upperBound - lowerBound)

        return normal * V((display.upperBound - display.lowerBound))
    }

    private func translate(_ value: V) -> Double {
        guard let display = displayBounds else { return Double(value) }

        return Double(value) + display.lowerBound - bounds.lowerBound
    }

    private func dragGesture(side: Grabber.Side, geo: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                let translationX = gesture.translation.width

                if let newValue = getNewValue(for: side, translationX, geo) {
                    if side == .lhs {
                        lowValue = newValue
                        zIndexRHS = 0
                    } else {
                        highValue = newValue
                        zIndexRHS = 1
                    }
                }

                if showDifferenceOnEditing {
                    displayTitle = String(format: "%0.2f", Double(scale(highValue - lowValue)))
                }
            }
            .onEnded { _ in
                onEditingChanged(false)
                startX = nil

                if side == .lhs {
                    zIndexRHS = 0
                } else {
                    zIndexRHS = 1
                }

                if showDifferenceOnEditing && title != nil {
                    withAnimation(.easeInOut(duration: 0.5).delay(0.25)) {
                        displayTitle = title!
                    }
                }
            }
    }

    private func getNewValue(for side: Grabber.Side, _ translationX: CGFloat, _ geo: GeometryProxy) -> V? {
        if startX == nil {
            startX = xPosition(side: side, geo)
            onEditingChanged(true)
        }

        guard let startX = startX else { return nil }

        var newValue: V {
            var value = V((startX + translationX) / geo.size.width) * range

            if let step = step {
                value = value - value.remainder(dividingBy: step)
            }

            return side == .lhs
            ? min(value, highValue)
            : max(lowValue, value)
        }

        return newValue.clamped(to: lowerBound...upperBound)
    }

    private func xPosition(side: Grabber.Side, _ geo: GeometryProxy) -> CGFloat {
        let value = side == .lhs ? lowValue : highValue
        return geo.size.width * CGFloat((value) / range)
    }
}

// MARK: - Components
private struct Grabber: View {
    enum Side {
        case lhs
        case rhs
    }
    
    let lineWidth: CGFloat
    let height: CGFloat = 20

    var padding: CGFloat { height - lineWidth }

    let background: some View = Rectangle()
        .foregroundColor(.clear)
        .frame(width: 44, height: 44)

    var body: some View {
        Circle()
            .foregroundColor(DesignSystem.Colors.defaultBlue)
            .shadow(radius: 2)
            .frame(width: 20, height: height)
            .background(background)
    }
}

private struct Track: View {
    let lineWidth: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(height: lineWidth)
    }
}

internal extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
