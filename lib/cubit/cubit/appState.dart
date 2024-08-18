part of 'appCubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class GetHomeDataLoadingState extends AppState {}

class GetHomeDataSuccessState extends AppState {}

class GetHomeDataErrorState extends AppState {}

class ChangeIndexState extends AppState {}
