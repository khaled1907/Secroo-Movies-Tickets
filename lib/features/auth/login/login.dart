import 'package:final_project/Cubit/Login/login_cubit.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/core/constans/app_text_styels.dart';
import 'package:final_project/features/auth/signup/singup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/Main/mainScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        backgroundColor: AppColores.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: AppTextStyels.white_20_SemiBold.copyWith(fontSize: 28),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to your account",
                  style: AppTextStyels.hint_14_bold_300.copyWith(fontSize: 16),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        style: AppTextStyels.primaryColor_20_bold_400,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: AppTextStyels.primaryColor_14_bold_400,
                          filled: true,
                          fillColor: Colors.white10,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? "Enter your email"
                            : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: AppTextStyels.primaryColor_20_bold_400,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: AppTextStyels.primaryColor_14_bold_400,
                          filled: true,
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
                      SizedBox(height: 30),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => MainScreen()),
                            );
                          } else if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
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
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LoginCubit>().login(
                                              emailController.text,
                                              passwordController.text,
                                            );
                                      }
                                    },
                              child: state is LoginLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: AppTextStyels.white_18_bold_500,
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyels.hint_14_bold_300,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpScreen()),
                              );
                            },
                            child: Text(
                              "Sign Up",
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
