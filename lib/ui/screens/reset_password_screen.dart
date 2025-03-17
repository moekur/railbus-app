import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:railbus/ui/components/reset_password/reset_password_step1.dart';
import 'package:railbus/ui/components/reset_password/reset_password_step2.dart';
import 'package:railbus/ui/components/reset_password/reset_password_step3.dart';
import 'package:railbus/ui/components/reset_password/step_indicator.dart';
import 'package:railbus/ui/components/reset_password/loading_button.dart';
import 'package:railbus/ui/screens/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _codeController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _step = 1; // Step 1: Enter email, Step 2: Enter code, Step 3: Set new password

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _sendResetCode() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    _showMessage('Reset code sent to your email! (Simulated)', false);

    setState(() {
      _isLoading = false;
      _step = 2;
    });
  }

  Future<void> _verifyCode() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    _showMessage('Code verified! (Simulated)', false);

    setState(() {
      _isLoading = false;
      _step = 3;
    });
  }

  Future<void> _resetPassword() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    _showMessage('Password reset successful! Redirecting to login...', false);

    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _showMessage(String message, bool isError) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          color: primaryColor,
          child: SafeArea(
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24.0),
                  shrinkWrap: true,
                  children: [
                    StepIndicator(currentStep: _step, totalSteps: 3),
                    const SizedBox(height: 24),
                    if (_step == 1)
                      ResetPasswordStep1(
                        emailController: _emailController,
                        isLoading: _isLoading,
                        onSendResetCode: _sendResetCode,
                      ),
                    if (_step == 2)
                      ResetPasswordStep2(
                        codeController: _codeController,
                        isLoading: _isLoading,
                        onVerifyCode: _verifyCode,
                      ),
                    if (_step == 3)
                      ResetPasswordStep3(
                        newPasswordController: _newPasswordController,
                        confirmPasswordController: _confirmPasswordController,
                        isLoading: _isLoading,
                        onResetPassword: _resetPassword,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}