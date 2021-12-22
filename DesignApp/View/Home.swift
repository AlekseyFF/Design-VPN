//
//  Home.swift
//  DesignApp
//
//  Created by Aleksey Fedorov on 21.12.2021.
//

import SwiftUI

struct Home: View {
    
    @State var isConnected = false
    @State var currentServer: Server = servers.first!
    @State var changeServer = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "circle.grid.cross")
                        .font(.title2)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(.white.opacity(0.25), lineWidth: 1))
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 10).strokeBorder(.white.opacity(0.25), lineWidth: 1))
                }
            }
            .overlay(
                //
                Text(getTitle())
                    .foregroundColor(.white)
            )
            .foregroundColor(.white)
            
            powerButton()
            
            VStack {
                Label {
                    Text(isConnected ? "Connected" : "Not connect")
                } icon: {
                    Image(systemName: isConnected ? "checkmark.shield" : "shield.slash")
                }
                .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                HStack {
                    HStack {
                        Image(systemName: "arrow.down.to.line.circle")
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Download")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                            Text("\(isConnected ? "60.0" : "0.0") KB/s")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Image(systemName: "arrow.up.to.line.circle")
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Upload")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            
                            Text("\(isConnected ? "27.5" : "0.0") KB/s")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(width: getRect().width - 100)
            }
            .animation(.none, value: isConnected)
            .frame(height: 120)
            .padding(.top, getRect().height < 750 ? 20 : 40)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
         background()
        )
        .overlay(Rectangle().fill(.ultraThinMaterial).opacity(changeServer ? 1 : 0).ignoresSafeArea()
                    .onTapGesture {
            withAnimation {
                changeServer.toggle()
            }
        })
        .overlay(
            bottomSheet(),
            alignment: .bottom)
        .ignoresSafeArea(.container, edges: .bottom)
        .preferredColorScheme(.dark)
    }
    // Bottom sheet
    @ViewBuilder
    func bottomSheet() -> some View {
        VStack(spacing: 0) {
            HStack {
                Image(currentServer.flag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 6) {
                    Text(currentServer.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(isConnected ? "Currently Connected" : "Currently Selected")
                        .font(.caption2.bold())
                }
                
                Spacer(minLength: 10)
                // change server button
                
                Button {
                    withAnimation {
                        changeServer.toggle()
                    }
                } label: {
                    Text(changeServer ? "Exit" : "Change")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: 110, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.white.opacity(0.25), lineWidth: 2))
                        .foregroundColor(.white)
                }
                
            }
            .frame(height: 50)
            .padding(.horizontal)
            
            Divider()
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(servers.filter {
                        $0.id != currentServer.id
                    }) { server in
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(server.flag)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                        
                                        Text(server.name)
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                    }
                                    
                                    Label {
                                        Text("Available, Ping 992ms")
                                    } icon: {
                                        Image(systemName: "checkmark")
                                    }
                                    .foregroundColor(.green)
                                    .font(.caption2)
                                }
                                
                                Spacer(minLength: 10)
                                // change server button
                                
                                Button {
                                    withAnimation {
                                        changeServer.toggle()
                                        currentServer = server
                                        isConnected = false
                                    }
                                } label: {
                                    Text("Change")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 100, height: 45)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(.white.opacity(0.25), lineWidth: 2))
                                        .foregroundColor(.white)
                                }
                                
                                Button {
                                    // action
                                } label: {
                                    Image(systemName: "square.and.arrow.up")
                                    .frame(width: 45, height: 45)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(.white.opacity(0.25), lineWidth: 2))
                                    .foregroundColor(.white)
                                }
                            }
                            .frame(height: 50)
                            .padding(.horizontal)
                            Divider()
                        }
                    }
                }
                .padding(.top, 25)
                .padding(.bottom, getSafeArea().bottom)
            }
            .opacity(changeServer ? 1 : 0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: getRect().height / 2.5, alignment: .top)
        .padding()
        .background(
            Color("BG1")
                .clipShape(CustomCorners(radius: 35, corners: [.topLeft, .topRight]))
        )
        
        .offset(y: changeServer ? 0 : (getRect().height / 2.4) - (50 + getSafeArea().bottom))
    }
    
    @ViewBuilder
    func background() -> some View {
        ZStack {
            LinearGradient(colors: [
                Color("BG1"),
                Color("BG1"),
                Color("BG2"),
                Color("BG2"),
            ], startPoint: .top, endPoint: .bottom)
            // planet little
            Image("Mars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 3)
                .scaleEffect(getRect().height < 750 ? 0.8 : 1)
                .position(x: 50, y: getRect().height < 750 ? 200 : 220)
                .opacity(0.7)
            //sample star points
            let stars: [CGPoint] = [
                CGPoint(x: 15, y: 190),
                CGPoint(x: 25, y: 250),
                CGPoint(x: 20, y: 350),
                CGPoint(x: getRect().width - 30, y: 240)
            ]
            ForEach(stars,id: \.x) { star in
                Circle()
                    .fill(.white.opacity(0.3))
                    .frame(width: 5, height: 5)
                    .position(star)
                    .offset(y: getRect().height < 750 ? -20 : 0)
            }
            
            // big planet
            Image("Earth2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: getRect().width)
                .scaleEffect(2.2)
                .offset(y: getRect().height < 750 ? 310 : 280)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
            .ignoresSafeArea()
    }
    
    func getTitle() -> AttributedString {
        var str = AttributedString("AlfaVPN")
        
        if let range = str.range(of: "Alfa") {
            str[range].font = .system(size: 24, weight: .light)
        }
        if let range = str.range(of: "VPN") {
            str[range].font = .system(size: 24, weight: .black)
        }
        return str
    }
    // View Builder
    
    @ViewBuilder
    func powerButton() -> some View {
        Button {
            withAnimation {
                isConnected.toggle()
            }
        } label: {
            ZStack {
                Image(systemName: "power")
                    .font(.system(size: 65, weight: .bold))
                    .foregroundColor(isConnected ? Color("BG3") : .white)
                    .scaleEffect(isConnected ? 0.7 : 1)
                    .offset(y: isConnected ? -30 : 0)
                
                Text("DISCONNECT")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isConnected ? 1 : 0)
            }
    
                .frame(width: 190, height: 190)
                .background(
                    ZStack {
                        Circle()
                            .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 : 0.5)
                            .stroke(
                                LinearGradient(colors: [
                                    Color("BG2"),
                                    Color("BG2")
                                        .opacity(0.5),
                                    Color("BG2")
                                        .opacity(0.3),
                                    Color("BG2")
                                        .opacity(0.5),
                                ], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                            )
                            .shadow(color: Color("BG2"), radius: 5, x: 1, y: -4)
                        
                        Circle()
                            .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 : 0.55)
                            .stroke(
                                LinearGradient(colors: [
                                    Color("BG4"),
                                    Color("BG4")
                                        .opacity(0.5),
                                    Color("BG4")
                                        .opacity(0.3),
                                    Color("BG4")
                                        .opacity(0.5),
                                ], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                            )
                            .shadow(color: Color("BG4"), radius: 5, x: 1, y: -4)
                            .rotationEffect(.init(degrees: 160))
                        
                        Circle()
                            .stroke(
                                Color("BG4")
                                    .opacity(0.01),
                                lineWidth: 11
                            )
                        
                            .shadow(color: Color("BG4").opacity(isConnected ? 0.04 : 0), radius: 5, x: 1, y: -4)
                    }
                )
        }
        .padding(.top, getRect().height < 750 ? 30 : 100)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Extensions

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
}
