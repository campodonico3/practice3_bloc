import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice3_bloc/bloc/auth_bloc.dart';
import 'package:practice3_bloc/login_screen.dart';
import 'package:practice3_bloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final authState = context.watch<AuthBloc>().state as AuthSuccess;

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              children: [
                Text((state as AuthSuccess).uid),
                GradientButton(onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
