import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:railbus/ui/screens/registration_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _invitationCodeController;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showManualInput = false;

  // Mock list of valid invitation codes
  static const List<String> _validInvitationCodes = [
    'INVITE2023-001',
    'INVITE2023-002',
    'INVITE2023-003',
    'INVITE2023-004',
    'INVITE2023-005',
  ];

  @override
  void initState() {
    super.initState();
    _invitationCodeController = TextEditingController();
    _invitationCodeController.addListener(_handleTextChange);
    
    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );
    
    _animationController.forward();
  }

  void _handleTextChange() {
    final code = _invitationCodeController.text.trim();
    
    // Auto-validate when code matches expected pattern/length
    if (code.length >= 13) { // "INVITE2023-XXX" format
      _validateAndProceed();
    }
  }

  @override
  void dispose() {
    _invitationCodeController.removeListener(_handleTextChange);
    _invitationCodeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _validateAndProceed() async {
  if (_isLoading) return;

  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    final invitationCode = _invitationCodeController.text.trim();

    // Simulate API call with a small delay
    await Future.delayed(const Duration(milliseconds: 600));

    if (!_validInvitationCodes.contains(invitationCode)) {
      _showMessage('Invalid invitation code. Please check your email for the correct code.', isError: true);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _showMessage('Invitation validated! Proceeding to registration...', isError: false);

    // Wait for 6 seconds before navigating
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to next screen
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    }
  }
}

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _scanQRCode() async {
    // Simulate QR code scanning
    setState(() {
      _isLoading = true;
    });
    
    // Simulate scanning delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simulate successful scan
    if (mounted) {
      _invitationCodeController.text = 'INVITE2023-003';
      _validateAndProceed();
    }
    
    // In a real app, integrate qr_code_scanner package and populate _invitationCodeController
  }

  void _toggleInputMethod() {
    setState(() {
      _showManualInput = !_showManualInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the primary and secondary colors from the theme
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final textColor = Colors.white;

    // Set system UI overlay style for status bar
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: primaryColor,
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer to push content to center
                    const Spacer(),
                    
                    // QR Code Scanner Button - Primary Method
                    if (!_showManualInput) ...[
                      GestureDetector(
                        onTap: _isLoading ? null : _scanQRCode,
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.qr_code_scanner,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                    
                    // Manual Input Option - Secondary Method
                    if (_showManualInput) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: TextFormField(
                          controller: _invitationCodeController,
                          decoration: InputDecoration(
                            hintText: 'INVITE2023-XXX',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                            suffixIcon: _isLoading 
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : null,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          onFieldSubmitted: (_) => _validateAndProceed(),
                          validator: (value) => value == null || value.trim().isEmpty 
                              ? 'Please enter an invitation code' 
                              : null,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9-]')),
                          ],
                          autofocus: true,
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 32),
                    
                    // Subtle tip
                    /* Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Find QR code in your invitation email',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ), */
                    
                    // Spacer to push content to center
                    const Spacer(),
                    
                    // Toggle between QR scanner and Manual entry
                    TextButton(
                      onPressed: _toggleInputMethod,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withOpacity(0.9),
                      ),
                      child: Text(
                        _showManualInput 
                            ? 'Switch to QR Code Scanner' 
                            : 'Enter invitation code manually',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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