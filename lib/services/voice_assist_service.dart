import 'package:flutter/material.dart';
import '../models/voice_assist_model.dart';

class VoiceAssistService {
  Future<BudgetSummary> getBudgetSummary() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return BudgetSummary(
      month: 'October 2023',
      budget: 12500,
      spent: 5000,
      saved: 7500,
    );
  }

  Future<List<ChatMessage>> getChatMessages() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      ChatMessage(
        id: '1',
        message: 'Good morning, Rajan! How can I help you today?',
        isUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        id: '2',
        message: 'Khaad khareeda ₹500 ka',
        isUser: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
        amount: 500,
      ),
      ChatMessage(
        id: '3',
        message: 'Added ₹500 for fertilizer under Farming category',
        isUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
        category: 'Farming',
        categoryIcon: Icons.agriculture,
        amount: 500,
      ),
      ChatMessage(
        id: '4',
        message: 'Pichle hafte kitna kharch kiya?',
        isUser: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }

  Future<WeeklySpendingSummary> getWeeklySpending() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    return WeeklySpendingSummary(
      totalSpent: 2350,
      dailySpending: [
        DailySpending(day: 'Mon', amount: 200, isHighest: false),
        DailySpending(day: 'Tue', amount: 150, isHighest: false),
        DailySpending(day: 'Wed', amount: 300, isHighest: false),
        DailySpending(day: 'Thu', amount: 250, isHighest: false),
        DailySpending(day: 'Fri', amount: 950, isHighest: true),
        DailySpending(day: 'Sat', amount: 300, isHighest: false),
        DailySpending(day: 'Sun', amount: 200, isHighest: false),
      ],
      highestDay: 'Friday',
      highestAmount: 950,
      mainCategory: 'Farming supplies',
    );
  }

  Future<ChatMessage> processVoiceInput(String voiceInput, LanguageType language) async {
    // Simulate voice processing delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock voice processing logic
    String processedMessage = voiceInput;
    String? category;
    IconData? categoryIcon;
    double? amount;
    
    // Simple keyword-based categorization
    if (voiceInput.toLowerCase().contains('khaad') || 
        voiceInput.toLowerCase().contains('fertilizer') ||
        voiceInput.toLowerCase().contains('खाद')) {
      category = 'Farming';
      categoryIcon = Icons.agriculture;
    } else if (voiceInput.toLowerCase().contains('petrol') ||
               voiceInput.toLowerCase().contains('fuel') ||
               voiceInput.toLowerCase().contains('पेट्रोल')) {
      category = 'Transport';
      categoryIcon = Icons.local_gas_station;
    } else if (voiceInput.toLowerCase().contains('food') ||
               voiceInput.toLowerCase().contains('khana') ||
               voiceInput.toLowerCase().contains('खाना')) {
      category = 'Food';
      categoryIcon = Icons.restaurant;
    }
    
    // Extract amount from message
    final amountRegex = RegExp(r'₹(\d+)');
    final match = amountRegex.firstMatch(voiceInput);
    if (match != null) {
      amount = double.parse(match.group(1)!);
    }
    
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: processedMessage,
      isUser: true,
      timestamp: DateTime.now(),
      amount: amount,
    );
  }

  Future<ChatMessage> generateResponse(ChatMessage userMessage, LanguageType language) async {
    // Simulate response generation delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    String response;
    String? category;
    IconData? categoryIcon;
    double? amount = userMessage.amount;
    
    if (userMessage.amount != null) {
      // Expense tracking response
      if (language == LanguageType.hindi) {
        response = '${userMessage.amount!.toStringAsFixed(0)} रुपये ${userMessage.category ?? "expense"} के लिए जोड़ा गया';
      } else {
        response = 'Added ₹${userMessage.amount!.toStringAsFixed(0)} for ${userMessage.category ?? "expense"}';
      }
      category = userMessage.category;
      categoryIcon = userMessage.categoryIcon;
    } else if (userMessage.message.toLowerCase().contains('kitna kharch') ||
               userMessage.message.toLowerCase().contains('how much spent')) {
      // Spending query response
      if (language == LanguageType.hindi) {
        response = 'पिछले हफ्ते आपने ₹2,350 खर्च किए';
      } else {
        response = 'Last week you spent ₹2,350';
      }
    } else {
      // Default response
      if (language == LanguageType.hindi) {
        response = 'मैं आपकी कैसे मदद कर सकता हूं?';
      } else {
        response = 'How can I help you?';
      }
    }
    
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: response,
      isUser: false,
      timestamp: DateTime.now(),
      category: category,
      categoryIcon: categoryIcon,
      amount: amount,
    );
  }
} 