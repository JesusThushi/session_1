import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:session_1/screens/login/login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password visibility flags
  bool passwordVisibility = true;
  bool confirmPasswordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Key for managing form validation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 20),
                _buildConfirmPasswordField(),
                const SizedBox(height: 40),
                _buildSignUpButton(),
                const SizedBox(height: 20),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header with image and welcome text
  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          "assets/logo.png", // Upload and place your image in the assets folder
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 40),
        const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Sign up to get started",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff9F9F9F),
          ),
        ),
      ],
    );
  }

  // Email input field with validation
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        label: const Text("Email"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "user@gmail.com",
        prefixIcon: const Icon(Icons.email, size: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email.';
        }
        // Regex for email validation
        String emailPattern =
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
        if (!RegExp(emailPattern).hasMatch(value)) {
          return 'Please enter a valid email address.';
        }
        return null; // Return null if valid
      },
    );
  }

  // Password input field with validation
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: passwordVisibility,
      decoration: InputDecoration(
        label: const Text("Password"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "**********",
        prefixIcon: const Icon(Icons.lock, size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisibility ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password.';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long.';
        }
        return null; // Return null if valid
      },
    );
  }

  // Confirm password input field with validation
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: confirmPasswordVisibility,
      decoration: InputDecoration(
        label: const Text("Confirm Password"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "**********",
        prefixIcon: const Icon(Icons.lock, size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            confirmPasswordVisibility ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              confirmPasswordVisibility = !confirmPasswordVisibility;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password.';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match.';
        }
        return null; // Return null if valid
      },
    );
  }

  // Sign up button with validation check
  Widget _buildSignUpButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: (Colors.white),
        backgroundColor: (const Color(0xff6746CC)),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // If the form is valid, proceed with signup
          if (kDebugMode) {
            print("Email: ${_emailController.text}");
            print("Password: ${_passwordController.text}");
          }
          // Handle sign-up logic here (e.g., API call)
        } else {
          // If the form is invalid, show error messages
          if (kDebugMode) {
            print("Validation failed");
          }
        }
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Login redirection link
  Widget _buildLoginButton() {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          text: "Already have an account? ",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff9F9F9F),
          ),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (kDebugMode) {
                    print("Navigate to Login");
                  }
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
              text: "Login",
              style: const TextStyle(
                color: Color(0xff6746CC),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
