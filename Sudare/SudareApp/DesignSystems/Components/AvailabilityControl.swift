//
//  SegmentedControlComponent.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//
import SwiftUI

enum Availability: String, Identifiable, CaseIterable{
    case available = "Available"
    case later = "Later"
    var id: Self { self }
    
    @ViewBuilder var icon: some View{
        switch self {
            case .available:
                Circle()
                .fill(Color(hex: 0x7FD8A0))
                    .frame(width: 16, height: 16)
            case .later:
                StripedDot(color: Color(hex: 0xE8A55A))
        }
    }
}

struct StripedDot: View {
    var color: Color
    var body: some View {
        VStack(spacing: 2){
            ForEach(0..<4, id: \.self) { _ in
                Rectangle().fill(color).frame(height: 2)
            }
        }
        .frame(width: 16, height: 16)
        .clipShape(Circle())
    }
}

struct AvailabilityControl: View{
    @Binding var selection: Availability
    @Namespace private var ns
    
    var body: some View{
        HStack(spacing: 0){
            ForEach(Availability.allCases) { option in
                let isSelected = selection == option
                
                Button{
                    withAnimation(
                        .snappy(duration: 0.25)
                    ){
                        selection = option
                    }
                } label: {
                    HStack {
                        option.icon
                        Text(option.rawValue)
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(isSelected ? Color(hex:0xEDEff2) : Color(hex: 0x9AA3AD))
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background{
                        if isSelected{
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color(hex: 0x2A3038))
                                .matchedGeometryEffect(id: "pill", in: ns)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(isSelected ? .isSelected: [])
            }
        }
        .padding(4)
        .background(Color(hex: 0x171B21),
                            in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

#Preview{
    @Previewable @State var availability: Availability = .available
    AvailabilityControl(selection: $availability)
        .foregroundStyle(Color(hex: 0xEDEFF2))
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: 0x0F1216))
}
