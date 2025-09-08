import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack{
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                // MARK: - Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Dashboard")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Financial report for")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Text("Feb 01, 2024 - Feb 28, 2024")
                                .font(.footnote)
                                .foregroundColor(.black)
                            Image(systemName: "chevron.down")
                                .font(.footnote)
                        }
                    }
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Image(systemName: "magnifyingglass")
                        Image(systemName: "bell.fill")
                            .foregroundColor(.red)
                    }
                    .font(.title3)
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // MARK: - My Cards
                        Text("My Cards")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            // Card view
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.mint.opacity(0.2))
                                .frame(height: 180)
                                .overlay(
                                    VStack(alignment: .leading, spacing: 16) {
                                        Text("Marteen Praz")
                                            .font(.headline)
                                        Text("9283 0293")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text("09/30")
                                                .font(.subheadline)
                                        }
                                    }
                                    .padding()
                                )
                            
                            HStack {
                                Label("Physical", systemImage: "creditcard")
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(6)
                                
                                Label("Active", systemImage: "checkmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                    .padding(6)
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(6)
                            }
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Balance")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("$10,372.92")
                                        .font(.headline)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Spend Limit")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("$12,372.92 per month")
                                        .font(.headline)
                                }
                            }
                            
                            HStack {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 8, height: 8)
                                Spacer()
                                Button("Next Card") { }
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                        .padding(.horizontal)
                        
                        // MARK: - Income Section
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Income")
                                    .font(.headline)
                                Spacer()
                                Button("See Details") { }
                                    .font(.subheadline)
                            }
                            
                            Text("$28,933.92")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("+5% vs last month")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
                
                // MARK: - Bottom Tab Bar
                HStack {
                    Spacer()
                    Image(systemName: "camera.fill")
                    Spacer()
                    Image(systemName: "square.grid.2x2.fill")
                    Spacer()
                    Image(systemName: "arrow.left.arrow.right")
                    Spacer()
                    Image(systemName: "gearshape.fill")
                    Spacer()
                }
                .font(.title2)
                .padding()
                .background(Color.white.shadow(radius: 4))
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
