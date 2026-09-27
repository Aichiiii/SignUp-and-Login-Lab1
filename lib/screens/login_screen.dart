import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/pill_text_field.dart';
import '../widgets/pill_button.dart';
import '../widgets/app_logo.dart';
import '../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    // Derive a display name from whatever they typed (email or
    // username) since Login doesn't collect a separate name field.
    final input = _emailController.text.trim();
    final displayName = input.contains('@') ? input.split('@').first : input;
    final name = displayName.isEmpty
        ? 'Friend'
        : displayName[0].toUpperCase() + displayName.substring(1);

    // pushReplacementNamed so the user can't "back" into Login again.
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
                      const SizedBox(height: 12),
                      // App logo
                      const Center(child: AppLogo(size: 100)),
                      const SizedBox(height: 22),
                      const Text(
                        'Welcome back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brownDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Log in to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: AppColors.hint),
                      ),
                      const SizedBox(height: 32),

                      // Card containing the form fields
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 26, 20, 26),
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
                              controller: _emailController,
                              hintText: 'Email or username',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.alternate_email,
                              validator: Validators.emailOrUsername,
                            ),
                            const SizedBox(height: 14),
                            PillTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              obscureText: true,
                              prefixIcon: Icons.lock_outline,
                              validator: Validators.passwordSimple,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.brown,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 36),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            PillButton(
                                label: 'Log In', onPressed: _handleLogin),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: AppColors.hint),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              'Sign up',
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