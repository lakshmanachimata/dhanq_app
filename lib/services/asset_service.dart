import 'package:flutter/material.dart';

import '../models/asset_model.dart';

class AssetService {
  // Get asset allocation data
  Future<AssetAllocationModel> getAssetAllocation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return AssetAllocationModel(
      totalNetWorth: 845320,
      ytdChange: 12.4,
      allocations: [
        AssetAllocationItem(
          name: 'Equities',
          percentage: 42,
          value: 355034,
          color: Colors.orange,
        ),
        AssetAllocationItem(
          name: 'Fixed Income',
          percentage: 28,
          value: 236689,
          color: Colors.blue,
        ),
        AssetAllocationItem(
          name: 'Real Estate',
          percentage: 18,
          value: 152157,
          color: Colors.red,
        ),
        AssetAllocationItem(
          name: 'Cash & Others',
          percentage: 12,
          value: 101438,
          color: Colors.grey,
        ),
      ],
    );
  }

  // Get assets by category
  Future<List<AssetCategoryModel>> getAssetsByCategory() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      AssetCategoryModel(
        name: 'Stocks',
        totalValue: 234500,
        assets: [
          AssetModel(
            id: '1',
            name: 'TechCorp Ltd.',
            value: 85000,
            percentageChange: 5.7,
            type: AssetType.stocks,
            category: 'Stocks',
          ),
          AssetModel(
            id: '2',
            name: 'FinBank Inc.',
            value: 65000,
            percentageChange: 2.1,
            type: AssetType.stocks,
            category: 'Stocks',
          ),
          AssetModel(
            id: '3',
            name: 'Others',
            value: 84500,
            percentageChange: -0.8,
            type: AssetType.stocks,
            category: 'Stocks',
          ),
        ],
      ),
      AssetCategoryModel(
        name: 'Mutual Funds',
        totalValue: 120534,
        assets: [
          AssetModel(
            id: '4',
            name: 'Large Cap Fund',
            value: 54000,
            percentageChange: 8.3,
            type: AssetType.mutualFunds,
            category: 'Mutual Funds',
          ),
          AssetModel(
            id: '5',
            name: 'Mid Cap Fund',
            value: 42534,
            percentageChange: 7.2,
            type: AssetType.mutualFunds,
            category: 'Mutual Funds',
          ),
          AssetModel(
            id: '6',
            name: 'Debt Fund',
            value: 24000,
            percentageChange: 1.5,
            type: AssetType.mutualFunds,
            category: 'Mutual Funds',
          ),
        ],
      ),
      AssetCategoryModel(
        name: 'Real Estate',
        totalValue: 152157,
        assets: [
          AssetModel(
            id: '7',
            name: 'Residential',
            value: 120000,
            percentageChange: 3.5,
            type: AssetType.realEstate,
            category: 'Real Estate',
          ),
          AssetModel(
            id: '8',
            name: 'Commercial',
            value: 32157,
            percentageChange: 2.2,
            type: AssetType.realEstate,
            category: 'Real Estate',
          ),
        ],
      ),
    ];
  }

  // Get liabilities (placeholder for future implementation)
  Future<List<AssetModel>> getLiabilities() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  // Get recurring assets (placeholder for future implementation)
  Future<List<AssetModel>> getRecurringAssets() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }
}
