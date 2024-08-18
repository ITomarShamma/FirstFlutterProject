import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:pro2/services/dioHelper.dart';

part 'appState.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  AppCubit get(context) => BlocProvider.of(context);
  int index = 0;
  curentIndex(value) {
    index = value;
    emit(ChangeIndexState());
  }
}
  // HomeModel? homeModel;
  // getHome() {
  //   emit(GetHomeDataLoadingState());
  //   DioHelper.get(path: "type_event").then((value) {
  //     homeModel = HomeModel.fromJson(value?.data);
  //     print(homeModel?.data?[1].id);
  //     emit(GetHomeDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetHomeDataErrorState());
  //   });
  // }

