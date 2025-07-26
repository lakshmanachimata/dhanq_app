import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

enum LoginViewState { initial, loading, success, error }

enum LoginMethod { mobile, mpin, biometrics }

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  LoginViewState _state = LoginViewState.initial;
  LoginMethod _selectedMethod = LoginMethod.mobile;
  String _phoneNumber = '';
  String _mpin = '';
  String _errorMessage = '';
  UserModel? _user;

  // Biometric settings
  bool _fingerprintEnabled = true;
  bool _faceIdEnabled = false;

  // Getters
  LoginViewState get state => _state;
  LoginMethod get selectedMethod => _selectedMethod;
  String get phoneNumber => _phoneNumber;
  String get mpin => _mpin;
  String get errorMessage => _errorMessage;
  UserModel? get user => _user;
  bool get isLoading => _state == LoginViewState.loading;
  bool get fingerprintEnabled => _fingerprintEnabled;
  bool get faceIdEnabled => _faceIdEnabled;

  bool get canContinue {
    switch (_selectedMethod) {
      case LoginMethod.mobile:
        return _phoneNumber.length == 10;
      case LoginMethod.mpin:
        return _mpin.length == 4;
      case LoginMethod.biometrics:
        return _fingerprintEnabled || _faceIdEnabled;
    }
  }

  // Setters
  void setSelectedMethod(LoginMethod method) {
    _selectedMethod = method;
    _clearError();
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setMpin(String mpin) {
    _mpin = mpin;
    notifyListeners();
  }

  void toggleFingerprint(bool value) {
    _fingerprintEnabled = value;
    notifyListeners();
  }

  void toggleFaceId(bool value) {
    _faceIdEnabled = value;
    notifyListeners();
  }

  void _setState(LoginViewState state) {
    _state = state;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(LoginViewState.error);
  }

  void _clearError() {
    _errorMessage = '';
    if (_state == LoginViewState.error) {
      _setState(LoginViewState.initial);
    }
  }

  // Validation methods
  bool validatePhoneNumber() {
    if (_phoneNumber.isEmpty) {
      _setError('Please enter your mobile number');
      return false;
    }

    if (_phoneNumber.length != 10) {
      _setError('Please enter a valid 10-digit mobile number');
      return false;
    }

    if (!_authService.isValidPhoneNumber(_phoneNumber)) {
      _setError('Please enter a valid Indian mobile number');
      return false;
    }

    return true;
  }

  bool validateMpin() {
    if (_mpin.isEmpty) {
      _setError('Please enter your mPIN');
      return false;
    }

    if (_mpin.length != 4) {
      _setError('mPIN must be 4 digits');
      return false;
    }

    if (!RegExp(r'^\d{4}$').hasMatch(_mpin)) {
      _setError('mPIN must contain only digits');
      return false;
    }

    return true;
  }

  bool validateBiometrics() {
    if (!_fingerprintEnabled && !_faceIdEnabled) {
      _setError('Please enable at least one biometric option');
      return false;
    }
    return true;
  }

  // Handle continue button press
  Future<void> handleContinue() async {
    bool isValid = false;

    switch (_selectedMethod) {
      case LoginMethod.mobile:
        isValid = validatePhoneNumber();
        break;
      case LoginMethod.mpin:
        isValid = validateMpin();
        break;
      case LoginMethod.biometrics:
        isValid = validateBiometrics();
        break;
    }

    if (!isValid) {
      return;
    }

    _setState(LoginViewState.loading);

    try {
      switch (_selectedMethod) {
        case LoginMethod.mobile:
          await _handleMobileLogin();
          break;
        case LoginMethod.mpin:
          await _handleMpinLogin();
          break;
        case LoginMethod.biometrics:
          await _handleBiometricLogin();
          break;
      }
    } catch (e) {
      _setError('Something went wrong. Please try again.');
    }
  }

  // Handle mobile login
  Future<void> _handleMobileLogin() async {
    try {
      final user = await _authService.signIn(_phoneNumber);

      if (user != null) {
        _user = user;
        await _authService.saveToken('mock_token_${user.id}');
        _setState(LoginViewState.success);
      } else {
        _setError('No account found with this number. Please register first.');
      }
    } catch (e) {
      _setError('Failed to sign in. Please try again.');
    }
  }

  // Handle mPIN login
  Future<void> _handleMpinLogin() async {
    try {
      // Simulate mPIN validation
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, accept any 4-digit PIN
      if (_mpin == '1234') {
        final user = UserModel(
          id: 'mpin_user_${DateTime.now().millisecondsSinceEpoch}',
          phoneNumber: '9876543210',
          createdAt: DateTime.now(),
        );
        _user = user;
        await _authService.saveToken('mock_token_${user.id}');
        _setState(LoginViewState.success);
      } else {
        _setError('Invalid mPIN. Please try again.');
      }
    } catch (e) {
      _setError('Failed to verify mPIN. Please try again.');
    }
  }

  // Handle biometric login
  Future<void> _handleBiometricLogin() async {
    try {
      // Simulate biometric authentication
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, always succeed
      final user = UserModel(
        id: 'bio_user_${DateTime.now().millisecondsSinceEpoch}',
        phoneNumber: '9876543210',
        createdAt: DateTime.now(),
      );
      _user = user;
      await _authService.saveToken('mock_token_${user.id}');
      _setState(LoginViewState.success);
    } catch (e) {
      _setError('Biometric authentication failed. Please try again.');
    }
  }

  // Reset view model state
  void reset() {
    _state = LoginViewState.initial;
    _phoneNumber = '';
    _mpin = '';
    _errorMessage = '';
    _user = null;
    _selectedMethod = LoginMethod.mobile;
    notifyListeners();
  }

  // Clear inputs
  void clearInputs() {
    _phoneNumber = '';
    _mpin = '';
    _clearError();
    notifyListeners();
  }
}
