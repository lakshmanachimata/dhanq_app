import 'dart:async';
import '../models/integrations_model.dart';
import 'package:flutter/material.dart';

class IntegrationsService {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<List<IntegrationServiceModel>> getRecommendedServices() async {
    await _simulateDelay();
    return [
      IntegrationServiceModel(
        name: 'Mint',
        description: 'Budget & expense tracking',
        icon: Icons.attach_money,
        status: IntegrationStatus.disconnected,
        isConnected: false,
        isRecommended: true,
      ),
      IntegrationServiceModel(
        name: 'Stripe',
        description: 'Payment processing',
        icon: Icons.credit_card,
        status: IntegrationStatus.disconnected,
        isConnected: false,
        isRecommended: true,
      ),
      IntegrationServiceModel(
        name: 'YNAB',
        description: 'You Need A Budget',
        icon: Icons.account_balance_wallet,
        status: IntegrationStatus.disconnected,
        isConnected: false,
        isRecommended: true,
      ),
    ];
  }

  Future<List<IntegrationServiceModel>> getConnectedServices() async {
    await _simulateDelay();
    return [
      IntegrationServiceModel(
        name: 'Chase Bank',
        description: 'Bank accounts & cards',
        icon: Icons.account_balance,
        status: IntegrationStatus.connected,
        lastSync: '10 mins ago',
        isConnected: true,
      ),
      IntegrationServiceModel(
        name: 'Robinhood',
        description: 'Investment platform',
        icon: Icons.trending_up,
        status: IntegrationStatus.connected,
        lastSync: '1 hour ago',
        isConnected: true,
      ),
      IntegrationServiceModel(
        name: 'Bank of America',
        description: 'Bank accounts & investments',
        icon: Icons.account_balance,
        status: IntegrationStatus.connected,
        lastSync: '3 hours ago',
        isConnected: true,
      ),
    ];
  }

  Future<List<IntegrationCategoryModel>> getAvailableIntegrations() async {
    await _simulateDelay();
    return [
      IntegrationCategoryModel(
        name: 'Banking',
        icon: Icons.account_balance,
        services: [
          IntegrationServiceModel(
            name: 'Wells Fargo',
            description: 'Bank accounts & cards',
            icon: Icons.account_balance,
            category: 'Banking',
            status: IntegrationStatus.disconnected,
            isConnected: false,
          ),
          IntegrationServiceModel(
            name: 'Citibank',
            description: 'Bank accounts & investments',
            icon: Icons.account_balance,
            category: 'Banking',
            status: IntegrationStatus.disconnected,
            isConnected: false,
          ),
        ],
      ),
      IntegrationCategoryModel(
        name: 'Investments',
        icon: Icons.trending_up,
        services: [
          IntegrationServiceModel(
            name: 'Vanguard',
            description: 'ETFs & retirement accounts',
            icon: Icons.trending_up,
            category: 'Investments',
            status: IntegrationStatus.disconnected,
            isConnected: false,
          ),
          IntegrationServiceModel(
            name: 'Fidelity',
            description: 'Investments & planning',
            icon: Icons.trending_up,
            category: 'Investments',
            status: IntegrationStatus.disconnected,
            isConnected: false,
          ),
        ],
      ),
      IntegrationCategoryModel(
        name: 'Payments',
        icon: Icons.payment,
        services: [
          IntegrationServiceModel(
            name: 'PayPal',
            description: 'Online payments',
            icon: Icons.payment,
            category: 'Payments',
            status: IntegrationStatus.disconnected,
            isConnected: false,
          ),
          IntegrationServiceModel(
            name: 'Venmo',
            description: 'Person-to-person payments',
            icon: Icons.payment,
            category: 'Payments',
            status: IntegrationStatus.disconnected,
            isConnected: false,
          ),
        ],
      ),
    ];
  }

  Future<List<DataPermissionModel>> getDataPermissions() async {
    await _simulateDelay();
    return [
      DataPermissionModel(
        serviceName: 'Chase Bank',
        icon: Icons.account_balance,
        lastAccessed: 'Today at 2:15 PM',
        permissions: [
          DataPermissionItem(dataType: 'Account info', isEnabled: true),
          DataPermissionItem(dataType: 'Transaction data', isEnabled: true),
          DataPermissionItem(dataType: 'Balance history', isEnabled: false),
        ],
      ),
      DataPermissionModel(
        serviceName: 'Robinhood',
        icon: Icons.trending_up,
        lastAccessed: 'Today at 11:30 AM',
        permissions: [
          DataPermissionItem(dataType: 'Portfolio data', isEnabled: true),
          DataPermissionItem(dataType: 'Trade history', isEnabled: true),
          DataPermissionItem(dataType: 'Performance analytics', isEnabled: true),
        ],
      ),
    ];
  }

  Future<List<IntegrationSettingModel>> getIntegrationSettings() async {
    await _simulateDelay();
    return [
      IntegrationSettingModel(
        name: 'Auto-sync services',
        description: 'Automatically sync data from connected services',
        isEnabled: true,
      ),
      IntegrationSettingModel(
        name: 'Connection notifications',
        description: 'Get notified when services connect or disconnect',
        isEnabled: true,
      ),
    ];
  }

  Future<void> connectService(String serviceName) async {
    await _simulateDelay();
    // Simulate connecting a service
    print('Connecting to $serviceName...');
  }

  Future<void> disconnectService(String serviceName) async {
    await _simulateDelay();
    // Simulate disconnecting a service
    print('Disconnecting from $serviceName...');
  }

  Future<void> updateDataPermission(String serviceName, String dataType, bool isEnabled) async {
    await _simulateDelay();
    // Simulate updating data permission
    print('Updating $dataType permission for $serviceName to $isEnabled');
  }

  Future<void> updateSetting(String settingName, bool isEnabled) async {
    await _simulateDelay();
    // Simulate updating setting
    print('Updating $settingName to $isEnabled');
  }
} 