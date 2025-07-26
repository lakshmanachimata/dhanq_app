import 'package:flutter/material.dart';
import '../models/asset_model.dart';
import '../services/asset_service.dart';

enum AssetViewState { initial, loading, success, error }

class AssetViewModel extends ChangeNotifier {
  final AssetService _assetService = AssetService();
  
  AssetViewState _state = AssetViewState.initial;
  AssetTab _selectedTab = AssetTab.assets;
  
  Map<String, dynamic>? _netWorthData;
  List<AssetAllocation> _assetAllocation = [];
  List<AssetCategory> _assets = [];
  List<AssetCategory> _liabilities = [];
  List<AssetCategory> _recurring = [];

  // Getters
  AssetViewState get state => _state;
  AssetTab get selectedTab => _selectedTab;
  bool get isLoading => _state == AssetViewState.loading;
  
  Map<String, dynamic>? get netWorthData => _netWorthData;
  List<AssetAllocation> get assetAllocation => _assetAllocation;
  List<AssetCategory> get assets => _assets;
  List<AssetCategory> get liabilities => _liabilities;
  List<AssetCategory> get recurring => _recurring;

  // Get current data based on selected tab
  List<AssetCategory> get currentTabData {
    switch (_selectedTab) {
      case AssetTab.assets:
        return _assets;
      case AssetTab.liabilities:
        return _liabilities;
      case AssetTab.recurring:
        return _recurring;
    }
  }

  // Initialize data
  Future<void> initializeData() async {
    _setState(AssetViewState.loading);
    
    try {
      await Future.wait([
        _loadNetWorthData(),
        _loadAssetAllocation(),
        _loadAssets(),
        _loadLiabilities(),
        _loadRecurring(),
      ]);
      
      _setState(AssetViewState.success);
    } catch (e) {
      _setState(AssetViewState.error);
    }
  }

  // Load net worth data
  Future<void> _loadNetWorthData() async {
    _netWorthData = await _assetService.getNetWorthData();
    notifyListeners();
  }

  // Load asset allocation
  Future<void> _loadAssetAllocation() async {
    _assetAllocation = await _assetService.getAssetAllocation();
    notifyListeners();
  }

  // Load assets
  Future<void> _loadAssets() async {
    _assets = await _assetService.getAssets();
    notifyListeners();
  }

  // Load liabilities
  Future<void> _loadLiabilities() async {
    _liabilities = await _assetService.getLiabilities();
    notifyListeners();
  }

  // Load recurring
  Future<void> _loadRecurring() async {
    _recurring = await _assetService.getRecurring();
    notifyListeners();
  }

  // Set selected tab
  void setSelectedTab(AssetTab tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshData() async {
    await initializeData();
  }

  // Set state
  void _setState(AssetViewState state) {
    _state = state;
    notifyListeners();
  }

  // Get formatted net worth value
  String get formattedNetWorthValue {
    if (_netWorthData == null) return '₹0';
    final value = _netWorthData!['totalValue'] as double;
    return '₹${_formatNumber(value)}';
  }

  // Get formatted YTD change
  String get formattedYtdChange {
    if (_netWorthData == null) return '+0.0% YTD';
    final change = _netWorthData!['ytdChange'] as double;
    final isPositive = _netWorthData!['isPositive'] as bool;
    return '${isPositive ? '+' : ''}${change.toStringAsFixed(1)}% YTD';
  }

  // Check if YTD change is positive
  bool get isYtdPositive {
    return _netWorthData?['isPositive'] ?? false;
  }

  // Format number helper
  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
} 