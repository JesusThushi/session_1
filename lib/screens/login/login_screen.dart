import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:session_1/screens/signup/signup_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password visibility flag
  bool passWordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Key to manage the form validation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                _buildForgotPasswordButton(),
                const SizedBox(height: 40),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header with welcome text
  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          "assets/logo.png", // Logo image
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 40),
        const Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Sign in to continue",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _emailController,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            label: const Text("Email"),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "user@gmail.com",
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xff9F9F9F),
            ),
            prefixIcon: const Icon(
              Icons.email,
              size: 20,
              color: Colors.black54,
            ),
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
        ),
      ],
    );
  }

  // Password input field with validation
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passwordController,
          obscureText: passWordVisibility,
          decoration: InputDecoration(
            label: const Text("Password"),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "**********",
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xff9F9F9F),
            ),
            prefixIcon: const Icon(
              Icons.lock,
              size: 20,
              color: Colors.black54,
            ),
            suffixIcon: passWordVisibility
                ? IconButton(
                    icon: const Icon(
                      Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        passWordVisibility = !passWordVisibility;
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        passWordVisibility = !passWordVisibility;
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
        ),
      ],
    );
  }

  // Forgot password button
  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password logic here
        },
        child: const Text("Forgot Password?"),
      ),
    );
  }

  // Login button with validation check
  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
        backgroundColor: WidgetStateProperty.all(const Color(0xff6746CC)),
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      onPressed: () {
        // Trigger form validation
        if (_formKey.currentState?.validate() ?? false) {
          // If the form is valid, proceed with login
          if (kDebugMode) {
            print("Email: ${_emailController.text}");
            print("Password: ${_passwordController.text}");
          }
          // Handle login logic here (e.g., API call)
        } else {
          // If the form is invalid, show error messages
          if (kDebugMode) {
            print("Validation failed");
          }
        }
      },
      child: const Text(
        "Login",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Sign up button with navigation action
  Widget _buildSignUpButton() {
  return Align(
    alignment: Alignment.center,
    child: Text.rich(
      TextSpan(
        text: "New User? ",
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
                  print("Sign Up");
                }

                // Navigate to the sign-up screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            text: "Sign Up",
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
