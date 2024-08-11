import 'package:app/bloc/auth/auth_bloc.dart';
import 'package:app/bloc/home/home_bloc.dart';
import 'package:app/shared/constants/spaces.dart';
import 'package:app/shared/widgets/card/service_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc();
        bloc.add(HomeGetService());
        return bloc;
      },
      child: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text("Хамгаалалтын төрлүүд"),
                space20,
                SingleChildScrollView(
                  child: Container(
                    height: 200,
                    child: StaggeredGrid.count(
                      crossAxisCount: 36,
                      // axisDirection: AxisDirection.left,
                      // mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: state.services?.map((service) {
                            int i = (state.services ?? []).indexOf(service);
                            int cross = 9;
                            int main = 9;
                            int length = state.services?.length ?? 0;

                            if (length % 4 == 0) {
                              null;
                            } else {
                              if (length % 3 == 0) {
                                (i - 1) % 3 == 0 ? cross = 14 : cross = 11;
                              } else {
                                if (length % 4 == 2) {
                                  i < 6
                                      ? (i - 1) % 3 == 0
                                          ? cross = 14
                                          : cross = 11
                                      : null;
                                } else {
                                  if (length % 4 == 3) {
                                    i < 3
                                        ? (i - 1) % 3 == 0
                                            ? cross = 14
                                            : cross = 11
                                        : null;
                                  }
                                }
                              }
                            }

                            return StaggeredGridTile.count(
                                crossAxisCellCount: cross,
                                mainAxisCellCount: main,
                                child: ServiceCard(
                                    text: service.text ?? '',
                                    img: service.img ?? '',
                                    onTap: () {
                                      if (service.sId != null) {
                                        context.read<HomeBloc>().add(
                                              CreateOrder(id: service.sId!),
                                            );
                                      }
                                    },
                                    label: (service.count ?? 0) > 100
                                        ? 'Эрэлт ихтэй '
                                        : null));
                          }).toList() ??
                          [],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is SuccessOrder) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Амжилттай захиалга өглөө."),
              ),
            );
          }
        },
      ),
    );
  }
}
