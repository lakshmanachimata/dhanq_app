class PortfolioModel {
  final double totalValue;
  final double monthlyChange;
  final double investments;
  final double savings;
  final double expenses;

  PortfolioModel({
    required this.totalValue,
    required this.monthlyChange,
    required this.investments,
    required this.savings,
    required this.expenses,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      totalValue: (json['totalValue'] as num).toDouble(),
      monthlyChange: (json['monthlyChange'] as num).toDouble(),
      investments: (json['investments'] as num).toDouble(),
      savings: (json['savings'] as num).toDouble(),
      expenses: (json['expenses'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalValue': totalValue,
      'monthlyChange': monthlyChange,
      'investments': investments,
      'savings': savings,
      'expenses': expenses,
    };
  }

  String get formattedTotalValue => '₹${_formatNumber(totalValue)}';
  String get formattedMonthlyChange => '${monthlyChange >= 0 ? '+' : ''}${monthlyChange.toStringAsFixed(1)}% this month';
  String get formattedInvestments => '₹${_formatNumber(investments)}';
  String get formattedSavings => '₹${_formatNumber(savings)}';
  String get formattedExpenses => '₹${_formatNumber(expenses)}';

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }

  bool get isPositiveChange => monthlyChange >= 0;
} 