import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../viewmodels/sign_viewmodel.dart';
import 'home_screen.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignViewModel(),
      child: const _SignScreenContent(),
    );
  }
}

class _SignScreenContent extends StatefulWidget {
  const _SignScreenContent();

  @override
  State<_SignScreenContent> createState() => _SignScreenContentState();
}

class _SignScreenContentState extends State<_SignScreenContent> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _phoneController.text = '';
    _phoneController.addListener(_onPhoneChanged);
  }

  setMobileNumber() async {
    _phoneController.text = (await _authService.getMobileNumber())!;
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    final viewModel = context.read<SignViewModel>();
    viewModel.setPhoneNumber(_phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A8A), // Royal blue background
      body: SafeArea(
        child: Consumer<SignViewModel>(
          builder: (context, viewModel, child) {
            return _buildContent(context, viewModel);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SignViewModel viewModel) {
    // Handle success state
    if (viewModel.state == SignViewState.success && viewModel.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    }

    return Column(
      children: [
        // Status bar space
        const SizedBox(height: 20),

        // Main content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Logo
                _buildLogo(),
                const SizedBox(height: 40),

                // Title
                _buildTitle(viewModel),
                const SizedBox(height: 40),

                // Phone number input
                _buildPhoneInput(viewModel),
                const SizedBox(height: 24),

                // Error message
                if (viewModel.errorMessage.isNotEmpty)
                  _buildErrorMessage(viewModel),

                const SizedBox(height: 24),

                // Continue button
                _buildContinueButton(viewModel),

                const Spacer(),

                // Login link
                _buildLoginLink(viewModel),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
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

  Widget _buildTitle(SignViewModel viewModel) {
    return Text(
      viewModel.isSignUp ? 'Create your account' : 'Welcome back',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPhoneInput(SignViewModel viewModel) {
    return Row(
      children: [
        // Country code
        Container(
          width: 80,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              keyboardType: TextInputType.phone,
              maxLength: 10,
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
                hintText: 'Enter your mobile number',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(SignViewModel viewModel) {
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

  Widget _buildContinueButton(SignViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed:
            viewModel.canContinue && !viewModel.isLoading
                ? () => viewModel.handleContinue()
                : null,
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

  Widget _buildLoginLink(SignViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.toggleSignMode(),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 16),
          children: [
            TextSpan(
              text:
                  viewModel.isSignUp
                      ? 'Already have an account? '
                      : 'Don\'t have an account? ',
            ),
            TextSpan(
              text: viewModel.isSignUp ? 'Sign Up' : 'Login',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
