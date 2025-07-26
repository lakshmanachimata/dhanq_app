import 'package:dhanq_app/views/bachat_guru_screen.dart';
import 'package:dhanq_app/views/voice_assist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../services/home_service.dart';
import '../viewmodels/home_viewmodel.dart';
import 'asset_management_screen.dart';
import 'debt_doctor_screen.dart';
import 'financial_health_score_screen.dart';
import 'integrations_screen.dart';
import 'kisaan_saathi_screen.dart';
import 'login_screen.dart';
import 'smart_investor_screen.dart';
import 'tax_whisperer_screen.dart';
import 'vyapar_margdarshak_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          // Initialize data when the widget is first built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (viewModel.state == HomeViewState.initial) {
              viewModel.initializeData();
            }
          });

          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: _buildBody(viewModel),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Header
            _buildHeader(viewModel),

            // Search Bar
            _buildSearchBar(viewModel),

            // Portfolio Section
            _buildPortfolioSection(viewModel),

            // Financial Services Section
            _buildFinancialServicesSection(viewModel),

            // Recent Activity Section
            _buildRecentActivitySection(viewModel),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              // Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'D',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Q',
                          style: TextStyle(
                            color: Color(0xFFEB5D37),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // App Name
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dhan',
                        style: TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Q',
                        style: TextStyle(
                          color: Color(0xFFEB5D37),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Profile Button
              GestureDetector(
                onTap: () => _showProfileSheet(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.person, color: Colors.black87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Location Segmented Control
          _buildLocationSegmentedControl(viewModel),
        ],
      ),
    );
  }

  Widget _buildLocationSegmentedControl(HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildSegmentButton('Urban', LocationType.urban, viewModel),
          _buildSegmentButton('Rural', LocationType.rural, viewModel),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(
    String text,
    LocationType type,
    HomeViewModel viewModel,
  ) {
    final isSelected = viewModel.locationType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => viewModel.setLocationType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                isSelected
                    ? Border.all(color: const Color(0xFF1E3A8A), width: 1)
                    : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: viewModel.setSearchQuery,
              decoration: const InputDecoration(
                hintText: 'Search for services...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          GestureDetector(
            onTap: viewModel.startVoiceListening,
            child: const Icon(Icons.mic, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSection(HomeViewModel viewModel) {
    if (viewModel.portfolioData == null) return const SizedBox.shrink();

    final portfolio = viewModel.portfolioData!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Portfolio Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: viewModel.onPortfolioDetails,
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioItem(
                  'Total Value',
                  portfolio.formattedTotalValue,
                ),
              ),
              Expanded(
                child: _buildPortfolioItem(
                  'Today\'s Gain',
                  portfolio.formattedTodayGain,
                  portfolio.todayGainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioItem(
                  'Total Gain',
                  portfolio.formattedTotalGain,
                  portfolio.totalGainColor,
                ),
              ),
              Expanded(
                child: _buildPortfolioItem(
                  'Gain %',
                  portfolio.formattedGainPercentage,
                  portfolio.gainPercentageColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioItem(String label, String value, [Color? valueColor]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialServicesSection(HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Financial Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.95,
            ),
            itemCount: viewModel.financialServices.length,
            itemBuilder: (context, index) {
              final service = viewModel.financialServices[index];
              return _buildServiceCard(service, viewModel);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    FinancialServiceModel service,
    HomeViewModel viewModel,
  ) {
    return GestureDetector(
      onTap: () => _handleServiceTap(service, viewModel),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                service.icon,
                size: 18,
                color: const Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _handleServiceTap(
    FinancialServiceModel service,
    HomeViewModel viewModel,
  ) {
    viewModel.onServiceSelected(service);

    // Navigate to specific screens based on service
    switch (service.name) {
      case 'Asset Management':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AssetManagementScreen(),
          ),
        );
        break;
      case 'Smart Investor Agent':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SmartInvestorScreen()),
        );
        break;
      case 'Debt-Doctor':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DebtDoctorScreen()),
        );
        break;
      case 'Tax Whisperer':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TaxWhispererScreen()),
        );
        break;
      case 'Financial Health Score':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FinancialHealthScoreScreen(),
          ),
        );
        break;
      case 'Fintech Connect':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const IntegrationsScreen()),
        );
        break;
      case 'Kisaan Saathi':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const KisaanSaathiScreen()),
        );
        break;
      case 'Vyapar Margdarshak':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const VyaparMargdarshakScreen(),
          ),
        );
        break;
      case 'Bachat Guru':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BachatGuruScreen()),
        );
        break;
      case 'Voice Assistant':
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const VoiceAssistScreen()),
        );
        break;
      // Add other service navigations here
      default:
        // Show a placeholder dialog for other services
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(service.name),
                content: Text('${service.name} feature coming soon!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
    }
  }

  Widget _buildRecentActivitySection(HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: viewModel.onSeeAllActivities,
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...viewModel.recentActivities
              .take(3)
              .map((activity) => _buildActivityItem(activity, viewModel))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem(ActivityModel activity, HomeViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.onActivitySelected(activity),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: activity.iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(activity.icon, color: activity.iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity.description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  activity.formattedAmount,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: activity.amountColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.formattedTime,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1E3A8A),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  void _showProfileSheet(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String mobile = prefs.getString('mobile_number') ?? '';
    // Replace with actual user data
    final String name = 'Lakshmana';
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                mobile,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(height: 32),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
