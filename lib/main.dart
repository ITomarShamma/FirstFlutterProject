// import 'package:flutter/material.dart';
// import 'package:pro2/areaPage.dart';
// import 'package:pro2/auth/loginPage.dart';
// import 'package:pro2/auth/registerPage.dart';
// import 'package:pro2/budgetPage.dart';
// import 'package:pro2/cubit/authCubit.dart';
// import 'package:pro2/cubit/cubit/appCubit.dart';
// import 'package:pro2/datePage.dart';
// import 'package:pro2/decorationPage.dart';
// import 'package:pro2/foodPage.dart';
// import 'package:pro2/global/color.dart';
// import 'package:pro2/global/localizationDelegate.dart';
// import 'package:pro2/global/localizationModel.dart';
// import 'package:pro2/homePage.dart';
// import 'package:pro2/homePagev.dart';
// import 'package:pro2/musicPage.dart';
// import 'package:pro2/provincesPage.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:pro2/services/dioHelper.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// bool isDarkTheme = false; // Change this based on your theme toggle logic
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DioHelper.init();
//   await CachHelper.init();

//   final apiModel = ApiModel();
//   final localizationModel = LocalizationModel();

//   runApp(MyApp(apiModel: apiModel, localizationModel: localizationModel));
// }

// class MyApp extends StatelessWidget {
//   final ApiModel apiModel;
//   final LocalizationModel localizationModel;

//   const MyApp(
//       {super.key, required this.apiModel, required this.localizationModel});

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<ApiModel>(
//       model: apiModel,
//       child: ScopedModel<LocalizationModel>(
//         model: localizationModel,
//         child: ScopedModelDescendant<LocalizationModel>(
//           builder: (context, child, model) {
//             return MultiBlocProvider(
//               providers: [
//                 BlocProvider(create: (context) => AuthCubit()),
//                 // BlocProvider(create: (context) => AppCubit()..getHome()),
//               ],
//               child: MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 locale: model.locale,
//                 supportedLocales: [
//                   Locale('en', ''),
//                   Locale('ar', ''),
//                 ],
//                 localizationsDelegates: [
//                   const AppLocalizationsDelegate(),
//                   //GlobalMaterialLocalizations.delegate,
//                   //GlobalWidgetsLocalizations.delegate,
//                 ],
//                 theme: isDarkTheme ? _buildDarkTheme() : _buildLightTheme(),
//                 home: apiModel.token != null
//                     ? LoginScreen()
//                     : HomePageSaraWidget(),
//                 routes: {
//                   '/home': (context) => HomePageSaraWidget(),
//                   '/login': (context) => LoginScreen(),
//                   '/register': (context) => RegisterScreen(),
//                   // '/area': (context) => AreaPage(),
//                   // '/budget': (context) => BudgetPage(),
//                   // '/date': (context) => DatePage(),
//                   // '/decoration': (context) => DecorationPage(),
//                   // '/food': (context) => FoodPage(),
//                   // '/music': (context) => MusicPage(),
//                   // '/provinces': (context) => ProvincesPage(),
//                   // '/services': (context) => ServicesPage(),
//                   // '/profile': (context) => ProfilePage(token: apiModel.token!),
//                   // '/about': (context) => AboutUsPage(),
//                   // '/contact': (context) => ContactUsPage(),
//                   // '/settings': (context) => SettingsPage(),
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// if (ApiModel().token != null) {
//   print("Token: ${ApiModel().token}");
// } else {
//   print("Token not found.");
//   ScopedModel<ApiModel>(
//     model: ApiModel(),
//     child: MultiBlocProvider(
//         child: MaterialApp(
//             debugShowCheckedModeBanner: false, home: LoginScreen()),
//         providers: [
//           BlocProvider(create: (context) => AuthCubit()),
//           // BlocProvider(create: (context) => AppCubit()..getHome())
//         ]),
//   );
// }

import 'package:flutter/material.dart';
import 'package:pro2/DrawerPages/myWalletPage.dart';
import 'package:pro2/auth/loginPage.dart';
import 'package:pro2/cubit/authCubit.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/homePagev.dart';
import 'package:pro2/services/cashHelper.dart';
import 'package:pro2/services/dioHelper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CachHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final apiModel = ApiModel();

class _MyAppState extends State<MyApp> {
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = CachHelper.getString(key: 'token') != '';
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ApiModel>(
      model: apiModel,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isLoggedIn ? const HomePageSaraWidget() : const LoginScreen(),
          //isLoggedIn ? const HomePageSaraWidget() :
          routes: {
            '/wallet': (context) =>
                const MyWalletHistoryPage(), // add this route
          },
        ),
      ),
    );
  }
}
//model.setHallPrice(HallPrice: hall?.price ?? 0);
// import 'package:flutter/material.dart';
// import 'package:pro2/DrawerPages/myWalletPage.dart';
// import 'package:pro2/auth/loginPage.dart';
// import 'package:pro2/cubit/authCubit.dart';
// import 'package:pro2/global/color.dart';
// import 'package:pro2/homePagev.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:pro2/services/dioHelper.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DioHelper.init();
//   await CachHelper.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// final apiModel = ApiModel();

// class _MyAppState extends State<MyApp> {
//   late bool isLoggedIn;

//   @override
//   void initState() {
//     super.initState();
//     isLoggedIn = CachHelper.getString(key: 'token') != '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<ApiModel>(
//       model: apiModel,
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => AuthCubit()),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: isLoggedIn ? const HomePageSaraWidget() : const LoginScreen(),
//           //

//           routes: {
//             '/wallet': (context) =>
//                 const MyWalletHistoryPage(), // add this route
//           },
//         ),
//       ),
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DioHelper.init();
//   await CachHelper.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// final apiModel = ApiModel();

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<ApiModel>(
//       model: ApiModel(),
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => AuthCubit()),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: CachHelper.getString(key: 'token') == null
//               ? const LoginScreen()
//               : const HomePageSaraWidget(),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:pro2/cubit/authCubit.dart';
// import 'package:pro2/global/color.dart';
// import 'package:pro2/homePagev.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:pro2/services/dioHelper.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   await {
//     runApp(const MyApp()),
//     DioHelper.init(),
//     CachHelper.init(),
//   };

// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// final apiModel = ApiModel();
// //final LocalizationModel localizationModel = LocalizationModel();

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return
//         //     MaterialApp(home: Scaffold(body: homeScreen()),);
//         ScopedModel<ApiModel>(
//       model: ApiModel(),
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => AuthCubit()),
//           // BlocProvider(create: (context) => AppCubit()..getHome())
//         ],
//         child: const MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: HomePageSaraWidget(),
//         ),
//       ),
//     );

//     //create: (context) => AuthCubit(),
//   }
// }

ThemeData _buildLightTheme() {
  return ThemeData(
    primaryColor: ColorManager.primaryColor,
    //accentColor: ColorManager.primaryColor2,
    // Define more theme properties as needed
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: DarkColorManager.primaryColor,
    //accentColor: DarkColorManager.primaryColor2,
    // Define more dark theme properties as needed
  );
}

// void main() {

//   runApp(
//     ScopedModel<ApiModel>(
//       model: apiModel,
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   var apiModel = ApiModel();

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<ApiModel>(
//       model: ApiModel(),
//       child: MaterialApp(
//         home: rejesterScreen(),
//         // home: Budget(
//         //   areaId: apiModel.areaId ?? 0, // Default value if areaId is null
//         //   townId: apiModel.townId ?? 0, // Default value if townId is null
//         //   typeEventId:
//         //       apiModel.typeEventId ?? 0, // Default value if typeEventId is null
//         //   token: ApiModel().token,
//         // ),
//         initialRoute: '/',
//         routes: {
//           //'/': (context) => HomePageSaraWidget(),
//           '/budget': (context) => Budget(
//                 areaId: apiModel.areaId ?? 0,
//                 townId: apiModel.townId ?? 0,
//                 typeEventId: apiModel.typeEventId ?? 0,
//                 token: apiModel.token,
//               ),
//           '/wedding': (context) => WeddingHallOmarWidget(
//                 areaId: apiModel.areaId ?? 0,
//                 townId: apiModel.townId ?? 0,
//                 typeEventId: apiModel.typeEventId ?? 0,
//                 budgetId: apiModel.budgetId ?? 0,
//                 token: apiModel.token,
//               ),
//           '/provinces': (context) => Provinces(
//                 typeEventId: apiModel.typeEventId ?? 0,
//                 token: apiModel.token,
//               ),
//           '/areas': (context) => AreaPage(
//                 typeEventId: apiModel.typeEventId ?? 0,
//                 townId: apiModel.townId ?? 0,
//                 token: apiModel.token,
//               ),
//           '/dates': (context) => DatePage7alaWidget(
//                 placeId: apiModel.placeId ?? 0,
//                 token: apiModel.token,
//               )
//         },
//       ),
//     );
//   }
// }
