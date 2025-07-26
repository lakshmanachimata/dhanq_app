import 'package:flutter/material.dart';
import '../models/asset_model.dart';
import '../services/asset_service.dart';

enum AssetViewState { initial, loading, success, error }
enum AssetTab { assets, liabilities, recurring }

class AssetViewModel extends ChangeNotifier {
  final AssetService _assetService = AssetService();
  
  AssetViewState _state = AssetViewState.initial;
  AssetTab _selectedTab = AssetTab.assets;
  
  AssetAllocationModel? _assetAllocation;
  List<AssetCategoryModel> _assetCategories = [];
  List<AssetModel> _liabilities = [];
  List<AssetModel> _recurringAssets = [];

  // Getters
  AssetViewState get state => _state;
  AssetTab get selectedTab => _selectedTab;
  AssetAllocationModel? get assetAllocation => _assetAllocation;
  List<AssetCategoryModel> get assetCategories => _assetCategories;
  List<AssetModel> get liabilities => _liabilities;
  List<AssetModel> get recurringAssets => _recurringAssets;
  bool get isLoading => _state == AssetViewState.loading;

  // Initialize data
  Future<void> initializeData() async {
    _setState(AssetViewState.loading);
    
    try {
      await Future.wait([
        _loadAssetAllocation(),
        _loadAssetCategories(),
        _loadLiabilities(),
        _loadRecurringAssets(),
      ]);
      
      _setState(AssetViewState.success);
    } catch (e) {
      _setState(AssetViewState.error);
    }
  }

  // Load asset allocation
  Future<void> _loadAssetAllocation() async {
    _assetAllocation = await _assetService.getAssetAllocation();
    notifyListeners();
  }

  // Load asset categories
  Future<void> _loadAssetCategories() async {
    _assetCategories = await _assetService.getAssetsByCategory();
    notifyListeners();
  }

  // Load liabilities
  Future<void> _loadLiabilities() async {
    _liabilities = await _assetService.getLiabilities();
    notifyListeners();
  }

  // Load recurring assets
  Future<void> _loadRecurringAssets() async {
    _recurringAssets = await _assetService.getRecurringAssets();
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

  // Get current tab data
  List<dynamic> get currentTabData {
    switch (_selectedTab) {
      case AssetTab.assets:
        return _assetCategories;
      case AssetTab.liabilities:
        return _liabilities;
      case AssetTab.recurring:
        return _recurringAssets;
    }
  }

  // Get tab title
  String get tabTitle {
    switch (_selectedTab) {
      case AssetTab.assets:
        return 'Assets';
      case AssetTab.liabilities:
        return 'Liabilities';
      case AssetTab.recurring:
        return 'Recurring';
    }
  }
} 