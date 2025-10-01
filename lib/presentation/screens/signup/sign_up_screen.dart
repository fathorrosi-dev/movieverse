import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/logic/validator.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:movieverse/presentation/bloc/register_user/register_user_bloc.dart';
import 'package:movieverse/presentation/bloc/save_credentials/save_credentials_bloc.dart';
import 'package:movieverse/presentation/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obsecureTextPassword = true;
  bool obsecureTextPasswordConfirm = true;

  String? usernameErrorText;
  String? passwordErrorText;
  String? passwordConfirmErrorText;
  String? emailErrorText;

  bool isButtonEnabled = false;

  void validateForm() {
    setState(() {
      isButtonEnabled = usernameErrorText == null &&
          passwordErrorText == null &&
          passwordConfirmErrorText == null &&
          emailErrorText == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    'Sign up for an account',
                    style: $styles.text.headlineMedium,
                  ),
                  Gap($styles.insets.sm),
                  Text(
                    'Signing up for an account is free and easy. Fill out the form below to get started.',
                    style: $styles.text.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Gap($styles.insets.lg),
                  CustomTextField(
                    label: 'Username',
                    controller: usernameController,
                    icon: Icons.person,
                    errorText: usernameErrorText,
                    onChanged: (value) {
                      usernameErrorText =
                          Validator.validateUsername(usernameController.text);
                      validateForm();
                    },
                    onEditingComplete: () {
                      usernameErrorText =
                          Validator.validateUsername(usernameController.text);
                      validateForm();
                    },
                  ),
                  Gap($styles.insets.lg),
                  CustomTextField(
                    label: 'Email',
                    controller: emailController,
                    icon: Icons.email,
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
                    obscureText: obsecureTextPassword,
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
                          obsecureTextPassword = !obsecureTextPassword;
                        });
                      },
                      icon: Icon(obsecureTextPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: obsecureTextPassword
                          ? $styles.theme.neutralColor
                          : $styles.theme.tertiaryColor,
                    ),
                  ),
                  Gap($styles.insets.lg),
                  CustomTextField(
                    label: 'Password Confirm',
                    controller: passwordConfirmController,
                    icon: Icons.lock,
                    obscureText: obsecureTextPasswordConfirm,
                    errorText: passwordConfirmErrorText,
                    onChanged: (value) {
                      passwordConfirmErrorText =
                          Validator.validatePasswordConfirm(
                              passwordController.text,
                              passwordConfirmController.text);
                      validateForm();
                    },
                    onEditingComplete: () {
                      passwordConfirmErrorText =
                          Validator.validatePasswordConfirm(
                              passwordController.text,
                              passwordConfirmController.text);
                      validateForm();
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecureTextPasswordConfirm =
                              !obsecureTextPasswordConfirm;
                        });
                      },
                      icon: Icon(obsecureTextPasswordConfirm
                          ? Icons.visibility
                          : Icons.visibility_off),
                      color: obsecureTextPasswordConfirm
                          ? $styles.theme.neutralColor
                          : $styles.theme.tertiaryColor,
                    ),
                  ),
                  Gap($styles.insets.sm),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'By clicking the "Sign up" button below, I certify that I have read and agree to the TMDB terms of use and privacy policy.',
                      style: $styles.text.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gap($styles.insets.md),
                  BlocConsumer<RegisterUserBloc, RegisterUserState>(
                    listener: (context, state) {
                      if (state is RegisterUserSuccess) {
                        // Registration success, log in the user
                        context.read<LoginUserBloc>().add(
                              LoginUserButtonPressed(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                        // Registration success, save credentials and navigate to the home screen or any other screen
                        context.read<SaveCredentialsBloc>().add(
                              SaveCredentialsEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                        // Registration success, navigate to the home screen or any other screen
                        context.pushReplacement('/navigationBars');
                      } else if (state is RegisterUserFailure) {
                        // Registration failed, show an error message to the user
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
                      if (state is RegisterUserLoading) {
                        // Show a loading indicator while registering the user
                        return const CircularProgressIndicator();
                      } else {
                        // Show the Sign Up button
                        return Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FilledButton(
                            onPressed: isButtonEnabled
                                ? () {
                                    // Dispatch the RegisterUserEvent with the entered data
                                    context.read<RegisterUserBloc>().add(
                                        RegisterUserButtonPressed(
                                            name: usernameController.text,
                                            password: passwordController.text,
                                            email: emailController.text));
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
                              "Sign Up",
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
                        "Already have an account?",
                        style: $styles.text.bodyMedium,
                      ),
                      TextButton(
                          onPressed: () {
                            context.push('/loginScreen');
                          },
                          child: Text(
                            'Login',
                            style: $styles.text.bodyMedium
                                .copyWith(color: $styles.theme.tertiaryColor),
                          )),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
