import 'package:app/bloc/auth/auth_bloc.dart';
import 'package:app/bloc/page/page_bloc.dart';
import 'package:app/presentation/screens/page_screen.dart';
import 'package:app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  final AuthBloc authBloc = AuthBloc();
  final PageBloc pageBloc = PageBloc();
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(settings.name);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthBloc>.value(
                  value: authBloc,
                  child: const LoginScreen(),
                ));
      case '/home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PageBloc>.value(
                  value: pageBloc,
                  child: const PageScreen(),
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
