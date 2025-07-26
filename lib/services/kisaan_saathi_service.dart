import 'dart:async';
import '../models/kisaan_saathi_model.dart';
import 'package:flutter/material.dart';

class KisaanSaathiService {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<FarmFinanceModel> getFarmFinanceData() async {
    await _simulateDelay();
    return FarmFinanceModel(
      upcomingPayments: [
        UpcomingPaymentModel(
          item: 'Seeds & Fertilizers',
          amount: 4500.0,
          dueDate: DateTime(2024, 3, 15),
          category: 'Inputs',
        ),
        UpcomingPaymentModel(
          item: 'Pesticides',
          amount: 2800.0,
          dueDate: DateTime(2024, 3, 20),
          category: 'Inputs',
        ),
      ],
      harvestIncomes: [
        HarvestIncomeModel(
          crop: 'Wheat',
          expectedIncome: 35000.0,
          expectedDate: DateTime(2024, 4, 15),
          status: 'Growing',
        ),
        HarvestIncomeModel(
          crop: 'Rice',
          expectedIncome: 42000.0,
          expectedDate: DateTime(2024, 5, 10),
          status: 'Planted',
        ),
      ],
    );
  }

  Future<List<GovernmentSchemeModel>> getGovernmentSchemes() async {
    await _simulateDelay();
    return [
      GovernmentSchemeModel(
        name: 'PM KISAN',
        status: 'Active',
        nextInstallment: DateTime(2024, 3, 1),
        isEligible: true,
        description: 'Next installment: Mar',
        actionText: 'Check Status >',
      ),
      GovernmentSchemeModel(
        name: 'Crop Insurance',
        status: 'Expiring',
        nextInstallment: DateTime(2024, 5, 1),
        isEligible: true,
        description: 'Coverage ends: 1 May',
        actionText: 'Renew soon',
      ),
      GovernmentSchemeModel(
        name: 'Kisan Credit Card',
        status: 'Available',
        nextInstallment: DateTime(2024, 6, 1),
        isEligible: true,
        description: 'Credit limit: ₹50,000',
        actionText: 'Apply Now >',
      ),
    ];
  }

  Future<WeatherMarketModel> getWeatherMarketData() async {
    await _simulateDelay();
    return WeatherMarketModel(
      marketPrices: [
        MarketPriceModel(
          crop: 'Wheat',
          price: 2100.0,
          unit: 'q',
          change: 2.5,
        ),
        MarketPriceModel(
          crop: 'Rice',
          price: 2800.0,
          unit: 'q',
          change: -1.2,
        ),
        MarketPriceModel(
          crop: 'Cotton',
          price: 6500.0,
          unit: 'q',
          change: 5.8,
        ),
      ],
      weatherForecast: WeatherForecastModel(
        condition: 'Rainfall expected',
        description: 'Light to moderate rainfall in next 3 days',
        recommendation: 'Consider crop insurance',
        icon: Icons.cloud,
      ),
    );
  }

  Future<MicroLoanSHGModel> getMicroLoanSHGData() async {
    await _simulateDelay();
    return MicroLoanSHGModel(
      loanPayments: [
        LoanPaymentModel(
          dueDate: DateTime(2024, 3, 20),
          amount: 5000.0,
          loanType: 'Kisan Credit Card',
          status: 'Due',
        ),
        LoanPaymentModel(
          dueDate: DateTime(2024, 4, 5),
          amount: 3000.0,
          loanType: 'Micro Loan',
          status: 'Upcoming',
        ),
      ],
      shgMeetings: [
        SHGMeetingModel(
          meetingDate: DateTime(2024, 2, 28),
          topic: 'Financial Planning',
          location: 'Village Panchayat',
          status: 'Scheduled',
        ),
        SHGMeetingModel(
          meetingDate: DateTime(2024, 3, 15),
          topic: 'Crop Insurance Discussion',
          location: 'Community Hall',
          status: 'Scheduled',
        ),
      ],
    );
  }

  Future<VoiceQueryModel> getVoiceQueryData() async {
    await _simulateDelay();
    return VoiceQueryModel(
      prompt: 'Ask me about your farm finances',
      suggestedQuery: 'When should I sell my wheat?',
      isListening: false,
    );
  }

  Future<void> processVoiceQuery(String query) async {
    await _simulateDelay();
    // Simulate processing voice query
    print('Processing voice query: $query');
  }

  Future<void> startVoiceListening() async {
    await _simulateDelay();
    // Simulate starting voice listening
    print('Voice listening started');
  }

  Future<void> stopVoiceListening() async {
    await _simulateDelay();
    // Simulate stopping voice listening
    print('Voice listening stopped');
  }

  Future<void> checkSchemeStatus(String schemeName) async {
    await _simulateDelay();
    // Simulate checking scheme status
    print('Checking status for: $schemeName');
  }

  Future<void> viewMarketPrices() async {
    await _simulateDelay();
    // Simulate viewing market prices
    print('Viewing market prices');
  }

  Future<void> repayLoan(String loanId) async {
    await _simulateDelay();
    // Simulate loan repayment
    print('Processing loan repayment for: $loanId');
  }

  Future<void> joinSHGMeeting(String meetingId) async {
    await _simulateDelay();
    // Simulate joining SHG meeting
    print('Joining SHG meeting: $meetingId');
  }
} 