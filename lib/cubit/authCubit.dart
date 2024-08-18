import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pro2/models/loginModel.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:pro2/services/cashHelper.dart';
import 'package:pro2/services/dioHelper.dart';

part 'authState.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login({required String email, required String password}) {
    emit(LoginLoadingState());

    final data = {
      'email': email,
      'password': password,
    };

    DioHelper.post(path: 'user_login', data: data).then((value) {
      print("Response status: ${value?.statusCode}");
      print("Response data: ${value?.data}");

      if (value?.data != null) {
        final loginModel = LoginModel.fromJson(value?.data);
        if (loginModel.success == true) {
          final token = loginModel.data?.token;
          final wallet = loginModel.data?.wallet;
          CachHelper.setString(key: 'token', value: token ?? '');
          CachHelper.setString(key: 'email', value: email);
          CachHelper.setString(key: 'password', value: password);

          ApiModel().token = token ?? '';
          ApiModel().email = email;
          ApiModel().password = password;
          ApiModel().wallet = wallet ?? 0;

          ApiModel().updateHeaders();

          emit(LoginSuccessState());
        } else {
          emit(LoginErrorState());
        }
      } else {
        emit(LoginErrorState());
      }
    }).catchError((error) {
      if (error is DioError) {
        print('DioError: ${error.response?.data}');
      }
      print("Error: $error");
      emit(LoginErrorState());
    });
  }

  void register(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) {
    emit(RegisterLoadingState());

    final data = {
      'full_name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    DioHelper.post(path: 'user_register', data: data).then((value) {
      print("Response status: ${value?.statusCode}");
      print("Response data: ${value?.data}");

      if (value?.data != null) {
        final loginModel = LoginModel.fromJson(value?.data);
        if (loginModel.success == true) {
          final token = loginModel.data?.token;
          final wallet = loginModel.data?.wallet;
          CachHelper.setString(key: 'token', value: token ?? '');
          CachHelper.setString(key: 'email', value: email);
          CachHelper.setString(key: 'password', value: password);

          ApiModel().token = token ?? '';
          ApiModel().email = email;
          ApiModel().password = password;
          ApiModel().wallet = wallet ?? 0;

          ApiModel().updateHeaders();

          emit(RegisterSuccessState());
        } else {
          emit(RegisterErrorState());
        }
      } else {
        emit(RegisterErrorState());
      }
    }).catchError((error) {
      if (error is DioException) {
        print('DioError: ${error.response?.data}');
      }
      print("Error: $error");
      emit(RegisterErrorState());
    });
  }

  void logout() {
    ApiModel().logout().then((value) {
      if (value.success == true) {
        CachHelper.setString(key: 'token', value: '');
        emit(LogoutSuccessState());
      } else {
        emit(LogoutErrorState());
      }
    }).catchError((error) {
      emit(LogoutErrorState());
    });
  }
}




























// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:pro2/models/loginModel.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:pro2/services/dioHelper.dart';

// part 'authState.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     final data = {
//       'email': email,
//       'password': password,
//     };

//     DioHelper.post(path: 'user_login', data: data).then((value) {
//       print("Response status: ${value?.statusCode}");
//       print("Response data: ${value?.data}");

//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           ApiModel().token = token ?? '';
//           ApiModel().wallet = wallet ?? 0;

//           ApiModel().updateHeaders();

//           emit(LoginSuccessState());
//         } else {
//           print("Login failed: ${loginModel.message}");
//           emit(LoginErrorState());
//         }
//       } else {
//         print("No data received in response.");
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       if (error is DioError) {
//         print('DioError: ${error.response?.data}');
//         print('DioError: ${error.response?.statusCode}');
//         print('DioError: ${error.response?.headers}');
//         print('DioError: ${error.response?.requestOptions}');
//       }
//       print("Error: $error");
//       emit(LoginErrorState());
//     });
//   }

//   void register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     final data = {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     };

//     DioHelper.post(path: 'user_register', data: data).then((value) {
//       print("Response status: ${value?.statusCode}");
//       print("Response data: ${value?.data}");

//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           ApiModel().token = token ?? '';
//           ApiModel().wallet = wallet ?? 0;

//           ApiModel().updateHeaders();

//           emit(RegisterSuccessState());
//         } else {
//           print("Registration failed: ${loginModel.message}");
//           emit(RegisterErrorState());
//         }
//       } else {
//         print("No data received in response.");
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       if (error is DioError) {
//         print('DioError: ${error.response?.data}');
//         print('DioError: ${error.response?.statusCode}');
//         print('DioError: ${error.response?.headers}');
//         print('DioError: ${error.response?.requestOptions}');
//       }
//       print("Error: $error");
//       emit(RegisterErrorState());
//     });
//   }

//   void logout() {
//     ApiModel().logout().then((value) {
//       if (value.success == true) {
//         CachHelper.setString(key: 'token', value: '');
//         emit(LogoutSuccessState());
//       } else {
//         emit(LogoutErrorState());
//       }
//     }).catchError((error) {
//       emit(LogoutErrorState());
//     });
//   }
// }
















// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:pro2/models/loginModel.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:pro2/services/dioHelper.dart';

// part 'authState.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     final data = {
//       'email': email,
//       'password': password,
//     };

//     DioHelper.post(path: 'user_login', data: data).then((value) {
//       print("Response status: ${value?.statusCode}");
//       print("Response data: ${value?.data}");

//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           ApiModel().token = token ?? '';
//           ApiModel().wallet = wallet ?? 0;

//           ApiModel().updateHeaders();

//           emit(LoginSuccessState());
//         } else {
//           emit(LoginErrorState());
//         }
//       } else {
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       if (error is DioException) {
//         print('DioError: ${error.response?.data}');
//       }
//       print("Error: $error");
//       emit(LoginErrorState());
//     });
//   }

//   void register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     final data = {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     };

//     DioHelper.post(path: 'user_register', data: data).then((value) {
//       print("Response status: ${value?.statusCode}");
//       print("Response data: ${value?.data}");

//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           ApiModel().token = token ?? '';
//           ApiModel().wallet = wallet ?? 0;

//           ApiModel().updateHeaders();

//           emit(RegisterSuccessState());
//         } else {
//           emit(RegisterErrorState());
//         }
//       } else {
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       if (error is DioException) {
//         print('DioError: ${error.response?.data}');
//       }
//       print("Error: $error");
//       emit(RegisterErrorState());
//     });
//   }

//   void logout() {
//     ApiModel().logout().then((value) {
//       if (value.success == true) {
//         CachHelper.setString(key: 'token', value: '');
//         emit(LogoutSuccessState());
//       } else {
//         emit(LogoutErrorState());
//       }
//     }).catchError((error) {
//       emit(LogoutErrorState());
//     });
//   }
// }























// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     DioHelper.post(path: 'user_login', data: {
//       'email': email,
//       'password': password,
//     }).then((value) {
//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           final apiModel = ApiModel();
//           apiModel.token = token ?? '';
//           apiModel.wallet = wallet ?? 0;

//           apiModel.updateHeaders();

//           emit(LoginSuccessState());
//         } else {
//           emit(LoginErrorState());
//         }
//       } else {
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       emit(LoginErrorState());
//     });
//   }

//   void register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     DioHelper.post(path: 'user_register', data: {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     }).then((value) {
//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           final apiModel = ApiModel();
//           apiModel.token = token ?? '';
//           apiModel.wallet = wallet ?? 0;

//           apiModel.updateHeaders();

//           emit(RegisterSuccessState());
//         } else {
//           emit(RegisterErrorState());
//         }
//       } else {
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       emit(RegisterErrorState());
//     });
//   }

//   void logout() {
//     final apiModel = ApiModel();
//     apiModel.logout().then((value) {
//       if (value.success == true) {
//         CachHelper.setString(key: 'token', value: '');
//         emit(LogoutSuccessState());
//       } else {
//         emit(LogoutErrorState());
//       }
//     }).catchError((error) {
//       emit(LogoutErrorState());
//     });
//   }
// }


















// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:pro2/models/loginModel.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:pro2/services/dioHelper.dart';

// part 'authState.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     DioHelper.post(path: 'user_login', data: {
//       'email': email,
//       'password': password,
//     }).then((value) {
//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           ApiModel().token = token ?? '';
//           ApiModel().wallet = wallet ?? 0;

//           ApiModel().updateHeaders();

//           emit(LoginSuccessState());
//         } else {
//           emit(LoginErrorState());
//         }
//       } else {
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       emit(LoginErrorState());
//     });
//   }

//   void register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     DioHelper.post(path: 'user_register', data: {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     }).then((value) {
//       if (value?.data != null) {
//         final loginModel = LoginModel.fromJson(value?.data);
//         if (loginModel.success == true) {
//           final token = loginModel.data?.token;
//           final wallet = loginModel.data?.wallet;
//           CachHelper.setString(key: 'token', value: token ?? '');
//           ApiModel().token = token ?? '';
//           ApiModel().wallet = wallet ?? 0;

//           ApiModel().updateHeaders();

//           emit(RegisterSuccessState());
//         } else {
//           emit(RegisterErrorState());
//         }
//       } else {
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       emit(RegisterErrorState());
//     });
//   }

//   void logout() {
//     ApiModel().logout().then((value) {
//       if (value.success == true) {
//         CachHelper.setString(key: 'token', value: '');
//         emit(LogoutSuccessState());
//       } else {
//         emit(LogoutErrorState());
//       }
//     }).catchError((error) {
//       emit(LogoutErrorState());
//     });
//   }
// }





















// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     DioHelper.post(path: 'user_login', data: {
//       'email': email,
//       'password': password,
//     }).then((value) async {
//       if (value?.data['data'] != null) {
//         final token = value?.data['data']['token'];
//         CachHelper.setString(key: 'token', value: token);
//         ApiModel().token = token;
//         ApiModel().updateHeaders();

//         // Fetch wallet information
//         await ApiModel().fetchWallet();

//         emit(LoginSuccessState());
//       } else {
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       emit(LoginErrorState());
//     });
//   }

//   void register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     DioHelper.post(path: 'user_register', data: {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     }).then((value) async {
//       if (value?.data['data'] != null) {
//         final token = value?.data['data']['token'];
//         CachHelper.setString(key: 'token', value: token);
//         ApiModel().token = token;
//         ApiModel().updateHeaders();

//         // Fetch wallet information
//         await ApiModel().fetchWallet();

//         emit(RegisterSuccessState());
//       } else {
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       emit(RegisterErrorState());
//     });
//   }

//   void logout() {
//     ApiModel().logout().then((value) {
//       if (value.success == true) {
//         CachHelper.setString(key: 'token', value: '');
//         emit(LogoutSuccessState());
//       } else {
//         emit(LogoutErrorState());
//       }
//     }).catchError((error) {
//       emit(LogoutErrorState());
//     });
//   }
// }













// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     DioHelper.post(path: 'user_login', data: {
//       'email': email,
//       'password': password,
//     }).then((value) {
//       if (value?.data['data'] != null) {
//         final token = value?.data['data']['token'];
//         CachHelper.setString(key: 'token', value: token);
//         ApiModel().token = token;

//         ApiModel().updateHeaders();

//         emit(LoginSuccessState());
//       } else {
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       emit(LoginErrorState());
//     });
//   }

//   void register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     DioHelper.post(path: 'user_register', data: {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     }).then((value) {
//       if (value?.data['data'] != null) {
//         final token = value?.data['data']['token'];
//         CachHelper.setString(key: 'token', value: token);
//         ApiModel().token = token;
//         ApiModel().updateHeaders();
//         emit(RegisterSuccessState());
//       } else {
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       emit(RegisterErrorState());
//     });
//   }

//   void logout() {
//     ApiModel().logout().then((value) {
//       if (value.success == true) {
//         CachHelper.setString(key: 'token', value: '');
//         emit(LogoutSuccessState());
//       } else {
//         emit(LogoutErrorState());
//       }
//     }).catchError((error) {
//       emit(LogoutErrorState());
//     });
//   }
// }
















// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());

//   void login({required String email, required String password}) {
//     emit(LoginLoadingState());

//     DioHelper.post(path: 'user_login', data: {
//       'email': email,
//       'password': password,
//     }).then((value) {
//       if (value?.data['data'] != null) {
//         final token = value?.data['data']['token'];
//         CachHelper.setString(key: 'token', value: token);
//         ApiModel().token = token;
//         ApiModel()._updateHeaders();
//         emit(LoginSuccessState());
//       } else {
//         emit(LoginErrorState());
//       }
//     }).catchError((error) {
//       emit(LoginErrorState());
//     });
//   }

//   void register({required String name, required String email, required String password, required String confirmPassword}) {
//     emit(RegisterLoadingState());

//     DioHelper.post(path: 'user_register', data: {
//       'full_name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword,
//     }).then((value) {
//       if (value?.data['data'] != null) {
//         final token = value?.data['data']['token'];
//         CachHelper.setString(key: 'token', value: token);
//         ApiModel().token = token;
//         ApiModel()._updateHeaders();
//         emit(RegisterSuccessState());
//       } else {
//         emit(RegisterErrorState());
//       }
//     }).catchError((error) {
//       emit(RegisterErrorState());
//     });
//   }
// }







// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//   AuthCubit get(context) => BlocProvider.of(context);
//   LoginModel? loginModel;

//   void register({
//     required String? name,
//     required String? email,
//     required String? password,
//     required String? confirmPassword,
//   }) {
//     emit(RegisterLoadingState());
//     DioHelper.post(
//       path: "user_register",
//       data: {
//         "full_name": name,
//         "email": email,
//         "password": password,
//         "password_confirmation": confirmPassword,
//       },
//     ).then((value) {
//       if (value?.data["data"] != null) {
//         loginModel = LoginModel.fromJson(value?.data["data"]);
//         CachHelper.setString(
//             key: "token", value: loginModel?.data?.token ?? '');
//       }
//       emit(RegisterSuccessState());
//     }).catchError((error) {
//       print(error);
//       emit(RegisterErrorState());
//     });
//   }

//   void login({
//     required String? email,
//     required String? password,
//   }) {
//     emit(LoginLoadingState());
//     DioHelper.post(
//       path: "user_login",
//       data: {"email": email, "password": password},
//     ).then((value) {
//       if (value?.data["data"] != null) {
//         loginModel = LoginModel.fromJson(value?.data["data"]);
//         CachHelper.setString(
//             key: "token", value: loginModel?.data?.token ?? '');
//       }
//       emit(LoginSuccessState());
//     }).catchError((error) {
//       print(error.response.statusCode);
//       emit(LoginErrorState());
//     });
//   }
// }
















// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//   AuthCubit get(context) => BlocProvider.of(context);
//   LoginModel? loginModel;
//   rejester({
//     required String? name,
//     required String? email,
//     required String? password,
//     required String? confirm_password,
//   }) {
//     emit(RejesterLoadingState());
//     DioHelper.post(path: "user_register", data: {
//       "full_name": name,
//       "email": email,
//       "password": password,
//       "password_confirmation": confirm_password
//     }).then((value) {
//       value?.data["data"] != null
//           ? loginModel = LoginModel.fromJson(value?.data["data"])
//           : null;
//       CachHelper.setString(key: "token", value: " ${loginModel?.data?.token}");
//       print(value?.data);
//       print("ppppppppppp");
//       emit(RejesterSuccesState());
//     }).catchError((error) {
//       print(error);
//       emit(RejesterErrorState());
//     });
//   }

//   login({
//     required String? email,
//     required String? password,
//   }) {
//     emit(LoginLoadingState());
//     print("qqqqq");

//     DioHelper.post(
//         path: "user_login",
//         data: {"email": email, "password": password}).then((value) {
//       value?.data["data"] != null
//           ? loginModel = LoginModel.fromJson(value?.data["data"])
//           : null;
//       CachHelper.setString(key: "token", value: " ${loginModel?.data?.token}");
//       print(CachHelper.getString(key: "token"));
//       print(loginModel?.data?.token);
//       print("dddd");
//       print(value?.data);
//       print("****");
//       emit(LoginSuccesState());
//     }).catchError((error) {
//       print(error.response.statusCode);
//       emit(LoginErrorState());
//     });
//   }
// }
