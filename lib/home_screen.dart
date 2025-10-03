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
        // ✅ Solo escucha cuando vuelve a AuthInitial (logout exitoso)
        listenWhen: (previous, current) => current is AuthInitial,

        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          }
        },

        // ✅ Solo reconstruye cuando el estado es relevante para la UI
        buildWhen: (previous, current) {
          return current is AuthLoading || current is AuthSuccess;
        },

        builder: (context, state) {
          // Mostrar loader durante el logout
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Mostrar contenido del home (solo cuando es AuthSuccess)
          if (state is AuthSuccess) {
            return Center(
              child: Column(
                children: [
                  Text(state.uid),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                  ),
                ],
              ),
            );
          }

          // Fallback (no debería llegar aquí gracias a buildWhen)
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
