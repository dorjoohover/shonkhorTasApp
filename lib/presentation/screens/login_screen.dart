import 'package:app/bloc/auth/auth_bloc.dart';
import 'package:app/presentation/screens/page_screen.dart';
import 'package:app/shared/widgets/gradient_button.dart';
import 'package:app/shared/widgets/login_field.dart';
import 'package:app/shared/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Нэвтрэх',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Утасны дугаар',
                    controller: phoneController,
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Нууц үг',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    
                    child: Text('Нэвтрэх'),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthLoginRequested(
                              phone: phoneController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
