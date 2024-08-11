import 'package:app/bloc/auth/auth_bloc.dart';
import 'package:app/bloc/page/page_bloc.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'package:app/presentation/screens/login_screen.dart';
import 'package:app/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<Widget> bottomNavScreen = [
  HomeScreen(),
  Text('Man'),
  Text('History'),
  Text('Profile'),
];

final List<String> titles = ['Нүүр', "Man", "Түүх", "Профайл"];

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageBloc(),
      child: BlocConsumer<PageBloc, PageState>(
        listener: (context, state) {
          if (state is PageInitial) {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const LoginScreen(),
            //   ),
            //   (route) => false,
            // );
          }
        },
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          return Scaffold(
            appBar: AppBar(
              title: Text(titles[state.tabIndex]),
            ),
            body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home), label: titles[0]),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.local_activity), label: titles[1]),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.history), label: titles[2]),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.account_box), label: titles[3]),
              ],
              currentIndex: state.tabIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.black,
              onTap: (index) {
                BlocProvider.of<PageBloc>(context)
                    .add(TabChange(tabIndex: index));
              },
            ),
          );
        },
      ),
    );
  }
}
