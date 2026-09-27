import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/pill_text_field.dart';
import '../widgets/pill_button.dart';
import '../widgets/app_logo.dart';
import '../utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _agreedToTerms = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    final formValid = _formKey.currentState!.validate();

    setState(() => _showTermsError = !_agreedToTerms);

    if (!formValid || !_agreedToTerms) return;

    final name = _nameController.text.trim();

    // Pass the entered name to Home via route arguments.
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {'name': name},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Pinsy',
          style: TextStyle(
            color: AppColors.brownDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      const Center(child: AppLogo(size: 96)),
                      const SizedBox(height: 20),
                      const Text(
                        'Create an account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brownDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "It's quick and easy",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: AppColors.hint),
                      ),
                      const SizedBox(height: 26),

                      // Card containing the form fields
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.brownDark.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PillTextField(
                              controller: _nameController,
                              hintText: 'Full name',
                              prefixIcon: Icons.person_outline,
                              validator: (v) =>
                                  Validators.required(v, field: 'Full name'),
                            ),
                            const SizedBox(height: 14),
                            PillTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.alternate_email,
                              validator: Validators.email,
                            ),
                            const SizedBox(height: 14),
                            PillTextField(
                              controller: _phoneController,
                              hintText: 'Phone number',
                              keyboardType: TextInputType.phone,
                              prefixIcon: Icons.phone_outlined,
                              validator: Validators.phone,
                            ),
                            const SizedBox(height: 14),
                            PillTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              obscureText: true,
                              prefixIcon: Icons.lock_outline,
                              validator: Validators.password,
                            ),
                            const SizedBox(height: 14),
                            PillTextField(
                              controller: _confirmController,
                              hintText: 'Confirm password',
                              obscureText: true,
                              prefixIcon: Icons.lock_outline,
                              validator:
                                  Validators.confirmPassword(_passwordController),
                            ),
                            const SizedBox(height: 16),

                            // Terms & conditions checkbox
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Checkbox(
                                    value: _agreedToTerms,
                                    activeColor: AppColors.brown,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _agreedToTerms = value ?? false;
                                        if (_agreedToTerms) {
                                          _showTermsError = false;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _agreedToTerms = !_agreedToTerms;
                                        if (_agreedToTerms) {
                                          _showTermsError = false;
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(top: 3),
                                      child: Text(
                                        'I agree to the Terms & Conditions '
                                        'and Privacy Policy',
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          color: _showTermsError
                                              ? Colors.redAccent
                                              : AppColors.hint,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_showTermsError)
                              const Padding(
                                padding: EdgeInsets.only(top: 4, left: 32),
                                child: Text(
                                  'You must accept the terms to continue',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 18),
                            PillButton(
                                label: 'Sign Up', onPressed: _handleSignUp),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: AppColors.hint),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                color: AppColors.brown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}