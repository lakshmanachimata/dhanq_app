import 'package:dhanq_app/views/sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_viewmodel.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  const _LoginScreenContent();

  @override
  State<_LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<_LoginScreenContent> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mpinController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _mpinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
    _mpinController.addListener(_onMpinChanged);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _mpinController.removeListener(_onMpinChanged);
    _phoneController.dispose();
    _mpinController.dispose();
    _phoneFocusNode.dispose();
    _mpinFocusNode.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    final viewModel = context.read<LoginViewModel>();
    viewModel.setPhoneNumber(_phoneController.text);
  }

  void _onMpinChanged() {
    final viewModel = context.read<LoginViewModel>();
    viewModel.setMpin(_mpinController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A8A), // Royal blue background
      body: SafeArea(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return _buildContent(context, viewModel);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, LoginViewModel viewModel) {
    // Handle success state
    if (viewModel.state == LoginViewState.success && viewModel.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Status bar space
            const SizedBox(height: 20),

            // Logo
            _buildLogo(),
            const SizedBox(height: 40),

            // Title
            _buildTitle(),
            const SizedBox(height: 40),

            // Login options
            _buildLoginOptions(viewModel),
            const SizedBox(height: 24),

            // Error message
            if (viewModel.errorMessage.isNotEmpty)
              _buildErrorMessage(viewModel),

            const SizedBox(height: 24),

            // Continue button
            _buildContinueButton(viewModel),

            const SizedBox(height: 40),

            // Register link
            _buildRegisterLink(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: const Center(
        child: Text(
          'DhanQ',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Welcome Back',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginOptions(LoginViewModel viewModel) {
    return Column(
      children: [
        // Mobile login option
        _buildMobileLoginCard(viewModel),
        const SizedBox(height: 16),

        // mPIN login option
        _buildMpinLoginCard(viewModel),
        const SizedBox(height: 16),

        // Biometric login option
        _buildBiometricLoginCard(viewModel),
      ],
    );
  }

  Widget _buildMobileLoginCard(LoginViewModel viewModel) {
    final isSelected = viewModel.selectedMethod == LoginMethod.mobile;

    return GestureDetector(
      onTap: () => viewModel.setSelectedMethod(LoginMethod.mobile),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border:
              isSelected
                  ? Border.all(color: const Color(0xFFFFD700), width: 2)
                  : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: const Color(0xFF1E3A8A), // Brown color
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Login with Mobile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Country code
                Container(
                  width: 80,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE4B5), // Light peach
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Phone number field
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Enter mobile number',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMpinLoginCard(LoginViewModel viewModel) {
    final isSelected = viewModel.selectedMethod == LoginMethod.mpin;

    return GestureDetector(
      onTap: () => viewModel.setSelectedMethod(LoginMethod.mpin),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border:
              isSelected
                  ? Border.all(color: const Color(0xFFFFD700), width: 2)
                  : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: const Color(0xFF1E3A8A), // Brown color
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Login with mPIN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Use your 4-digit secure PIN',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const Spacer(),
                // PIN dots
                Row(
                  children: List.generate(4, (index) {
                    final hasDigit = index < viewModel.mpin.length;
                    return Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color:
                            hasDigit
                                ? const Color(0xFF1E3A8A)
                                : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _mpinController,
                focusNode: _mpinFocusNode,
                keyboardType: TextInputType.number,
                obscureText: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                  color: Colors.black87,
                ),
                decoration: const InputDecoration(
                  hintText: '••••',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    letterSpacing: 8,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricLoginCard(LoginViewModel viewModel) {
    final isSelected = viewModel.selectedMethod == LoginMethod.biometrics;

    return GestureDetector(
      onTap: () => viewModel.setSelectedMethod(LoginMethod.biometrics),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border:
              isSelected
                  ? Border.all(color: const Color(0xFFFFD700), width: 2)
                  : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.fingerprint,
                  color: const Color(0xFF1E3A8A), // Brown color
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Login with Biometrics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Fingerprint option
            Row(
              children: [
                const Icon(Icons.fingerprint, color: Colors.red, size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Fingerprint',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const Spacer(),
                Switch(
                  value: viewModel.fingerprintEnabled,
                  onChanged: viewModel.toggleFingerprint,
                  activeColor: const Color(0xFF1E3A8A),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Face ID option
            Row(
              children: [
                Icon(Icons.face, color: const Color(0xFF1E3A8A), size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Face ID',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const Spacer(),
                Switch(
                  value: viewModel.faceIdEnabled,
                  onChanged: viewModel.toggleFaceId,
                  activeColor: const Color(0xFF1E3A8A),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(LoginViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              viewModel.errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(LoginViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          viewModel.canContinue && !viewModel.isLoading
              ? () => viewModel.handleContinue()
              : null;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD700), // Yellow color
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child:
            viewModel.isLoading
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignScreen()),
        );
      },
      child: RichText(
        text: const TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 16),
          children: [
            TextSpan(text: 'Don\'t have an account? '),
            TextSpan(
              text: 'Register',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
