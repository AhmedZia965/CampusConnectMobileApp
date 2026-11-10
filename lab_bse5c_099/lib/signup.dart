import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const Color primaryColor = Color(0xFF172554);
  static const Color accentColor = Color(0xFF6366F1);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color lavenderColor = Color(0xFFEEF2FF);
  static const Color secondaryTextColor = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: secondaryTextColor),
      prefixIcon: Icon(icon, color: primaryColor),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: accentColor,
          width: 1.5,
        ),
      ),
    );
  }

 
void createAccount() {
  String name = nameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text;
  String confirmPassword = confirmPasswordController.text;

  if (name.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all fields.'),
      ),
    );
    return;
  }

  if (name.length < 3 || !RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Name must contain at least 3 letters.'),
      ),
    );
    return;
  }

  if (!RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter a valid email address.'),
      ),
    );
    return;
  }

  if (password.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password must be at least 8 characters.'),
      ),
    );
    return;
  }

  if (!RegExp(r'[A-Z]').hasMatch(password) ||
      !RegExp(r'[a-z]').hasMatch(password) ||
      !RegExp(r'[0-9]').hasMatch(password) ||
      !RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]').hasMatch(password)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password must contain uppercase, lowercase, number and special character.',
        ),
      ),
    );
    return;
  }

  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords do not match.'),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Account created successfully!'),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: primaryColor,
         iconTheme: const IconThemeData(
          color: Colors.white,
         ),
        title: const Text(
          'CampusConnect',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: const BoxDecoration(
                      color: lavenderColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      size: 45,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Join the CampusConnect community',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: secondaryTextColor,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: inputDecoration(
                      'Full Name',
                      Icons.person_outline,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration(
                      'University Email',
                      Icons.mail_outline,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: inputDecoration(
                      'Password',
                      Icons.lock_outline,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: confirmPasswordController,
                    obscureText: hideConfirmPassword,
                    decoration: inputDecoration(
                      'Confirm Password',
                      Icons.lock_reset_outlined,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword =
                                !hideConfirmPassword;
                          });
                        },
                        icon: Icon(
                          hideConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: createAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}