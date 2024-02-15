//
//  ContentView.swift
//  LampUI
//
//  Created by Shreyas Vilaschandra Bhike on 13/02/24.

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408

import SwiftUI



struct ContentView: View {
    var body: some View {
        FinalView()
    }
}


#Preview {
    ContentView()
}


struct LightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addLines([
            .init(x: rect.width * 0.1, y: 0),
            .init(x: rect.width * 0.7, y: 0),
            .init(x: rect.width, y: rect.height * 0.6),
            .init(x: 0, y: rect.height * 0.6)
        ])
        return path
    }
}






struct FinalView: View {
    @State private var isLampOn = false
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var opacity: Double = 0.1

    var body: some View {
        ZStack {
            Color("basebg").ignoresSafeArea(edges: .all)
            
            ZStack{
            
                if(isLampOn){
                    LightShape()
                        .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.clear,Color.clear]), startPoint: .top, endPoint: .bottom)
                                   )
                        .frame(width: 300, height: 600)
                                   .foregroundColor(Color.blue)
                        .offset(x:-35, y: 250)
                        .opacity(opacity)
                }
                
                
                
                Image("lamp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 600)
                    .offset(x: -50, y: -250)
                
                if(isLampOn){
                    VStack{
                        Spacer()
                            .frame(height: 600)
                        ZStack{
                            
                            Text("\(String(format: "%.2f", opacity))")
                                .foregroundStyle(.white)
                                .font(.system(size: 80))
                                .opacity(opacity+0.4)
                                .offset(y:-60)
                            
                            
                            Slider(value: $opacity, in: 0...0.3, step: 0.05)
                                .accentColor(.white)
                            
                            Text("O P A C I T Y")
                                .foregroundStyle(.white)
                                .font(.title)
                                .offset(y:40)
                        }.offset(x: -40)
                            .padding(80)
                            
                    }
                }
                
                
               
                ZStack{
                
                    Rectangle()
                        .foregroundStyle(isLampOn ? .green : .red)
                        .frame(width: 250, height: 100 )
                        .clipShape(
                            CustomShape(
                              corner: [.bottomRight,.topLeft], radii: 100
                            ))
                        .opacity(0.1)
                    
                    
                    Text(isLampOn ? "O N": "O F F")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: -40)
                        .foregroundStyle(isLampOn ? .green : .red)
                    
                }.offset(x: 170,y: 420)
                
                    
                
                
                VStack{
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x:-180,y:80)
                   
                    
                    
                    Spacer()
                }
                
            }
            
            
            
            HandleView()
                .offset(x: 140,y: isDragging ? dragOffset.height : -150)
                .animation(.spring(duration: 2, bounce: 0.3),value: isDragging)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            isDragging = false
                            dragOffset = .zero
                            if value.translation.height > 20 {
                                isLampOn.toggle()
                            }
                        }
                )
            
            
        }
    }
}




struct HandleView: View {
    var body: some View {
        ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 5)
                    .frame(width: 50,height: 100)
            }
        
            Rectangle()
                .frame(width: 5,height: 1000)
                .foregroundStyle(.white)
                .offset(y:-500)
            
            
            Text("PULL DOWN")
                .foregroundStyle(.white)
                .rotationEffect(Angle(degrees: -90))
                .font(.title)
                .opacity(0.2)
                .offset(x: -20 , y: -150)
            
        }
    }
}





struct CustomShape: Shape {
    var corner : UIRectCorner
    var radii : CGFloat

    func path(in rect : CGRect) -> Path{
        let path = UIBezierPath(
            roundedRect : rect,
            byRoundingCorners: corner,
            cornerRadii: CGSize(
            width: radii, height: radii))

        return Path(path.cgPath)
    }
}
