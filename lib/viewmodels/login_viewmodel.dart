import 'package:flutter/material.dart';
import '../services/auth_service.dart';

enum LoginViewState { initial, loading, success, error }
enum LoginMethod { mobile, mpin, biometric }

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  LoginViewState _state = LoginViewState.initial;
  LoginMethod _selectedMethod = LoginMethod.mpin;
  
  final TextEditingController phoneController = TextEditingController(text: '9008358358');
  final TextEditingController mpinController = TextEditingController();
  
  String _errorMessage = '';

  // Getters
  LoginViewState get state => _state;
  LoginMethod get selectedMethod => _selectedMethod;
  String get errorMessage => _errorMessage;
  bool get isLoading => _state == LoginViewState.loading;

  // Set login method
  void setLoginMethod(LoginMethod method) {
    _selectedMethod = method;
    _clearError();
    notifyListeners();
  }

  // Set search query
  void setSearchQuery(String query) {
    // Implement search functionality if needed
  }

  // Handle login
  Future<bool> handleLogin() async {
    _setState(LoginViewState.loading);
    _clearError();

    try {
      bool success = false;
      
      switch (_selectedMethod) {
        case LoginMethod.mobile:
          success = await _handleMobileLogin();
          break;
        case LoginMethod.mpin:
          success = await _handleMpinLogin();
          break;
        case LoginMethod.biometric:
          success = await _handleBiometricLogin();
          break;
      }

      if (success) {
        _setState(LoginViewState.success);
        return true;
      } else {
        _setState(LoginViewState.error);
        return false;
      }
    } catch (e) {
      _setState(LoginViewState.error);
      _errorMessage = 'An error occurred. Please try again.';
      notifyListeners();
      return false;
    }
  }

  // Handle mobile login
  Future<bool> _handleMobileLogin() async {
    final phoneNumber = phoneController.text.trim();
    
    if (phoneNumber.isEmpty) {
      _errorMessage = 'Please enter your mobile number';
      notifyListeners();
      return false;
    }
    
    if (!_authService.isValidPhoneNumber(phoneNumber)) {
      _errorMessage = 'Please enter a valid 10-digit mobile number';
      notifyListeners();
      return false;
    }

    final user = await _authService.signIn(phoneNumber);
    if (user != null) {
      return true;
    } else {
      _errorMessage = 'Invalid mobile number or user not found';
      notifyListeners();
      return false;
    }
  }

  // Handle mPIN login
  Future<bool> _handleMpinLogin() async {
    final mpin = mpinController.text.trim();
    
    if (mpin.isEmpty) {
      _errorMessage = 'Please enter your mPIN';
      notifyListeners();
      return false;
    }
    
    if (mpin.length != 6) {
      _errorMessage = 'mPIN must be 6 digits';
      notifyListeners();
      return false;
    }

    // For demo purposes, accept any 6-digit mPIN
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // Handle biometric login
  Future<bool> _handleBiometricLogin() async {
    // For demo purposes, simulate biometric authentication
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // Clear error message
  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Set state
  void _setState(LoginViewState state) {
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    mpinController.dispose();
    super.dispose();
  }
}
