import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/services/auth/bloc/auth_bloc.dart';
import 'package:planttracker_app/services/auth/bloc/auth_event.dart';
import 'package:planttracker_app/services/auth/bloc/auth_state.dart';
import 'package:planttracker_app/services/auth/firebase_auth_provider.dart';
import 'package:planttracker_app/views/plants/create_update_plant_view.dart';
import 'package:planttracker_app/views/plants/plants_view.dart';
import 'package:planttracker_app/views/login_view.dart';
import 'package:planttracker_app/views/register_view.dart';
import 'package:planttracker_app/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createUpdatePlantRoute: (context) => const CreateUpdatePlantView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const PlantsView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
