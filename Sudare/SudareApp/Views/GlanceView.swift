//
//  GlanceView.swift
//  Sudare
//
//  Created by Max on 07/11/26.
//

import SwiftUI

struct GlanceView: View {
    @State private var availability: Availability = .later
    
    var body: some View {
        VStack(spacing: 24){
            VStack(spacing: 18){
                Text("Pulse here")
                if (availability == .available)
                {
                    Text("Available")
                        .font(.system(size: 30, weight: .bold))
                    Text("Your pairs know you're free.")
                        .font(.system(size: 15, weight: .regular))
                }
                else{
                    Text("Later")
                        .font(.system(size: 30, weight: .bold))
                    Text("Your blind is down.")
                        .font(.system(size: 15, weight: .regular))
                }
            }
            
            VStack(spacing: 12){
                AvailabilityControl(selection: $availability)
                HStack(alignment: .center){
                    if (availability == .available)
                    {
                        Image(systemName: "moon")
                        Text("Sleep Focus will switch you to Later.")
                    }
                    else{
                        Image(systemName: "stopwatch")
                        Text("Back to Available in 8 h.")
                        Spacer()
                        Text("Change")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color(hex: 0x9AA3AD))
                .frame(maxWidth: .infinity, maxHeight: 44, alignment: .leading)
                .padding(.horizontal, 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(hex: 0x262C34))
                )
            }
            
            VStack(spacing: 10){
                HStack (alignment: .center){
                    Text("YOUR PAIRS")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color(hex: 0x9AA3AD))
                    Spacer()
                    Text("See all")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color(hex: 0x9AA3AD))
                }
                .padding(4)
                VStack{
                    HStack{
                        Text("Icon")
                        Text("Mom")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Text("Available")
                            .font(.system(size: 14, weight: .regular))
                    }
                    Divider()
                    HStack{
                        Text("Icon")
                        Text("Dana")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Text("Later")
                            .font(.system(size: 14, weight: .regular))
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color(hex: 0x171B21))
                )
                
            }
//            .border(.red)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(hex: 0x0F1216))
        .safeAreaInset(edge: .top){
            HStack (alignment: .center, spacing: 4){
                Text("Sudare - Icon")
                Spacer()
                // - TODO: REFACTOR THIS
                ZStack (alignment: .center){
                    Circle()
                        .fill(Color(hex: 0x171B21))
                        .frame(width: 44)
                    Image(systemName: "person.2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, alignment: .center)
                }
                ZStack (alignment: .center){
                    Circle()
                        .fill(Color(hex: 0x171B21))
                        .frame(width: 44)
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, alignment: .center)
                }
                // - END OF TODO
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .foregroundStyle(Color(hex: 0xEDEFF2))
    }
}

#Preview {
    GlanceView()
}
