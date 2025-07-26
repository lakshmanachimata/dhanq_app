import 'dart:async';
import '../models/vyapar_margdarshak_model.dart';
import 'package:flutter/material.dart';

class VyaparMargdarshakService {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<BusinessSummaryModel> getTodaySummary() async {
    await _simulateDelay();
    return BusinessSummaryModel(
      sales: 5200.0,
      expenses: 1800.0,
      profit: 3400.0,
      date: DateTime.now(),
    );
  }

  Future<MonthlyProfitModel> getMonthlyProfit() async {
    await _simulateDelay();
    return MonthlyProfitModel(
      profitData: [
        ProfitDataModel(month: 'Jan', profit: 2800.0),
        ProfitDataModel(month: 'Feb', profit: 3200.0),
        ProfitDataModel(month: 'Mar', profit: 2900.0),
        ProfitDataModel(month: 'Apr', profit: 3500.0),
        ProfitDataModel(month: 'May', profit: 3100.0),
        ProfitDataModel(month: 'Jun', profit: 4500.0, isCurrentMonth: true),
      ],
      totalProfit: 19000.0,
    );
  }

  Future<List<QuickActionModel>> getQuickActions() async {
    await _simulateDelay();
    return [
      QuickActionModel(
        title: 'Record Sale',
        icon: Icons.attach_money,
        action: 'record_sale',
      ),
      QuickActionModel(
        title: 'Record Expense',
        icon: Icons.receipt,
        action: 'record_expense',
      ),
      QuickActionModel(
        title: 'Add Inventory',
        icon: Icons.inventory,
        action: 'add_inventory',
      ),
      QuickActionModel(
        title: 'View Reports',
        icon: Icons.analytics,
        action: 'view_reports',
      ),
    ];
  }

  Future<BusinessGrowthModel> getBusinessGrowth() async {
    await _simulateDelay();
    return BusinessGrowthModel(
      metrics: [
        GrowthMetricModel(
          title: 'Sales',
          percentage: 12.0,
          comparison: 'vs Last Month',
          icon: Icons.trending_up,
        ),
        GrowthMetricModel(
          title: 'Profit',
          percentage: 8.0,
          comparison: 'vs Last Month',
          icon: Icons.trending_up,
        ),
        GrowthMetricModel(
          title: 'Expenses',
          percentage: -3.0,
          comparison: 'vs Last Month',
          icon: Icons.trending_down,
        ),
      ],
    );
  }

  Future<LoanOfferModel> getLoanOffer() async {
    await _simulateDelay();
    return LoanOfferModel(
      title: 'Apply for Mudra Loan',
      description: 'Get up to ₹10,00,000 for your business',
      maxAmount: 1000000.0,
      eligibility: 'Eligible for small business owners',
    );
  }

  Future<void> recordSale(double amount, String description) async {
    await _simulateDelay();
    print('Recording sale: $amount - $description');
  }

  Future<void> recordExpense(double amount, String category) async {
    await _simulateDelay();
    print('Recording expense: $amount - $category');
  }

  Future<void> addInventory(String item, int quantity, double cost) async {
    await _simulateDelay();
    print('Adding inventory: $item - $quantity units at ₹${cost} each');
  }

  Future<void> viewReports() async {
    await _simulateDelay();
    print('Opening business reports');
  }

  Future<void> applyForLoan() async {
    await _simulateDelay();
    print('Applying for Mudra loan');
  }

  Future<void> checkEligibility() async {
    await _simulateDelay();
    print('Checking loan eligibility');
  }

  Future<Map<String, dynamic>> getBusinessHealthMetrics() async {
    await _simulateDelay();
    return {
      'cashFlow': 'Positive',
      'profitMargin': '65.4%',
      'inventoryTurnover': '12.5',
      'customerSatisfaction': '4.2/5',
    };
  }

  Future<List<Map<String, dynamic>>> getFinanceOptions() async {
    await _simulateDelay();
    return [
      {
        'name': 'Mudra Loan',
        'amount': '₹10,00,000',
        'interest': '8.5%',
        'tenure': '5 years',
        'eligibility': 'Small business owners',
      },
      {
        'name': 'Working Capital Loan',
        'amount': '₹5,00,000',
        'interest': '12%',
        'tenure': '2 years',
        'eligibility': 'Business with 2+ years history',
      },
      {
        'name': 'Equipment Finance',
        'amount': '₹15,00,000',
        'interest': '10%',
        'tenure': '3 years',
        'eligibility': 'Equipment purchase',
      },
    ];
  }

  Future<List<Map<String, dynamic>>> getInventoryData() async {
    await _simulateDelay();
    return [
      {
        'item': 'Product A',
        'quantity': 150,
        'value': '₹45,000',
        'status': 'In Stock',
      },
      {
        'item': 'Product B',
        'quantity': 75,
        'value': '₹22,500',
        'status': 'Low Stock',
      },
      {
        'item': 'Product C',
        'quantity': 0,
        'value': '₹0',
        'status': 'Out of Stock',
      },
    ];
  }
} 