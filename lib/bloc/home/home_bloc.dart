import 'package:app/data/model/model.dart';
import 'package:app/data/provider/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeGetService>(_getServices);
    on<CreateOrder>(_createOrder);
  }

  void _getServices(HomeGetService event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      var client = DioClient();
      await client.dio
          .get(
        "service/all",
      )
          .then((value) {
        var data = value.data;

        if (data['status'] == 200) {
          emit(HomeInitial(
              services: (data['data'] as List)
                  .map((e) => Service.fromJson(e))
                  .toList()));
        } else {
          emit(HomeFailure(
            error: data['message'] ?? 'Алдаа гарлаа',
          ));
        }
      }).catchError((error) {
        emit(HomeFailure(
          error: error.toString(),
        ));
      });
    } catch (e) {
      return emit(HomeFailure(
        error: e.toString(),
      ));
  }
  }

  void _createOrder(CreateOrder event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      var id = event.id;
      var client = DioClient();
      var data = {"service": id};

      await client.dio.post("order", data: data).then((value) {
        var data = value.data;

        if (data['success']) {
          emit(SuccessOrder(
            id: data['id'],
            success: data['success'],
            message: data['message'],
            status: data['status'],
          ));
        } else {
          emit(HomeFailure(
            error: data['message'] ?? 'Алдаа гарлаа',
          ));
        }
      }).catchError((error) {
        emit(HomeFailure(
          error: error.toString(),
        ));
      });
    } catch (e) {
      return emit(HomeFailure(
        error: e.toString(),
      ));
    }
  }
}
