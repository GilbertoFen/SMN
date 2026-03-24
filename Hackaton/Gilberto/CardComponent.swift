//
//  CardComponent.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI

struct CardComponent: View {
    let card: CardInfo
    var namespace: Namespace.ID
    var isExpanded: Bool = false
    @Binding var externalFlip: Bool
    var onTap: () -> Void
    var onCollapse: (() -> Void)? = nil
    var onNavigateToHelp: (() -> Void)? = nil
    
    @State private var internalFlip = false
    
    private var flipped: Bool { isExpanded ? externalFlip : internalFlip }
    private var frontDegrees: Double { flipped ? 180 : 0 }
    private var backDegrees: Double { flipped ? 0 : 180 }
    
    init(
        card: CardInfo,
        namespace: Namespace.ID,
        isExpanded: Bool = false,
        externalFlip: Binding<Bool> = .constant(false),
        onTap: @escaping () -> Void,
        onCollapse: (() -> Void)? = nil,
        onNavigateToHelp: (() -> Void)? = nil
    ) {
        self.card = card
        self.namespace = namespace
        self.isExpanded = isExpanded
        self._externalFlip = externalFlip
        self.onTap = onTap
        self.onCollapse = onCollapse
        self.onNavigateToHelp = onNavigateToHelp
    }
    
    var body: some View {
        ZStack {
            if flipped {
                CardBack(
                    card: card,
                    onNavigateToHelp: onNavigateToHelp
                )
                .flipRotate(backDegrees)
            } else {
                CardFront(card: card, isExpanded: isExpanded)
                    .flipRotate(frontDegrees)
            }
        }
        .matchedGeometryEffect(id: card.id, in: namespace)
        .frame(
            maxWidth: isExpanded ? .infinity : nil,
            maxHeight: isExpanded ? 480 : nil
        )
        .frame(minHeight: isExpanded ? 480 : 160)
        .onTapGesture { onTap() }
        .shadow(
            color: card.color.opacity(isExpanded ? 0.45 : 0.15),
            radius: isExpanded ? 30 : 8,
            x: 0, y: isExpanded ? 12 : 4
        )
        .zIndex(isExpanded ? 999 : 0)
    }
}

struct CardFront: View {
    let card: CardInfo
    var isExpanded: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(card.description)
                .font(
                    .system(
                        size: isExpanded ? 35 : 18,
                        weight: .black,
                        design: .rounded
                    )
                )
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(card.color)
                .frame(width: 28, height: 3)
                .padding(.bottom, 2)
            
            ZStack {
                Circle()
                    .fill(card.color.opacity(0.2))
                    .frame(
                        width: isExpanded ? 100 : 56,
                        height: isExpanded ? 100 : 56
                    )
                Circle()
                    .strokeBorder(card.color.opacity(0.5), lineWidth: 1.5)
                    .frame(
                        width: isExpanded ? 95 : 48,
                        height: isExpanded ? 95 : 48
                    )
                if card.isAsset {
                    Image(card.image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: isExpanded ? 85 : 42,
                            height: isExpanded ? 85 : 42
                        )
                        .clipShape(Circle()).padding()
                } else {
                    Image(systemName: card.image)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(card.color).padding()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            
            
            
            Text(card.title)
                .font(.system(size: isExpanded ? 16 : 12, weight: .bold))
                .foregroundStyle(card.color.opacity(0.7))
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 4) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 9))
                Text("Toca para ver más")
                    .font(.system(size: 10, weight: .semibold))
            }
            .foregroundStyle(card.color.opacity(0.35))
            .padding(.top, 2)
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 200, alignment: .leading)
        .background(
            ZStack {
                card.color.opacity(0.08)
                LinearGradient(
                    colors: [
                        card.color.opacity(0.18),
                        card.color.opacity(0.05)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
                .background(Color(.systemBackground))
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(card.color.opacity(0.45), lineWidth: 1)
        }
    }
}

struct CardBack: View {
    let card: CardInfo
    var onNavigateToHelp: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                Text(card.description)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(card.color)
                Spacer()
                if card.isAsset {
                    Image(card.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                } else {
                    Image(systemName: card.image)
                        .font(.caption)
                        .foregroundStyle(card.color.opacity(0.7))
                }
            }
            .padding(.bottom, 8)
            
            Divider()
                .overlay(card.color.opacity(0.3))
                .padding(.bottom, 8)
            
            Text("Síntomas")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(card.color.opacity(0.5))
                .padding(.bottom, 4)
            
            ScrollView {
                ForEach(card.symptoms, id: \.self) { symptom in
                    HStack(alignment: .top, spacing: 6) {
                        Circle()
                            .fill(card.color)
                            .frame(width: 5, height: 5)
                            .padding(.top, 4)
                        Text(symptom)
                            .font(.system(size: 12))
                            .foregroundStyle(.primary.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 2)
                }
            }
            .frame(maxHeight: 130)
            
            Divider()
                .overlay(card.color.opacity(0.2))
                .padding(.vertical, 6)
            
            Text("Recomendaciones")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(card.color.opacity(0.5))
                .padding(.bottom, 4)
            
            ForEach(card.recommendations.prefix(3), id: \.self) { rec in
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 9))
                        .foregroundStyle(card.color)
                        .padding(.top, 3)
                    Text(rec)
                        .font(.system(size: 12))
                        .foregroundStyle(.primary.opacity(0.75))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 2)
            }
            
            Spacer(minLength: 8)
            
            Button(action: {
                onNavigateToHelp?()
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "heart.fill").font(.caption)
                    Text("Busca ayuda")
                        .font(.system(size: 13, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
                .background(card.color)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .simultaneousGesture(TapGesture().onEnded { })
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            ZStack {
                Color(.systemBackground)
                card.color.opacity(0.05)
                LinearGradient(
                    colors: [card.color.opacity(0.10), card.color.opacity(0.02)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(card.color.opacity(0.2), lineWidth: 1)
        }
    }
}

extension View {
    func flipRotate(_ degrees: Double) -> some View {
        rotation3DEffect(
            .degrees(degrees),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.4
        )
    }
}
