import 'package:app/app_bloc_observer.dart';
import 'package:app/bloc/auth/auth_bloc.dart';
import 'package:app/data/model/service.dart';
import 'package:app/presentation/routes/generated_routes.dart';
import 'package:app/presentation/screens/login_screen.dart';
import 'package:app/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // Widget _buildMovies(List<Service> services) => ListView.builder(
  //       itemCount: services.length,
  //       itemBuilder: (context, index) => ListTile(
  //         title: Text(services[index].title),
  //         subtitle: Text(services[index].imdb_id),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator().generateRoute,
        // theme: ThemeData.dark().copyWith(
        //   scaffoldBackgroundColor: Pallete.backgroundColor,
        // ),
        home: const LoginScreen(),
      ),
    );
  }
  // return Scaffold(
  //   body: Center(
  //     child: BlocBuilder(
  //       bloc: ServiceBloc()..add(ServiceFetchEvent()),
  //       builder: (context, state) {
  //         switch (state.runtimeType) {
  //           case ServiceInitial:
  //           case ServiceLoading:
  //             return const Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           case ServiceSuccess:
  //             var movies = (state as ServiceSuccess).service;
  //             return _buildMovies(movies);
  //           case ServiceFailure:
  //             var errorMessage = (state as ServiceFailure).errorMessage;
  //             return Center(
  //               child: Text(errorMessage),
  //             );
  //           default:
  //             return Container();
  //         }
  //       },
  //     ),
  //   ),
  // );
}
