import 'package:final_project/Cubit/SignUp/signup_cubit.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/features/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: Scaffold(
        backgroundColor: AppColores.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: AppTextStyels.white_20_SemiBold.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sign up to get started",
                  style: AppTextStyels.hint_14_bold_300.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        style: AppTextStyels.primaryColor_20_bold_400,
                        decoration: InputDecoration(
                          labelText: "Name",
                          filled: true,
                          labelStyle: AppTextStyels.primaryColor_14_bold_400,
                          fillColor: Colors.white10,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? "Enter your name"
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        style: AppTextStyels.primaryColor_20_bold_400,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          labelStyle: AppTextStyels.primaryColor_14_bold_400,
                          fillColor: Colors.white10,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (val) => val == null ||
                                val.isEmpty ||
                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(val)
                            ? "Enter your email like this Example@abc.com"
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: AppTextStyels.primaryColor_20_bold_400,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          labelStyle: AppTextStyels.primaryColor_14_bold_400,
                          fillColor: Colors.white10,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? "Enter password"
                            : null,
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (context, state) {
                          if (state is SignUpSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sign Up Successful!')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          } else if (state is SignUpFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Error: ${state.message}')),
                            );
                          }
                        },
                        builder: (context, state) {
                          final isLoading = state is SignUpLoading;
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColores.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<SignUpCubit>().signUp(
                                              nameController.text,
                                              emailController.text,
                                              passwordController.text,
                                            );
                                      }
                                    },
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      "Sign Up",
                                      style: AppTextStyels.white_18_bold_500,
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: AppTextStyels.hint_14_bold_300,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: AppTextStyels.primaryColor_14_bold_400
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
