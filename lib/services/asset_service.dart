import 'package:flutter/material.dart';
import '../models/asset_model.dart';

class AssetService {
  // Get net worth data
  Future<Map<String, dynamic>> getNetWorthData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'totalValue': 845320,
      'ytdChange': 12.4,
      'isPositive': true,
    };
  }

  // Get asset allocation data
  Future<List<AssetAllocation>> getAssetAllocation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      AssetAllocation(
        category: 'Equities',
        percentage: 42,
        value: 355034,
        color: Colors.orange,
      ),
      AssetAllocation(
        category: 'Fixed Income',
        percentage: 28,
        value: 236689,
        color: Colors.blue,
      ),
      AssetAllocation(
        category: 'Real Estate',
        percentage: 18,
        value: 152157,
        color: Colors.red,
      ),
      AssetAllocation(
        category: 'Cash & Others',
        percentage: 12,
        value: 101438,
        color: Colors.grey,
      ),
    ];
  }

  // Get assets data
  Future<List<AssetCategory>> getAssets() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return [
      AssetCategory(
        name: 'Stocks',
        totalValue: 234500,
        items: [
          AssetItem(
            name: 'TechCorp Ltd.',
            value: 85000,
            changePercentage: 5.7,
            category: 'Stocks',
          ),
          AssetItem(
            name: 'FinBank Inc.',
            value: 65000,
            changePercentage: 2.1,
            category: 'Stocks',
          ),
          AssetItem(
            name: 'Others',
            value: 84500,
            changePercentage: -0.8,
            category: 'Stocks',
          ),
        ],
      ),
      AssetCategory(
        name: 'Mutual Funds',
        totalValue: 120534,
        items: [
          AssetItem(
            name: 'Large Cap Fund',
            value: 54000,
            changePercentage: 8.3,
            category: 'Mutual Funds',
          ),
          AssetItem(
            name: 'Mid Cap Fund',
            value: 42534,
            changePercentage: 7.2,
            category: 'Mutual Funds',
          ),
          AssetItem(
            name: 'Debt Fund',
            value: 24000,
            changePercentage: 1.5,
            category: 'Mutual Funds',
          ),
        ],
      ),
      AssetCategory(
        name: 'Real Estate',
        totalValue: 152157,
        items: [
          AssetItem(
            name: 'Residential',
            value: 120000,
            changePercentage: 3.5,
            category: 'Real Estate',
          ),
          AssetItem(
            name: 'Commercial',
            value: 32157,
            changePercentage: 2.2,
            category: 'Real Estate',
          ),
        ],
      ),
    ];
  }

  // Get liabilities data (placeholder)
  Future<List<AssetCategory>> getLiabilities() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      AssetCategory(
        name: 'Loans',
        totalValue: 150000,
        items: [
          AssetItem(
            name: 'Home Loan',
            value: 100000,
            changePercentage: 0.0,
            category: 'Loans',
          ),
          AssetItem(
            name: 'Personal Loan',
            value: 50000,
            changePercentage: 0.0,
            category: 'Loans',
          ),
        ],
      ),
    ];
  }

  // Get recurring data (placeholder)
  Future<List<AssetCategory>> getRecurring() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      AssetCategory(
        name: 'SIP Investments',
        totalValue: 25000,
        items: [
          AssetItem(
            name: 'Monthly SIP',
            value: 10000,
            changePercentage: 0.0,
            category: 'SIP',
          ),
          AssetItem(
            name: 'Quarterly Investment',
            value: 15000,
            changePercentage: 0.0,
            category: 'SIP',
          ),
        ],
      ),
    ];
  }
} 