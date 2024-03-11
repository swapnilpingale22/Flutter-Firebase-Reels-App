import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_unlimited/common_widgets/custom_button.dart';
import 'package:fun_unlimited/common_widgets/custom_textfield.dart';
import 'package:fun_unlimited/screens/auth/sign_up_screen.dart';
import 'package:fun_unlimited/screens/home/bottom_bar.dart';
import 'package:fun_unlimited/services/auth_services.dart';
import 'package:fun_unlimited/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthServices _authServices = AuthServices();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool _isPasswordVisible = false;
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await _authServices.logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'Success') {
      if (mounted) {
        showSnackBar(res, context);
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
        );
      }
      if (mounted) {
        showSnackBar('Welcome', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Fun Unlimited',
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome back!',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New Here? '),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email'),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter your Email';
                            }
                            if (!emailRegex.hasMatch(val)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text('Password'),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          obscureTextValue: _isObscure,
                          suffixIcon: IconButton(
                            icon: _isPasswordVisible
                                ? const Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_fill,
                                    color: Colors.black26,
                                  ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter your Password';
                            }
                            if (val.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password?',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Login',
                  isLoading: _isLoading,
                  onTap: () {
                    if (_signInFormKey.currentState!.validate()) {
                      signInUser();
                    }
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'or login with',
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.white,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade800,
                      child: const FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
