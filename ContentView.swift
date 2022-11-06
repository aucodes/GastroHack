//
//  ContentView.swift
//  MisToe
//
//  Created by Astha Upadhyay on 06/11/22.
//


import SwiftUI


struct ContentView: View {
    var body: some View {
        FinalView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct FinalView: View {
    @State var splashScreen  = true

    var body: some View {
         ZStack{
             Group{
              if splashScreen {
                  SplashScreen()
               }
              else{
                  MainView()
                    }
                }
               .onAppear {
                  DispatchQueue
                       .main
                       .asyncAfter(deadline:
                            .now() + 3.5) {
                   splashScreen = false
                  }
                }
            }
        }
    }

struct SplashScreen: View {
    @State private var animateOffset = false
    
    var body: some View {
        ZStack{
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            ZStack{
            Circle()
                .frame(width: 600, height: 600)
                .foregroundColor(Color("colgreen"))
                .offset(x: 0, y: animateOffset ? -230 : -800)
            
            
                
                ZStack{
            Circle()
                .frame(width: 550, height: 550)
                .foregroundColor(Color("colgreen2").opacity(0.4))
                    
                    Image("logo")
                            .resizable()
                            .frame(width: 400, height: 220)
                            .offset(x: -10, y: 30)
                    
                }
                .offset(x: 0, y: animateOffset ? -270 : -800)
                
            }
            .animation(.easeOut(duration: 2), value: animateOffset)
            .onAppear(perform: {
                animateOffset = true
            })
            
            
            VStack{


                Spacer()
                
                LottieView(filename: "load")
                    .frame(width: 300, height: 100)
               
            
            }
            
            
           
        }
    }
}


struct MainView: View {
    
    @State var selectedPage = 0
    @State private var book = false
    @State private var track = false
    @State private var ride = false
    
    var body: some View {
        
        // Main Stack
       
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .frame(width: 600, height: 600)
                .foregroundColor(Color("colgreen"))
                .offset(x: 0, y: -230)
            
            
            Circle()
                .frame(width: 550, height: 550)
                .foregroundColor(Color("colgreen2").opacity(0.4))
                .offset(x: 0, y: -270)
            
            
            TabView(selection: $selectedPage)
            {
                ForEach(0..<3){
                    index in CardView(card : testData[index]).tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            

            //Selected Pages
            if (selectedPage == 0)
            {
                
                ZStack{
                    
                    CircleView().offset(x: -100, y: -50)
                    
                    Image("guy")
                            .resizable()
                            .frame(width: 600, height: 600)
                    
                    
                    ZStack{
                        
                        Image(systemName: "car.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                            .opacity(0.3)
                            .scaleEffect(book ? 1 : 0)
                            .opacity(book ? 1 : 0)
                    }
                    .animation(.easeOut(duration: 2), value: book)
                    .onAppear(perform: {
                        book = true
                    })
                        .offset(x: 20, y: -120)
                        
                }
                    .offset(x: 100, y: -150)
            }
            
            if (selectedPage == 1)
            {
                
                ZStack{
                    
                    ParticleSystem()
                    CircleView().offset(x: -100, y: -50)
                
                    Image("guy2")
                       .resizable()
                       .frame(width: 600, height: 600)
                       .offset(x: ride ? 0 : -30, y: ride ? 0 : -100)
                       .animation(.easeOut(duration: 2), value: ride)
                       .onAppear(perform: {
                           ride = true
                       })
                    
                    
                }
                       .offset(x: 100, y: -150)
            }
            
            
            if (selectedPage == 2)
            {
                ZStack{
                    ParticleSystem()
                    CircleView()  .offset(x: -100, y: -50)

                    Image("guy3")
                       .resizable()
                       .frame(width: 600, height: 600)

                    ZStack{
                        Image(systemName: "map")
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                            .opacity(0)
                            .scaleEffect(track ? 1 : 0)
                            .opacity(track ? 1 : 0)

                    }
                    .animation(.easeOut(duration: 2), value: track)
                    .onAppear(perform: {
                        track = true
                    })
                        .offset(x: 10, y: -140)
                    
                    
                    
                }
                .offset(x: 100, y: -150)
                
                Button(action : {
                    selectedPage = 1
                })
                {
                  Image(systemName: "chevron.right")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 30)
                }

                .offset(x: 150, y: 400)
            }
        }
       
    }
}
struct ParticleSystem: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let size = CGSize(width: 0.05, height: 0.05)
        let host = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))

        let particlesLayer = CAEmitterLayer()

        particlesLayer.frame = CGRect(x: 2, y: 2, width: size.width, height: size.height)

        host.layer.addSublayer(particlesLayer)
        host.layer.masksToBounds = true

        particlesLayer.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor

        particlesLayer.emitterShape = .circle

        particlesLayer.emitterPosition = CGPoint(x: 509.4, y: 707.7)
        particlesLayer.emitterSize = CGSize(width: 1648.0, height: 1112.0)
        particlesLayer.emitterMode = .surface
        particlesLayer.renderMode = .oldestLast
        let imageParticle = UIImage(named: "snowflake")?.cgImage
        let snowParticles = CAEmitterCell()
        snowParticles.contents = imageParticle
        snowParticles.name = "Snow"
        snowParticles.birthRate = 92.0
        snowParticles.lifetime = 30
        snowParticles.velocity = 59.0
        snowParticles.velocityRange = -15.0
        snowParticles.xAcceleration = 5.0
        snowParticles.yAcceleration = 40.0
        snowParticles.emissionRange = 180.0 * (.pi / 45)
        snowParticles.spin = -28.6 * (.pi / 180.0)
        snowParticles.spinRange = 57.2 * (.pi / 180.0)
        snowParticles.scale = 0.002
        snowParticles.scaleRange = 0.05
        snowParticles.color = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        particlesLayer.emitterCells = [snowParticles]
        return host
    }
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    typealias UIViewType = UIView
}

