import 'package:flutter/material.dart';
import '../models/integrations_model.dart';
import '../services/integrations_service.dart';

enum IntegrationsViewState {
  initial,
  loading,
  loaded,
  error,
}

class IntegrationsViewModel extends ChangeNotifier {
  final IntegrationsService _service = IntegrationsService();
  
  IntegrationsViewState _state = IntegrationsViewState.initial;
  String? _errorMessage;
  
  // Data models
  List<IntegrationServiceModel> _recommendedServices = [];
  List<IntegrationServiceModel> _connectedServices = [];
  List<IntegrationCategoryModel> _availableIntegrations = [];
  List<DataPermissionModel> _dataPermissions = [];
  List<IntegrationSettingModel> _integrationSettings = [];
  LanguageType _selectedLanguage = LanguageType.english;
  
  // Getters
  IntegrationsViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == IntegrationsViewState.loading;
  
  List<IntegrationServiceModel> get recommendedServices => _recommendedServices;
  List<IntegrationServiceModel> get connectedServices => _connectedServices;
  List<IntegrationCategoryModel> get availableIntegrations => _availableIntegrations;
  List<DataPermissionModel> get dataPermissions => _dataPermissions;
  List<IntegrationSettingModel> get integrationSettings => _integrationSettings;
  LanguageType get selectedLanguage => _selectedLanguage;
  
  // Initialize data
  Future<void> initializeData() async {
    if (_state == IntegrationsViewState.loading) return;
    
    _setState(IntegrationsViewState.loading);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _service.getRecommendedServices(),
        _service.getConnectedServices(),
        _service.getAvailableIntegrations(),
        _service.getDataPermissions(),
        _service.getIntegrationSettings(),
      ]);
      
      _recommendedServices = results[0] as List<IntegrationServiceModel>;
      _connectedServices = results[1] as List<IntegrationServiceModel>;
      _availableIntegrations = results[2] as List<IntegrationCategoryModel>;
      _dataPermissions = results[3] as List<DataPermissionModel>;
      _integrationSettings = results[4] as List<IntegrationSettingModel>;
      
      _setState(IntegrationsViewState.loaded);
    } catch (e) {
      _errorMessage = 'Failed to load integrations data: ${e.toString()}';
      _setState(IntegrationsViewState.error);
    }
  }
  
  // Refresh data
  Future<void> refreshData() async {
    _recommendedServices = [];
    _connectedServices = [];
    _availableIntegrations = [];
    _dataPermissions = [];
    _integrationSettings = [];
    await initializeData();
  }
  
  // Connect service
  Future<void> connectService(String serviceName) async {
    try {
      await _service.connectService(serviceName);
      // Refresh data to update UI
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to connect to $serviceName: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Disconnect service
  Future<void> disconnectService(String serviceName) async {
    try {
      await _service.disconnectService(serviceName);
      // Refresh data to update UI
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to disconnect from $serviceName: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Update data permission
  Future<void> updateDataPermission(String serviceName, String dataType, bool isEnabled) async {
    try {
      await _service.updateDataPermission(serviceName, dataType, isEnabled);
      // Refresh data to update UI
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to update data permission: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Update setting
  Future<void> updateSetting(String settingName, bool isEnabled) async {
    try {
      await _service.updateSetting(settingName, isEnabled);
      // Refresh data to update UI
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to update setting: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Handle recommended service tap
  void onRecommendedServiceTap(IntegrationServiceModel service) {
    // Handle tap on recommended service
    print('Tapped on recommended service: ${service.name}');
  }
  
  // Handle connected service tap
  void onConnectedServiceTap(IntegrationServiceModel service) {
    // Handle tap on connected service
    print('Tapped on connected service: ${service.name}');
  }
  
  // Handle available service tap
  void onAvailableServiceTap(IntegrationServiceModel service) {
    // Handle tap on available service
    print('Tapped on available service: ${service.name}');
  }
  
  // Handle data permission tap
  void onDataPermissionTap(DataPermissionModel permission) {
    // Handle tap on data permission
    print('Tapped on data permission: ${permission.serviceName}');
  }
  
  // Handle setting tap
  void onSettingTap(IntegrationSettingModel setting) {
    // Handle tap on setting
    print('Tapped on setting: ${setting.name}');
  }
  
  // Language switching
  void setLanguage(LanguageType language) {
    _selectedLanguage = language;
    notifyListeners();
  }
  
  // Private methods
  void _setState(IntegrationsViewState newState) {
    _state = newState;
    notifyListeners();
  }
} 