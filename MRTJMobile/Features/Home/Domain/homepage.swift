//
//  homepage.swift
//  MRTJMobile
//
//  Created by Eros Kuncoro on 21/07/23.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        ZStack {
            VStack (spacing:18){
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 360, height: 122)
                  .background(
                    Image("cardduit")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 348, height: 122)
                      .clipped()
                  )
                  .background(Color(red: 0, green: 0.23, blue: 0.58))
                  .cornerRadius(13)
                  .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                  .overlay(
                    RoundedRectangle(cornerRadius: 13)
                      .inset(by: 1.5)
                      .stroke(.white, lineWidth: 3)
                  )
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        VStack {
                            Rectangle()
                            
                                .foregroundColor(.clear)
                                .frame(width: 60.62489, height: 61)
                                .background(Color(red: 0.24, green: 0.65, blue: 0.94))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    ZStack {
                                        Image("ticket")
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 33, height: 33)
                                          .clipped()
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 1)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                )
                            Text("Ticket")
                              .font(
                                Font.custom("Helvetica Neue", size: 12)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.black)
                              .frame(width: 49.12706, height: 16.82759, alignment: .top)
                        }
                        VStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 60.62489, height: 61)
                                .background(Color(red: 0.24, green: 0.65, blue: 0.94))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    ZStack {
                                        Image("tenant")
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 33, height: 33)
                                          .clipped()
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 1)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                )

                                
                            Text("Tenant")
                              .font(
                                Font.custom("Helvetica Neue", size: 12)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.black)
                              .frame(width: 49.12706, height: 16.82759, alignment: .top)
                        }
                        VStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 60.62489, height: 61)
                                .background(Color(red: 0.24, green: 0.65, blue: 0.94))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    ZStack {
                                        Image("event")
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 33, height: 33)
                                          .clipped()
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 1)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                )
                            Text("Event")
                              .font(
                                Font.custom("Helvetica Neue", size: 12)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.black)
                              .frame(width: 49.12706, height: 16.82759, alignment: .top)
                        }
                        VStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 60.62489, height: 61)
                                .background(Color(red: 0.24, green: 0.65, blue: 0.94))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    ZStack {
                                        Image("point")
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 33, height: 33)
                                          .clipped()
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 1)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                )

                            Text("Point")
                              .font(
                                Font.custom("Helvetica Neue", size: 12)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.black)
                              .frame(width: 49.12706, height: 16.82759, alignment: .top)
                        }
                        VStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 60.62489, height: 61)
                                .background(Color(red: 0.24, green: 0.65, blue: 0.94))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    ZStack {
                                        Image("community")
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 22, height: 36)
                                          .clipped()
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 1)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                )

                            Text("Community")
                              .font(
                                Font.custom("Helvetica Neue", size: 11)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.black)
                              .frame(width: 63, height: 17, alignment: .top)
                        }
                        VStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 60.62489, height: 61)
                                .background(Color(red: 0.24, green: 0.65, blue: 0.94))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .overlay(
                                    ZStack {
                                        Image("settings")
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 33, height: 33)
                                          .clipped()
                                        RoundedRectangle(cornerRadius: 12)
                                            .inset(by: 1)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                )
                            Text("Settings")
                              .font(
                                Font.custom("Helvetica Neue", size: 11)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.black)
                              .frame(width: 49.12706, height: 16.82759, alignment: .top)
                        }
                    }
                
                    
                }
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 340, height: 2)
                  .background(.black.opacity(0.25))
                
                Text("MRT Information,")
                  .font(Font.custom("Helvetica Neue", size: 16))
                  .foregroundColor(.black)
                  .frame(maxWidth: .infinity, alignment:.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 253, height: 140)
                            .background(
                                Image("mrtAds")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 253, height: 140)
                                    .clipped()
                            )
                            .cornerRadius(13)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 253, height: 140)
                            .background(
                                Image("dinaAds")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 253, height: 140)
                                    .clipped()
                            )
                            .cornerRadius(13)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                }
                
                Text("Promos for you,")
                  .font(Font.custom("Helvetica Neue", size: 16))
                  .foregroundColor(.black)
                  .frame(maxWidth: .infinity, alignment:.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 253, height: 140)
                            .background(
                                Image("grabAds")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 253, height: 140)
                                    .clipped()
                            )
                            .cornerRadius(13)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 253, height: 140)
                            .background(
                                Image("boboboxAds")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 253, height: 140)
                                    .clipped()
                            )
                            .cornerRadius(13)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                }
                

            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
