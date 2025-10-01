import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/logic/validator.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:movieverse/presentation/bloc/save_credentials/save_credentials_bloc.dart';
import 'package:movieverse/presentation/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsecureText = true;

  String? passwordErrorText;
  String? emailErrorText;
  bool isButtonEnabled = false;

  void validateForm() {
    setState(() {
      isButtonEnabled = passwordErrorText == null && emailErrorText == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/iconL.png'),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'MOVIEVERSE',
                      style: $styles.text.headlineSmall,
                    )
                  ],
                ),
                Gap($styles.insets.md),
                Text(
                  'Welcome back!',
                  style: $styles.text.headlineMedium,
                ),
                Gap($styles.insets.sm),
                Text(
                  'Please login to access and start exploring',
                  style: $styles.text.bodyLarge,
                ),
                Gap($styles.insets.lg),
                CustomTextField(
                  label: 'Email',
                  controller: emailController,
                  icon: Icons.person,
                  errorText: emailErrorText,
                  onChanged: (value) {
                    emailErrorText =
                        Validator.validateEmail(emailController.text);
                    validateForm();
                  },
                  onEditingComplete: () {
                    emailErrorText =
                        Validator.validateEmail(emailController.text);
                    validateForm();
                  },
                ),
                Gap($styles.insets.lg),
                CustomTextField(
                  label: 'Password',
                  controller: passwordController,
                  icon: Icons.lock,
                  obscureText: obsecureText,
                  errorText: passwordErrorText,
                  onChanged: (value) {
                    passwordErrorText =
                        Validator.validatePassword(passwordController.text);
                    validateForm();
                  },
                  onEditingComplete: () {
                    passwordErrorText =
                        Validator.validatePassword(passwordController.text);
                    validateForm();
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecureText = !obsecureText;
                      });
                    },
                    icon: Icon(
                        obsecureText ? Icons.visibility : Icons.visibility_off),
                    color: obsecureText
                        ? $styles.theme.neutralColor
                        : $styles.theme.tertiaryColor,
                  ),
                ),
                Gap($styles.insets.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: $styles.text.bodyMedium
                          .copyWith(color: $styles.theme.tertiaryColor),
                    ),
                  ),
                ),
                Gap($styles.insets.md),
                BlocConsumer<LoginUserBloc, LoginUserState>(
                  listener: (context, state) {
                    if (state is LoginUserSuccess) {
                      // Registration success, save credentials and navigate to the home screen or any other screen
                      context.read<SaveCredentialsBloc>().add(
                            SaveCredentialsEvent(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                      // Login success, navigate to the home screen or any other screen
                      context.pushReplacement('/navigationBars');
                    } else if (state is LoginUserFailure) {
                      // Login failed, show an error message to the user
                      final errorMessage = state.exception.toString();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text(errorMessage),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginUserLoading) {
                      // Show a loading indicator while logging in
                      return const CircularProgressIndicator();
                    } else {
                      // Show the Login button
                      return Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FilledButton(
                          onPressed: isButtonEnabled
                              ? () async {
                                  final username = emailController.text;
                                  final password = passwordController.text;

                                  // Dispatch the LoginUserEvent with the entered data
                                  context.read<LoginUserBloc>().add(
                                        LoginUserButtonPressed(
                                          email: username,
                                          password: password,
                                        ),
                                      );
                                }
                              : null,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                              isButtonEnabled
                                  ? $styles.theme.tertiaryColor
                                  : $styles.theme.neutralColor,
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: $styles.text.labelLarge
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  },
                ),
                Gap($styles.insets.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: $styles.text.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/signUpScreen');
                      },
                      child: Text(
                        'Sign Up',
                        style: $styles.text.bodyMedium
                            .copyWith(color: $styles.theme.tertiaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
