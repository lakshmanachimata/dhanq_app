import '../models/smart_investor_model.dart';

class SmartInvestorService {
  // Get portfolio allocation data
  Future<PortfolioAllocationModel> getPortfolioAllocation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return PortfolioAllocationModel(
      equity: 55.0,
      debt: 30.0,
      gold: 10.0,
      cash: 5.0,
    );
  }

  // Get actionable insights
  Future<List<ActionableInsightModel>> getActionableInsights() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      ActionableInsightModel(
        id: '1',
        title: 'Rebalance Portfolio',
        description: 'Your equity exposure is 5% higher than your risk profile. Consider rebalancing.',
        actionText: 'Take Action',
      ),
      ActionableInsightModel(
        id: '2',
        title: 'Diversification Strategy',
        description: 'Add small-cap exposure to improve returns while maintaining your risk profile.',
        actionText: 'Take Action',
      ),
      ActionableInsightModel(
        id: '3',
        title: 'Tax-Efficient Investments',
        description: 'ELSS funds can save ₹24,000 in taxes while meeting equity goals. NPS for additional benefits.',
        actionText: 'Take Action',
      ),
    ];
  }

  // Get interest rate impact data
  Future<InterestRateImpactModel> getInterestRateImpact() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return InterestRateImpactModel(
      title: 'Interest Rate Impact',
      timeframe: 'Last 6 months',
      chartData: [20, 25, 30, 35, 40, 45], // Sample chart data
      description: 'The recent interest rate hike might affect your real estate investments, here\'s how: Higher EMIs on floating rate loans may reduce rental yield by approximately 0.8%.',
      actionText: 'Learn More',
    );
  }

  // Get market sentiment analysis
  Future<List<MarketSentimentModel>> getMarketSentimentAnalysis() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return [
      MarketSentimentModel(
        id: '1',
        title: 'Sector Analysis: Technology',
        description: 'Tech sector outperforming broader market by 6.2%. Consider increasing allocation.',
        actionText: 'Learn More',
      ),
      MarketSentimentModel(
        id: '2',
        title: 'News Impact',
        description: 'Q3 results affecting your banking stocks. HDFC Bank reported 18.5% YoY growth.',
        actionText: 'Learn More',
      ),
    ];
  }
} 