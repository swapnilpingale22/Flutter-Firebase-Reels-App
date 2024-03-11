import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_unlimited/common_widgets/custom_button.dart';
import 'package:fun_unlimited/common_widgets/custom_textfield.dart';
import 'package:fun_unlimited/screens/auth/login_screen.dart';
import 'package:fun_unlimited/screens/home/bottom_bar.dart';
import 'package:fun_unlimited/services/auth_services.dart';
import 'package:fun_unlimited/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthServices _authServices = AuthServices();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool _isPasswordVisible = false;
  bool _isPasswordVisibleC = false;
  bool _isObscure = true;
  bool _isObscureC = true;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await _authServices.signUpUser(
      name: _nameController.text,
      mobileNumber: int.parse(_mobileNumberController.text),
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
        showSnackBar('Account Created Successfully! Welcome', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Name'),
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'Enter your name',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Name cannot be blank';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text('Mobile Number'),
                            CustomTextField(
                              controller: _mobileNumberController,
                              hintText: 'Enter your mobile number',
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Mobile No cannot be blank';
                                }
                                if (int.tryParse(val) == null) {
                                  return 'Mobile number must contain only digits';
                                }
                                if (val.length != 10) {
                                  return 'Mobile number must be 10 digits long';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text('Email'),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Email cannot be blank';
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
                                  return 'Password cannot be blank';
                                }
                                if (val.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                if (!val.contains(RegExp(r'[A-Z]'))) {
                                  return 'Password must contain at least one uppercase letter';
                                }
                                if (!val.contains(RegExp(r'[a-z]'))) {
                                  return 'Password must contain at least one lowercase letter';
                                }
                                if (!(val.contains(RegExp(r'[0-9]')) ||
                                    val.contains(
                                        RegExp(r'[!@#$%^&*(),.?":{}|<>]')))) {
                                  return 'Password must contain at least one number or \nspecial character';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text('Confirm Password'),
                            CustomTextField(
                              controller: _confirmPasswordController,
                              hintText: 'Re-enter your password',
                              obscureTextValue: _isObscureC,
                              suffixIcon: IconButton(
                                icon: _isPasswordVisibleC
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
                                    _isObscureC = !_isObscureC;
                                    _isPasswordVisibleC = !_isPasswordVisibleC;
                                  });
                                },
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Confirm password cannot be blank';
                                }
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  return 'Password do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Sign Up',
                      isLoading: _isLoading,
                      onTap: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          signUpUser();
                        }
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
