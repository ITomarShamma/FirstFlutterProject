import 'package:carousel_slider/carousel_controller.dart';
import 'package:pro2/models/dateModel.dart';
import 'package:pro2/models/decorationModel.dart';
import 'package:pro2/models/foodModel.dart';
import 'package:pro2/models/getHallModel.dart';
import 'package:pro2/models/homePageModel.dart';
import 'package:pro2/models/loginModel.dart';
import 'package:pro2/models/logoutModel.dart';
import 'package:pro2/models/musicModel.dart';
import 'package:pro2/models/submitModel.dart';
import 'package:pro2/services/cashHelper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:pro2/models/provinceModel.dart';
import 'package:pro2/models/areaModel.dart';
import 'package:pro2/models/budgetModel.dart';
import 'package:pro2/budgetPage.dart';
import 'package:pro2/models/MonthModel.dart';
import 'package:pro2/models/profileModel.dart';

class ApiModel extends Model {
  late Dio _dio;
  String token = CachHelper.getString(key: "token") ?? '';
  String email = CachHelper.getString(key: "email") ?? '';
  String password = CachHelper.getString(key: "password") ?? '';
  ApiModel() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ));
  }

  void updateHeaders() {
    token = CachHelper.getString(key: "token") ?? '';

    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  CarouselController carouselController = CarouselController();
  int? wallet;
  int carouselCurrentIndex = 0;
  List<TownData> towns = [];
  List<AreaData> areas = [];
  List<BudgetData> budgets = [];
  List<HomeData> eventTypes = [];
  List<String> availableMonths = [];
  List<DateData> dates = [];
  List<Typemusic> typemusic = [];
  List<Sing> sing = [];
  List<More> more = [];
  List<MainMeal> mainMeals = [];
  List<SweateType> sweateTypes = [];
  List<MainCake> mainCakes = [];
  List<ChairsNumber> chairsNumber = [];
  List<TableesNumber> tableesNumber = [];
  List<Lighting> lighting = [];
  List<Theme> theme = [];
  List<ThemeColor> themeColor = [];
  ProfileData? profileData;
  int? typeEventId;
  int? townId;
  int? areaId;
  int? budgetId;
  int? placeId;

  bool isLoadingDecoration = false;
  bool isLoadingFood = false;
  bool isLoadingMusic = false;
  bool isLoadingTowns = false;
  bool isLoadingAreas = false;
  bool isLoadingBudgets = false;
  bool isLoadingHalls = false;
  bool isLoadingEventTypes = false;
  bool isLoadingMonths = false;
  bool isLoadingProfile = false;

  String? selectedEventType;
  String? selectedTownName;
  String? selectedAreaName;
  String? selectedBudgetName;
  String? selectedHallName;
  int? selectedHallNamePrice;
  String? selectedMusicDetails;
  String? selectedFoodDetails;
  String? selectedDecorationDetails;

  String? selectedChairsNumber;
  int? selectedChairsNumberPrice;
  String? selectedTablesNumber;
  int? selectedTablesNumberPrice;
  String? selectedLighting;
  String? selectedTheme;
  int? selectedThemePrice;
  String? selectedThemeColor;
  int? selectedThemeColorPrice;

  String? selectedMainMeal;
  int? selectedMainMealPrice;
  String? selectedSweateType;
  int? selectedSweateTypePrice;
  String? selectedMainCake;
  int? selectedMainCakePrice;

  String? selectedMusicType;
  int? selectedMusicTypePrice;
  String? selectedSong;
  String? selectedMoreDetails;

  String? selectedMonth;
  String? selectedDate;

  Timer? _debounce;

  Future<bool> fetchSubmit(int priceTotal) async {
    updateHeaders();
    print('Submitting booking with total price: $priceTotal');
    try {
      final response = await _dio.post('/user/booking', data: {
        'pricetotal': priceTotal,
      });
      print('Response: ${response.data}');
      if (response.data['success']) {
        final submitModel = SubmitModel.fromJson(response.data);
        print('Submission successful: ${submitModel.message}');
        return submitModel.message == "Reservation successfully";
      } else {
        print('Error: ${response.data['message']}');
        return false;
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        print('DioError: ${e.response?.statusCode}');
        print('DioError: ${e.response?.headers}');
        print('DioError: ${e.response?.requestOptions}');
      }
      print('Error: $e');
      return false;
    }
  }
  // Future<void> fetchSubmit(int priceTotal) async {
  //   updateHeaders();
  //   print('Submitting booking with total price: $priceTotal');
  //   try {
  //     final response = await _dio.post('/user/booking', data: {
  //       'pricetotal': priceTotal,
  //     });
  //     print('Response: ${response.data}');
  //     if (response.data['success']) {
  //       final submitModel = SubmitModel.fromJson(response.data);
  //       print('Submission successful: ${submitModel.message}');
  //     } else {
  //       print('Error: ${response.data['message']}');
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       print('DioError: ${e.response?.data}');
  //       print('DioError: ${e.response?.statusCode}');
  //       print('DioError: ${e.response?.headers}');
  //       print('DioError: ${e.response?.requestOptions}');
  //     }
  //     print('Error: $e');
  //   }
  // }

  Future<void> fetchWallet() async {
    updateHeaders();
    print('Fetching wallet with token: $token');
    try {
      final response = await _dio.post('/user_login', data: {
        'email': email, // Replace with actual email
        'password': password, // Replace with actual password
      });
      print('Response: ${response.data}');
      if (response.data['success']) {
        wallet = response.data['data']['wallet'];
        notifyListeners();
      } else {
        print('Error: ${response.data['message']}');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        print('DioError: ${e.response?.statusCode}');
        print('DioError: ${e.response?.headers}');
        print('DioError: ${e.response?.requestOptions}');
      }
      print('Error: $e');
    }
  }

  Future<void> fetchProfile() async {
    isLoadingProfile = true;
    notifyListeners();

    updateHeaders();
    try {
      final response = await _dio.get('/user/user_profile');
      if (response.data['success']) {
        profileData = ProfileData.fromJson(response.data['data']);
      } else {
        print('Error: ${response.data['message']}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoadingProfile = false;
      notifyListeners();
    }
  }

  Future<void> fetchTowns(int typeEventId) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      towns.clear(); // Clear towns before fetching new data
      isLoadingTowns = true;
      notifyListeners();
      updateHeaders();
      await _retry(
        () async {
          final response = await _dio.post(
            '/user/gettown',
            data: {'type_event_id': typeEventId},
          );
          if (response.data['success']) {
            towns = (response.data['data'] as List)
                .map((townData) => TownData.fromJson(townData))
                .toList();
            isLoadingTowns = false;
            notifyListeners();
          } else {
            print('Error: ${response.data['message']}');
          }
        },
      );
    });
  }

  Future<void> fetchAreas(int typeEventId, int townId) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      areas.clear(); // Clear areas before fetching new data
      isLoadingAreas = true;
      notifyListeners();
      updateHeaders();
      await _retry(
        () async {
          final response = await _dio.post(
            '/user/getarea',
            data: {'type_event_id': typeEventId, 'town_id': townId},
          );

          if (response.data['success']) {
            areas = (response.data['data'] as List)
                .map((areaData) => AreaData.fromJson(areaData))
                .toList();
            isLoadingAreas = false;
            notifyListeners();
          } else {
            print('Error: ${response.data['message']}');
          }
        },
      );
    });
  }

  Future<Gethall> fetchHalls(
      int areaId, int townId, int typeEventId, int budgetId) async {
    final Map<String, dynamic> data = {
      'budget_id': budgetId,
      'area_id': areaId,
      'town_id': townId,
      'type_event_id': typeEventId,
    };

    // Ensure the token is updated and set the headers
    updateHeaders();
    _dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await _dio.post('/user/gethall', data: data);

      // Print the response data to debug
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return Gethall.fromJson(response.data);
        } else {
          print('Error: ${response.data['message']}');
          return Gethall(
            success: false,
            message: response.data['message'] ?? 'Error fetching halls',
            data: [],
            erros: null,
            status: response.data['status'] ?? 0,
          );
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return Gethall(
          success: false,
          message: 'Error fetching halls',
          data: [],
          erros: null,
          status: response.statusCode ?? 0,
        );
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return Gethall(
        success: false,
        message: 'DioException: ${e.message}',
        data: [],
        erros: e,
        status: 0,
      );
    } catch (e) {
      print('Error: $e');
      return Gethall(
        success: false,
        message: 'Error: $e',
        data: [],
        erros: e,
        status: 0,
      );
    }
  }

  Future<void> fetchBudgets(int typeEventId, int townId, int areaId) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      budgets.clear();
      isLoadingBudgets = true;
      notifyListeners();
      updateHeaders();
      await _retry(
        () async {
          final response = await _dio.post(
            '/user/getbudget',
            data: {
              'type_event_id': typeEventId,
              'town_id': townId,
              'area_id': areaId
            },
          );
          if (response.data['success']) {
            Budget1 budget1 = Budget1.fromJson(response.data);
            if (budget1.data != null) {
              budgets.addAll(budget1.data!);
            }
          } else {
            print('Error: ${response.data['message']}');
          }
          isLoadingBudgets = false;
          notifyListeners();
        },
      );
    });
  }

  Future<void> fetchEventTypes() async {
    isLoadingEventTypes = true;
    notifyListeners();
    updateHeaders();
    try {
      final response = await _dio.get('/user/type_event');
      if (response.data['success']) {
        eventTypes = (response.data['data'] as List)
            .map((eventData) => HomeData.fromJson(eventData))
            .toList();
      } else {
        print('Error: ${response.data['message']}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
    isLoadingEventTypes = false;
    notifyListeners();
  }

  Future<void> fetchAvailableMonths(int placeId) async {
    isLoadingMonths = true;
    notifyListeners();
    updateHeaders();
    try {
      final response = await _dio.post(
        '/user/getmonth',
        data: {'place_id': placeId},
      );
      if (response.data['success']) {
        availableMonths = List<String>.from(response.data['month']);
      } else {
        print('Error: ${response.data['message']}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
    isLoadingMonths = false;
    notifyListeners();
  }

  Future<void> fetchDates({required int placeId, required String month}) async {
    updateHeaders();
    try {
      final response = await _dio.post(
        '/user/dateOnly',
        data: {'place_id': placeId, 'month': month},
      );
      if (response.data['success']) {
        dates = (response.data['data'] as List)
            .map((dateData) => DateData.fromJson(dateData))
            .toList();
        notifyListeners();
      } else {
        print('Error: ${response.data['message']}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchMusic(int placeId) async {
    isLoadingMusic = true;
    notifyListeners();
    updateHeaders();
    try {
      final response = await _dio.post(
        '/user/getMusic',
        data: {'place_id': placeId},
      );

      if (response.statusCode == 200) {
        typemusic = (response.data['typemusic'] as List)
            .map((data) => Typemusic.fromJson(data))
            .toList();
        sing = (response.data['sing'] as List)
            .map((data) => Sing.fromJson(data))
            .toList();
        more = (response.data['more'] as List)
            .map((data) => More.fromJson(data))
            .toList();
        isLoadingMusic = false;
        notifyListeners();
      } else {
        print('Error: ${response.data['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchFoodOptions(int placeId) async {
    isLoadingFood = true;
    notifyListeners();
    updateHeaders();
    try {
      final response = await _dio.post(
        '/user/getfood',
        data: {'place_id': placeId},
      );

      final data = FoodModel.fromJson(response.data);

      mainMeals = data.mainMeal!;
      sweateTypes = data.sweateType!;
      mainCakes = data.mainCake!;
    } catch (e) {
      print(e);
    } finally {
      isLoadingFood = false;
      notifyListeners();
    }
  }

  Future<void> fetchDecorationOptions(int placeId) async {
    isLoadingDecoration = true;
    notifyListeners();
    updateHeaders();
    try {
      final response = await _dio.post(
        '/user/getdecore',
        data: {'place_id': placeId},
      );

      if (response.statusCode == 200) {
        final data = DecorationModel.fromJson(response.data);
        chairsNumber = data.chairsNumber ?? [];
        tableesNumber = data.tableesNumber ?? [];
        lighting = data.lighting ?? [];
        theme = data.theme ?? [];
        themeColor = data.themeColor ?? [];
      }
    } catch (e) {
      print(e);
    }

    isLoadingDecoration = false;
    notifyListeners();
  }

  // Future<void> _retry(Future<void> Function() request,
  //     {int retries = 3}) async {
  //   const int baseDelaySeconds = 2; // Base delay in seconds
  //   const int maxDelaySeconds = 32; // Maximum delay in seconds

  //   for (int attempt = 0; attempt < retries; attempt++) {
  //     try {
  //       await request();
  //       return; // Success, exit the function
  //     } on DioException catch (e) {
  //       if (e.response?.statusCode == 429) {
  //         // Calculate the delay, ensuring it doesn't exceed maxDelaySeconds
  //         final delaySeconds =
  //             (baseDelaySeconds * (1 << attempt)).clamp(0, maxDelaySeconds);
  //         final delay = Duration(seconds: delaySeconds);
  //         await Future.delayed(delay);
  //       } else {
  //         print('DioException: ${e.message}');
  //         throw e; // Re-throw the exception for other status codes
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //       throw e; // Re-throw for non-DioExceptions
  //     }
  //   }
  // }
  Future<void> _retry(Future<void> Function() request,
      {int retries = 3}) async {
    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        await request();
        return;
      } on DioException catch (e) {
        if (e.response?.statusCode == 429) {
          final delay = Duration(seconds: 2 << attempt);
          await Future.delayed(delay);
        } else {
          print('DioException: ${e.message}');
          throw e;
        }
      } catch (e) {
        print('Error: $e');
        throw e;
      }
    }
  }

  Future<LogoutModel> logout() async {
    updateHeaders(); // Ensure headers are updated before making the request

    try {
      final response = await _dio.post('/user/user_logout');
      if (response.statusCode == 200) {
        return LogoutModel.fromJson(response.data);
      } else {
        throw Exception('Failed to logout');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return LogoutModel(
          success: false,
          message: 'Error logging out',
          data: false,
          erros: null,
          status: 0);
    } catch (e) {
      print('Error: $e');
      return LogoutModel(
          success: false,
          message: 'Error logging out',
          data: false,
          erros: null,
          status: 0);
    }
  }

  void clearToken() {
    CachHelper.setString(key: 'token', value: '');
    token = '';
    updateHeaders();
  }

  void setTypeEventId(int id) {
    typeEventId = id;
    notifyListeners();
  }

  void clearTypeEventId() {
    typeEventId = null;
    notifyListeners();
  }

  void setTownId(int id) {
    townId = id;
    notifyListeners();
  }

  void setAreaId(int id) {
    areaId = id;
    notifyListeners();
  }

  void clearTownId() {
    townId = null;
    notifyListeners();
  }

  void clearAreaId() {
    areaId = null;
    notifyListeners();
  }

  void clearAreas() {
    areas.clear();
    notifyListeners();
  }

  void setBudgetId(int id) {
    budgetId = id;
    notifyListeners();
  }

  void setPlaceId(int id) {
    placeId = id;
    notifyListeners();
  }

  void setSelectedEventType(String eventType) {
    selectedEventType = eventType;
    notifyListeners();
  }

  void setSelectedTownName(String townName) {
    selectedTownName = townName;
    notifyListeners();
  }

  void setSelectedAreaName(String areaName) {
    selectedAreaName = areaName;
    notifyListeners();
  }

  void setSelectedBudgetName(String budgetName) {
    selectedBudgetName = budgetName;
    notifyListeners();
  }

  void setSelectedHallName(String hallName) {
    selectedHallName = hallName;
    notifyListeners();
  }

  void setSelectedDateDetails({required String month, required String date}) {
    selectedMonth = month;
    selectedDate = date;
    notifyListeners();
  }

  void setSelectedMusicDetails({
    required String musicType,
    required int musicTypePrice,
    required String song,
    required String moreDetails,
  }) {
    selectedMusicType = musicType;
    selectedMusicTypePrice = musicTypePrice;
    selectedSong = song;
    selectedMoreDetails = moreDetails;
    notifyListeners();
  }

  void setSelectedFoodDetails({
    required String mainMeal,
    required int mainMealPrice,
    required String sweateType,
    required int sweateTypePrice,
    required String mainCake,
    required int mainCakePrice,
  }) {
    selectedMainMeal = mainMeal;
    selectedMainMealPrice = mainMealPrice;
    selectedSweateType = sweateType;
    selectedSweateTypePrice = sweateTypePrice;
    selectedMainCake = mainCake;
    selectedMainCakePrice = mainCakePrice;
    notifyListeners();
  }

  void setSelectedDecorationDetails({
    required String chairsNumber,
    required int chairsNumberPrice,
    required String tablesNumber,
    required int tablesNumberPrice,
    required String lighting,
    required String theme,
    required int themePrice,
    required String themeColor,
    required int themeColorPrice,
  }) {
    selectedChairsNumber = chairsNumber;
    selectedChairsNumberPrice = chairsNumberPrice;
    selectedTablesNumber = tablesNumber;
    selectedTablesNumberPrice = tablesNumberPrice;
    selectedLighting = lighting;
    selectedTheme = theme;
    selectedThemePrice = themePrice;
    selectedThemeColor = themeColor;
    selectedThemeColorPrice = themeColorPrice;
    notifyListeners();
  }

  void setHallPrice({
    required int HallPrice,
  }) {
    selectedHallNamePrice = HallPrice;
    notifyListeners();
  }
}





































// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:pro2/models/dateModel.dart';
// import 'package:pro2/models/decorationModel.dart';
// import 'package:pro2/models/foodModel.dart';
// import 'package:pro2/models/getHallModel.dart';
// import 'package:pro2/models/homePageModel.dart';
// import 'package:pro2/models/logoutModel.dart';
// import 'package:pro2/models/musicModel.dart';
// import 'package:pro2/services/cashHelper.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:dio/dio.dart';
// import 'dart:async';
// import 'package:pro2/models/provinceModel.dart'; // Import the model classes
// import 'package:pro2/models/areaModel.dart';
// import 'package:pro2/models/budgetModel.dart';
// import 'package:pro2/budgetPage.dart';
// import 'package:pro2/models/MonthModel.dart';
// import 'package:pro2/models/profileModel.dart';

// class ApiModel extends Model {
//   late Dio _dio;
//   String token = CachHelper.getString(key: "token") ?? '';

//   ApiModel() {
//     _dio = Dio(BaseOptions(
//       baseUrl: 'http://10.0.2.2:8000/api',
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     ));
//   }

//   void updateHeaders() {
//     token = CachHelper.getString(key: "token") ?? '';
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   void _updateHeaders() {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   CarouselController carouselController = CarouselController();
//   int carouselCurrentIndex = 0;
//   List<Data> towns = [];
//   List<AreaData> areas = [];
//   List<BudgetData> budgets = [];
//   List<HomeData> eventTypes = [];
//   List<String> availableMonths = [];
//   List<DateData> dates = [];
//   List<Typemusic> typemusic = [];
//   List<Sing> sing = [];
//   List<More> more = [];
//   List<MainMeal> mainMeals = [];
//   List<SweateType> sweateTypes = [];
//   List<MainCake> mainCakes = [];
//   List<ChairsNumber> chairsNumber = [];
//   List<TableesNumber> tableesNumber = [];
//   List<Lighting> lighting = [];
//   List<Theme> theme = [];
//   List<ThemeColor> themeColor = [];
//   ProfileData? profileData;
//   int? typeEventId;
//   int? townId;
//   int? areaId;
//   int? budgetId;
//   int? placeId;

//   bool isLoadingDecoration = false;
//   bool isLoadingFood = false;
//   bool isLoadingMusic = false;
//   bool isLoadingTowns = false;
//   bool isLoadingAreas = false;
//   bool isLoadingBudgets = false;
//   bool isLoadingHalls = false;
//   bool isLoadingEventTypes = false;
//   bool isLoadingMonths = false;
//   bool isLoadingProfile = false;

//   String? selectedEventType;
//   String? selectedTownName;
//   String? selectedAreaName;
//   String? selectedBudgetName;
//   String? selectedHallName;
//   String? selectedMusicDetails;
//   String? selectedFoodDetails;
//   String? selectedDecorationDetails;

//   String? selectedChairsNumber;
//   int? selectedChairsNumberPrice;
//   String? selectedTablesNumber;
//   int? selectedTablesNumberPrice;
//   String? selectedLighting;
//   String? selectedTheme;
//   int? selectedThemePrice;
//   String? selectedThemeColor;
//   int? selectedThemeColorPrice;

//   String? selectedMainMeal;
//   int? selectedMainMealPrice;
//   String? selectedSweateType;
//   int? selectedSweateTypePrice;
//   String? selectedMainCake;
//   int? selectedMainCakePrice;

//   String? selectedMusicType;
//   int? selectedMusicTypePrice;
//   String? selectedSong;
//   String? selectedMoreDetails;

//   String? selectedMonth;
//   String? selectedDate;

//   Timer? _debounce;

//   Future<void> fetchProfile() async {
//     isLoadingProfile = true;
//     notifyListeners();

//     updateHeaders();
//     try {
//       final response = await _dio.get('/user/user_profile');
//       if (response.data['success']) {
//         profileData = ProfileData.fromJson(response.data['data']);
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isLoadingProfile = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchTowns(int typeEventId) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       towns.clear(); // Clear towns before fetching new data
//       isLoadingTowns = true;
//       notifyListeners();
//       updateHeaders();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '/user/gettown',
//             data: {'type_event_id': typeEventId},
//           );
//           if (response.data['success']) {
//             towns = (response.data['data'] as List)
//                 .map((townData) => Data.fromJson(townData))
//                 .toList();
//             isLoadingTowns = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<void> fetchAreas(int typeEventId, int townId) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       areas.clear(); // Clear areas before fetching new data
//       isLoadingAreas = true;
//       notifyListeners();
//       updateHeaders();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '/user/getarea',
//             data: {'type_event_id': typeEventId, 'town_id': townId},
//           );
//           if (response.data['success']) {
//             areas = (response.data['data'] as List)
//                 .map((areaData) => AreaData.fromJson(areaData))
//                 .toList();
//             isLoadingAreas = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

// //   Future<Gethall> fetchHalls(int areaId, int townId, int typeEventId,
// //       int budgetId, String token) async {
// //     final dio = Dio();

// //     // Prepare the request body with your data
// //     final Map<String, dynamic> data = {
// //       'budget_id': budgetId,
// //       'area_id': areaId,
// //       'town_id': townId,
// //       'type_event_id': typeEventId,
// //     };

// //     // Add a header for the bearer token
// //     dio.options.headers = {'Authorization': 'Bearer $token'};

// //     try {
// //       final response = await dio.post('$baseUrl/user/gethall', data: data);
// //       if (response.statusCode == 200) {
// //         return Gethall.fromJson(response.data); // Parse the response data
// //       } else {
// //         print('Error: ${response.data['message']}');
// //         return Gethall(
// //             success: false,
// //             message: 'Error fetching halls',
// //             data: [],
// //             erros: null,
// //             status: 0);
// //       }
// //     } on DioException catch (e) {
// //       // Handle errors here
// //       print('DioException: ${e.message}');
// //       return Gethall(
// //           success: false,
// //           message: 'Error fetching halls',
// //           data: [],
// //           erros: e,
// //           status: 0);
// //     } catch (e) {
// //       print('Error: $e');
// //       return Gethall(
// //           success: false,
// //           message: 'Error fetching halls',
// //           data: [],
// //           erros: e,
// //           status: 0);
// //     }
// //   }

//   // Future<Gethall> fetchHalls(
//   //     int areaId, int townId, int typeEventId, int budgetId) async {
//   //   final dio = Dio();
//   //   final Map<String, dynamic> data = {
//   //     'budget_id': budgetId,
//   //     'area_id': areaId,
//   //     'town_id': townId,
//   //     'type_event_id': typeEventId,
//   //   };

//   //   updateHeaders();
//   //   dio.options.headers = {'Authorization': 'Bearer $token'};

//   //   try {
//   //     final response = await dio.post('/user/gethall', data: data);
//   //     if (response.statusCode == 200) {
//   //       return Gethall.fromJson(response.data);
//   //     } else {
//   //       print('Error: ${response.data['message']}');
//   //       return Gethall(
//   //           success: false,
//   //           message: 'Error fetching halls',
//   //           data: [],
//   //           erros: null,
//   //           status: 0);
//   //     }
//   //   } on DioException catch (e) {
//   //     print('DioException: ${e.message}');
//   //     return Gethall(
//   //         success: false,
//   //         message: 'Error fetching halls',
//   //         data: [],
//   //         erros: e,
//   //         status: 0);
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     return Gethall(
//   //         success: false,
//   //         message: 'Error fetching halls',
//   //         data: [],
//   //         erros: e,
//   //         status: 0);
//   //   }
//   // }

//   Future<Gethall> fetchHalls(
//       int areaId, int townId, int typeEventId, int budgetId) async {
//     final Map<String, dynamic> data = {
//       'budget_id': budgetId,
//       'area_id': areaId,
//       'town_id': townId,
//       'type_event_id': typeEventId,
//     };

//     // Ensure the token is updated and set the headers
//     updateHeaders();
//     _dio.options.headers['Authorization'] = 'Bearer $token';

//     try {
//       final response = await _dio.post('/user/gethall', data: data);

//       // Print the response data to debug
//       print('Response data: ${response.data}');

//       if (response.statusCode == 200) {
//         if (response.data['success'] == true) {
//           return Gethall.fromJson(response.data);
//         } else {
//           print('Error: ${response.data['message']}');
//           return Gethall(
//             success: false,
//             message: response.data['message'] ?? 'Error fetching halls',
//             data: [],
//             erros: null,
//             status: response.data['status'] ?? 0,
//           );
//         }
//       } else {
//         print('Unexpected status code: ${response.statusCode}');
//         return Gethall(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: null,
//           status: response.statusCode ?? 0,
//         );
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//       return Gethall(
//         success: false,
//         message: 'DioException: ${e.message}',
//         data: [],
//         erros: e,
//         status: 0,
//       );
//     } catch (e) {
//       print('Error: $e');
//       return Gethall(
//         success: false,
//         message: 'Error: $e',
//         data: [],
//         erros: e,
//         status: 0,
//       );
//     }
//   }

//   Future<void> fetchBudgets(int typeEventId, int townId, int areaId) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       budgets.clear();
//       isLoadingBudgets = true;
//       notifyListeners();
//       updateHeaders();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '/user/getbudget',
//             data: {
//               'type_event_id': typeEventId,
//               'town_id': townId,
//               'area_id': areaId
//             },
//           );
//           if (response.data['success']) {
//             Budget1 budget1 = Budget1.fromJson(response.data);
//             if (budget1.data != null) {
//               budgets.addAll(budget1.data!);
//             }
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//           isLoadingBudgets = false;
//           notifyListeners();
//         },
//       );
//     });
//   }

//   Future<void> fetchEventTypes() async {
//     isLoadingEventTypes = true;
//     notifyListeners();
//     updateHeaders();
//     try {
//       final response = await _dio.get('/user/type_event');
//       if (response.data['success']) {
//         eventTypes = (response.data['data'] as List)
//             .map((eventData) => HomeData.fromJson(eventData))
//             .toList();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//     isLoadingEventTypes = false;
//     notifyListeners();
//   }

//   Future<void> fetchAvailableMonths(int placeId) async {
//     isLoadingMonths = true;
//     notifyListeners();
//     updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getmonth',
//         data: {'place_id': placeId},
//       );
//       if (response.data['success']) {
//         availableMonths = List<String>.from(response.data['month']);
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//     isLoadingMonths = false;
//     notifyListeners();
//   }

//   Future<void> fetchDates({required int placeId, required String month}) async {
//     updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/dateOnly',
//         data: {'place_id': placeId, 'month': month},
//       );
//       if (response.data['success']) {
//         dates = (response.data['data'] as List)
//             .map((dateData) => DateData.fromJson(dateData))
//             .toList();
//         notifyListeners();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> fetchMusic(int placeId) async {
//     isLoadingMusic = true;
//     notifyListeners();
//     updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getMusic',
//         data: {'place_id': placeId},
//       );

//       if (response.statusCode == 200) {
//         typemusic = (response.data['typemusic'] as List)
//             .map((data) => Typemusic.fromJson(data))
//             .toList();
//         sing = (response.data['sing'] as List)
//             .map((data) => Sing.fromJson(data))
//             .toList();
//         more = (response.data['more'] as List)
//             .map((data) => More.fromJson(data))
//             .toList();
//         isLoadingMusic = false;
//         notifyListeners();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> fetchFoodOptions(int placeId) async {
//     isLoadingFood = true;
//     notifyListeners();
//     updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getfood',
//         data: {'place_id': placeId},
//       );

//       final data = FoodModel.fromJson(response.data);

//       mainMeals = data.mainMeal!;
//       sweateTypes = data.sweateType!;
//       mainCakes = data.mainCake!;
//     } catch (e) {
//       print(e);
//     } finally {
//       isLoadingFood = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchDecorationOptions(int placeId) async {
//     isLoadingDecoration = true;
//     notifyListeners();
//     updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getdecore',
//         data: {'place_id': placeId},
//       );

//       if (response.statusCode == 200) {
//         final data = DecorationModel.fromJson(response.data);
//         chairsNumber = data.chairsNumber ?? [];
//         tableesNumber = data.tableesNumber ?? [];
//         lighting = data.lighting ?? [];
//         theme = data.theme ?? [];
//         themeColor = data.themeColor ?? [];
//       }
//     } catch (e) {
//       print(e);
//     }

//     isLoadingDecoration = false;
//     notifyListeners();
//   }

//   Future<void> _retry(Future<void> Function() request,
//       {int retries = 3}) async {
//     for (int attempt = 0; attempt < retries; attempt++) {
//       try {
//         await request();
//         return;
//       } on DioException catch (e) {
//         if (e.response?.statusCode == 429) {
//           final delay = Duration(seconds: 2 << attempt);
//           await Future.delayed(delay);
//         } else {
//           print('DioException: ${e.message}');
//           throw e;
//         }
//       } catch (e) {
//         print('Error: $e');
//         throw e;
//       }
//     }
//   }

//   // Future<LogoutModel> logout() async {
//   //   try {
//   //     final response = await _dio.post('/user/logout');
//   //     if (response.statusCode == 200) {
//   //       return LogoutModel.fromJson(response.data);
//   //     } else {
//   //       throw Exception('Failed to logout');
//   //     }
//   //   } on DioException catch (e) {
//   //     print('DioException: ${e.message}');
//   //     return LogoutModel(
//   //         success: false,
//   //         message: 'Error logging out',
//   //         data: false,
//   //         erros: null,
//   //         status: 0);
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     return LogoutModel(
//   //         success: false,
//   //         message: 'Error logging out',
//   //         data: false,
//   //         erros: null,
//   //         status: 0);
//   //   }
//   // }
//   Future<LogoutModel> logout() async {
//     _updateHeaders(); // Ensure headers are updated before making the request

//     try {
//       final response = await _dio.post('/user/logout');
//       if (response.statusCode == 200) {
//         return LogoutModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to logout');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//       return LogoutModel(
//           success: false,
//           message: 'Error logging out',
//           data: false,
//           erros: null,
//           status: 0);
//     } catch (e) {
//       print('Error: $e');
//       return LogoutModel(
//           success: false,
//           message: 'Error logging out',
//           data: false,
//           erros: null,
//           status: 0);
//     }
//   }

//   void clearToken() {
//     CachHelper.setString(key: 'token', value: '');
//     token = '';
//     _updateHeaders();
//   }

//   void setTypeEventId(int id) {
//     typeEventId = id;
//     notifyListeners();
//   }

//   void clearTypeEventId() {
//     typeEventId = null;
//     notifyListeners();
//   }

//   void setTownId(int id) {
//     townId = id;
//     notifyListeners();
//   }

//   void setAreaId(int id) {
//     areaId = id;
//     notifyListeners();
//   }

//   void clearTownId() {
//     townId = null;
//     notifyListeners();
//   }

//   void clearAreaId() {
//     areaId = null;
//     notifyListeners();
//   }

//   void clearAreas() {
//     areas.clear();
//     notifyListeners();
//   }

//   void setBudgetId(int id) {
//     budgetId = id;
//     notifyListeners();
//   }

//   void setPlaceId(int id) {
//     placeId = id;
//     notifyListeners();
//   }

//   void setSelectedEventType(String eventType) {
//     selectedEventType = eventType;
//     notifyListeners();
//   }

//   void setSelectedTownName(String townName) {
//     selectedTownName = townName;
//     notifyListeners();
//   }

//   void setSelectedAreaName(String areaName) {
//     selectedAreaName = areaName;
//     notifyListeners();
//   }

//   void setSelectedBudgetName(String budgetName) {
//     selectedBudgetName = budgetName;
//     notifyListeners();
//   }

//   void setSelectedHallName(String hallName) {
//     selectedHallName = hallName;
//     notifyListeners();
//   }

//   void setSelectedDateDetails({required String month, required String date}) {
//     selectedMonth = month;
//     selectedDate = date;
//     notifyListeners();
//   }

//   void setSelectedMusicDetails({
//     required String musicType,
//     required int musicTypePrice,
//     required String song,
//     required String moreDetails,
//   }) {
//     selectedMusicType = musicType;
//     selectedMusicTypePrice = musicTypePrice;
//     selectedSong = song;
//     selectedMoreDetails = moreDetails;
//     notifyListeners();
//   }

//   void setSelectedFoodDetails({
//     required String mainMeal,
//     required int mainMealPrice,
//     required String sweateType,
//     required int sweateTypePrice,
//     required String mainCake,
//     required int mainCakePrice,
//   }) {
//     selectedMainMeal = mainMeal;
//     selectedMainMealPrice = mainMealPrice;
//     selectedSweateType = sweateType;
//     selectedSweateTypePrice = sweateTypePrice;
//     selectedMainCake = mainCake;
//     selectedMainCakePrice = mainCakePrice;
//     notifyListeners();
//   }

//   void setSelectedDecorationDetails({
//     required String chairsNumber,
//     required int chairsNumberPrice,
//     required String tablesNumber,
//     required int tablesNumberPrice,
//     required String lighting,
//     required String theme,
//     required int themePrice,
//     required String themeColor,
//     required int themeColorPrice,
//   }) {
//     selectedChairsNumber = chairsNumber;
//     selectedChairsNumberPrice = chairsNumberPrice;
//     selectedTablesNumber = tablesNumber;
//     selectedTablesNumberPrice = tablesNumberPrice;
//     selectedLighting = lighting;
//     selectedTheme = theme;
//     selectedThemePrice = themePrice;
//     selectedThemeColor = themeColor;
//     selectedThemeColorPrice = themeColorPrice;
//     notifyListeners();
//   }
// }












































// class ApiModel extends Model {
//   late Dio _dio;
//   String token = CachHelper.getString(key: "token") ?? '';

//   ApiModel() {
//     _dio = Dio(BaseOptions(
//       baseUrl: 'http://10.0.2.2:8000/api',
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     ));
//   }

//   void _updateHeaders() {
//     token = CachHelper.getString(key: "token") ?? '';
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   CarouselController carouselController = CarouselController();
//   int carouselCurrentIndex = 0;
//   List<Data> towns = [];
//   List<AreaData> areas = [];
//   List<BudgetData> budgets = [];
//   List<HomeData> eventTypes = [];
//   List<String> availableMonths = [];
//   List<DateData> dates = [];
//   List<Typemusic> typemusic = [];
//   List<Sing> sing = [];
//   List<More> more = [];
//   List<MainMeal> mainMeals = [];
//   List<SweateType> sweateTypes = [];
//   List<MainCake> mainCakes = [];
//   List<ChairsNumber> chairsNumber = [];
//   List<TableesNumber> tableesNumber = [];
//   List<Lighting> lighting = [];
//   List<Theme> theme = [];
//   List<ThemeColor> themeColor = [];
//   ProfileData? profileData;
//   int? typeEventId;
//   int? townId;
//   int? areaId;
//   int? budgetId;
//   int? placeId;

//   bool isLoadingDecoration = false;
//   bool isLoadingFood = false;
//   bool isLoadingMusic = false;
//   bool isLoadingTowns = false;
//   bool isLoadingAreas = false;
//   bool isLoadingBudgets = false;
//   bool isLoadingHalls = false;
//   bool isLoadingEventTypes = false;
//   bool isLoadingMonths = false;
//   bool isLoadingProfile = false;

//   String? selectedEventType;
//   String? selectedTownName;
//   String? selectedAreaName;
//   String? selectedBudgetName;
//   String? selectedHallName;
//   String? selectedMusicDetails;
//   String? selectedFoodDetails;
//   String? selectedDecorationDetails;

//   String? selectedChairsNumber;
//   int? selectedChairsNumberPrice;
//   String? selectedTablesNumber;
//   int? selectedTablesNumberPrice;
//   String? selectedLighting;
//   String? selectedTheme;
//   int? selectedThemePrice;
//   String? selectedThemeColor;
//   int? selectedThemeColorPrice;

//   String? selectedMainMeal;
//   int? selectedMainMealPrice;
//   String? selectedSweateType;
//   int? selectedSweateTypePrice;
//   String? selectedMainCake;
//   int? selectedMainCakePrice;

//   String? selectedMusicType;
//   int? selectedMusicTypePrice;
//   String? selectedSong;
//   String? selectedMoreDetails;

//   String? selectedMonth;
//   String? selectedDate;

//   Timer? _debounce;

//   Future<void> fetchProfile() async {
//     isLoadingProfile = true;
//     notifyListeners();

//     _updateHeaders();
//     try {
//       final response = await _dio.get('/user/user_profile');
//       if (response.data['success']) {
//         profileData = ProfileData.fromJson(response.data['data']);
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isLoadingProfile = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchTowns(int typeEventId) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       towns.clear(); // Clear towns before fetching new data
//       isLoadingTowns = true;
//       notifyListeners();
//       _updateHeaders();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '/user/gettown',
//             data: {'type_event_id': typeEventId},
//           );
//           if (response.data['success']) {
//             towns = (response.data['data'] as List)
//                 .map((townData) => Data.fromJson(townData))
//                 .toList();
//             isLoadingTowns = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<void> fetchAreas(int typeEventId, int townId) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       areas.clear(); // Clear areas before fetching new data
//       isLoadingAreas = true;
//       notifyListeners();
//       _updateHeaders();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '/user/getarea',
//             data: {'type_event_id': typeEventId, 'town_id': townId},
//           );
//           if (response.data['success']) {
//             areas = (response.data['data'] as List)
//                 .map((areaData) => AreaData.fromJson(areaData))
//                 .toList();
//             isLoadingAreas = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<Gethall> fetchHalls(int areaId, int townId, int typeEventId, int budgetId) async {
//     final dio = Dio();
//     final Map<String, dynamic> data = {
//       'budget_id': budgetId,
//       'area_id': areaId,
//       'town_id': townId,
//       'type_event_id': typeEventId,
//     };

//     _updateHeaders();
//     dio.options.headers = {'Authorization': 'Bearer $token'};

//     try {
//       final response = await dio.post('/user/gethall', data: data);
//       if (response.statusCode == 200) {
//         return Gethall.fromJson(response.data);
//       } else {
//         print('Error: ${response.data['message']}');
//         return Gethall(success: false, message: 'Error fetching halls', data: [], erros: null, status: 0);
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//       return Gethall(success: false, message: 'Error fetching halls', data: [], erros: e, status: 0);
//     } catch (e) {
//       print('Error: $e');
//       return Gethall(success: false, message: 'Error fetching halls', data: [], erros: e, status: 0);
//     }
//   }

//   Future<void> fetchBudgets(int typeEventId, int townId, int areaId) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       budgets.clear();
//       isLoadingBudgets = true;
//       notifyListeners();
//       _updateHeaders();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '/user/getbudget',
//             data: {'type_event_id': typeEventId, 'town_id': townId, 'area_id': areaId},
//           );
//           if (response.data['success']) {
//             Budget1 budget1 = Budget1.fromJson(response.data);
//             if (budget1.data != null) {
//               budgets.addAll(budget1.data!);
//             }
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//           isLoadingBudgets = false;
//           notifyListeners();
//         },
//       );
//     });
//   }

//   Future<void> fetchEventTypes() async {
//     isLoadingEventTypes = true;
//     notifyListeners();
//     _updateHeaders();
//     try {
//       final response = await _dio.get('/user/type_event');
//       if (response.data['success']) {
//         eventTypes = (response.data['data'] as List)
//             .map((eventData) => HomeData.fromJson(eventData))
//             .toList();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//     isLoadingEventTypes = false;
//     notifyListeners();
//   }

//   Future<void> fetchAvailableMonths(int placeId) async {
//     isLoadingMonths = true;
//     notifyListeners();
//     _updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getmonth',
//         data: {'place_id': placeId},
//       );
//       if (response.data['success']) {
//         availableMonths = List<String>.from(response.data['month']);
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//     isLoadingMonths = false;
//     notifyListeners();
//   }

//   Future<void> fetchDates({required int placeId, required String month}) async {
//     _updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/dateOnly',
//         data: {'place_id': placeId, 'month': month},
//       );
//       if (response.data['success']) {
//         dates = (response.data['data'] as List)
//             .map((dateData) => DateData.fromJson(dateData))
//             .toList();
//         notifyListeners();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> fetchMusic(int placeId) async {
//     isLoadingMusic = true;
//     notifyListeners();
//     _updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getMusic',
//         data: {'place_id': placeId},
//       );

//       if (response.statusCode == 200) {
//         typemusic = (response.data['typemusic'] as List)
//             .map((data) => Typemusic.fromJson(data))
//             .toList();
//         sing = (response.data['sing'] as List)
//             .map((data) => Sing.fromJson(data))
//             .toList();
//         more = (response.data['more'] as List)
//             .map((data) => More.fromJson(data))
//             .toList();
//         isLoadingMusic = false;
//         notifyListeners();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> fetchFoodOptions(int placeId) async {
//     isLoadingFood = true;
//     notifyListeners();
//     _updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getfood',
//         data: {'place_id': placeId},
//       );

//       final data = FoodModel.fromJson(response.data);

//       mainMeals = data.mainMeal!;
//       sweateTypes = data.sweateType!;
//       mainCakes = data.mainCake!;
//     } catch (e) {
//       print(e);
//     } finally {
//       isLoadingFood = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchDecorationOptions(int placeId) async {
//     isLoadingDecoration = true;
//     notifyListeners();
//     _updateHeaders();
//     try {
//       final response = await _dio.post(
//         '/user/getdecore',
//         data: {'place_id': placeId},
//       );

//       if (response.statusCode == 200) {
//         final data = DecorationModel.fromJson(response.data);
//         chairsNumber = data.chairsNumber ?? [];
//         tableesNumber = data.tableesNumber ?? [];
//         lighting = data.lighting ?? [];
//         theme = data.theme ?? [];
//         themeColor = data.themeColor ?? [];
//       }
//     } catch (e) {
//       print(e);
//     }

//     isLoadingDecoration = false;
//     notifyListeners();
//   }

//   Future<void> _retry(Future<void> Function() request, {int retries = 3}) async {
//     for (int attempt = 0; attempt < retries; attempt++) {
//       try {
//         await request();
//         return;
//       } on DioException catch (e) {
//         if (e.response?.statusCode == 429) {
//           final delay = Duration(seconds: 2 << attempt);
//           await Future.delayed(delay);
//         } else {
//           print('DioException: ${e.message}');
//           throw e;
//         }
//       } catch (e) {
//         print('Error: $e');
//         throw e;
//       }
//     }
//   }

//   void setTypeEventId(int id) {
//     typeEventId = id;
//     notifyListeners();
//   }

//   void clearTypeEventId() {
//     typeEventId = null;
//     notifyListeners();
//   }

//   void setTownId(int id) {
//     townId = id;
//     notifyListeners();
//   }

//   void setAreaId(int id) {
//     areaId = id;
//     notifyListeners();
//   }

//   void clearTownId() {
//     townId = null;
//     notifyListeners();
//   }

//   void clearAreaId() {
//     areaId = null;
//     notifyListeners();
//   }

//   void clearAreas() {
//     areas.clear();
//     notifyListeners();
//   }

//   void setBudgetId(int id) {
//     budgetId = id;
//     notifyListeners();
//   }

//   void setPlaceId(int id) {
//     placeId = id;
//     notifyListeners();
//   }

//   void setSelectedEventType(String eventType) {
//     selectedEventType = eventType;
//     notifyListeners();
//   }

//   void setSelectedTownName(String townName) {
//     selectedTownName = townName;
//     notifyListeners();
//   }

//   void setSelectedAreaName(String areaName) {
//     selectedAreaName = areaName;
//     notifyListeners();
//   }

//   void setSelectedBudgetName(String budgetName) {
//     selectedBudgetName = budgetName;
//     notifyListeners();
//   }

//   void setSelectedHallName(String hallName) {
//     selectedHallName = hallName;
//     notifyListeners();
//   }

//   void setSelectedDateDetails({required String month, required String date}) {
//     selectedMonth = month;
//     selectedDate = date;
//     notifyListeners();
//   }

//   void setSelectedMusicDetails({
//     required String musicType,
//     required int musicTypePrice,
//     required String song,
//     required String moreDetails,
//   }) {
//     selectedMusicType = musicType;
//     selectedMusicTypePrice = musicTypePrice;
//     selectedSong = song;
//     selectedMoreDetails = moreDetails;
//     notifyListeners();
//   }

//   void setSelectedFoodDetails({
//     required String mainMeal,
//     required int mainMealPrice,
//     required String sweateType,
//     required int sweateTypePrice,
//     required String mainCake,
//     required int mainCakePrice,
//   }) {
//     selectedMainMeal = mainMeal;
//     selectedMainMealPrice = mainMealPrice;
//     selectedSweateType = sweateType;
//     selectedSweateTypePrice = sweateTypePrice;
//     selectedMainCake = mainCake;
//     selectedMainCakePrice = mainCakePrice;
//     notifyListeners();
//   }

//   void setSelectedDecorationDetails({
//     required String chairsNumber,
//     required int chairsNumberPrice,
//     required String tablesNumber,
//     required int tablesNumberPrice,
//     required String lighting,
//     required String theme,
//     required int themePrice,
//     required String themeColor,
//     required int themeColorPrice,
//   }) {
//     selectedChairsNumber = chairsNumber;
//     selectedChairsNumberPrice = chairsNumberPrice;
//     selectedTablesNumber = tablesNumber;
//     selectedTablesNumberPrice = tablesNumberPrice;
//     selectedLighting = lighting;
//     selectedTheme = theme;
//     selectedThemePrice = themePrice;
//     selectedThemeColor = themeColor;
//     selectedThemeColorPrice = themeColorPrice;
//     notifyListeners();
//   }
// }




































// class ApiModel extends Model {
//   final Dio _dio = Dio();
//   CarouselController carouselController = CarouselController();
//   int carouselCurrentIndex = 0;
//   List<Data> towns = [];
//   List<AreaData> areas = [];
//   List<BudgetData> budgets = [];
//   List<HomeData> eventTypes = [];
//   List<Data> dates = [];
//   int? typeEventId;
//   int? townId;
//   int? areaId;
//   int? budgetId;
//   bool isLoadingTowns = false;
//   bool isLoadingAreas = false;
//   bool isLoadingBudgets = false;
//   bool isLoadingHalls = false;
//   bool isLoadingEventTypes = false;
//   final String baseUrl = 'http://10.0.2.2:8000/api';
//   final String token =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiOThlNjJkMjhjMzgxNDU2MTcyZDA5Njg5YzQ3YmQ3NGEyZjBmYzIwZmQ4YzRiZDIxNjU5YTI2MWUzZWY5YjdhYjQ1Zjk5NzYyZWZiOGI4MzMiLCJpYXQiOjE3MTk4NDQwOTguMDAyMzcyLCJuYmYiOjE3MTk4NDQwOTguMDAyMzczLCJleHAiOjE3NTEzODAwOTcuOTk2NTU1LCJzdWIiOiIxIiwic2NvcGVzIjpbInVzZXIiXX0.TP9bNzu-TN2QrW56AZmByRFcIjG757sZpsFjaxJmb-xjMmoE1YGOISUuW0LpvfzFUY0iR1ssFRErnIRiBilM1Uk_jbnKdC3VbXyGUyEtT8IOB-FEmnMpx1kBcj0S0mqqaZcdMvDFEfnFiJaKtr-3yHXX0trSlUYqsjYm1IouMmMrHJ5EKlMV5Pa5q3jYYFJMsOQ9NqVw182mvHPuuZckPmAPZ859ic6nxbUhWbJT7mbAOjE_p_p_lGenDkG1WBZTyyf7UYzcWdo9h2LB_uZnTMFylLNm2f8klp8lhJ1Wd5ObIKghL1XIxjAjc4_yJGZZtBKO1twClJvtD9cpCsTD8sGPK86pHS_niQlaRtPCW9bu4tm3P28oI9RzFg5Qc1hLzbIeX8kl4HmnpHER0rJ1Sqqeo_bGGhdSjrAJUJs1MtVZdPGAGNjrmxVqKojzQHWYgLMzN6lpqB98tIFgSPZ1cK8Z05VwSGfm3Ndj5R3dN2WxF6_uDKjlfCzyIlLbzr_AtyqaCBrQ3l2ufT8gnA-Eft_QMhl0lJvfIVluLiwrxFZhoJ2JRizFtICexO5Ic4ZnKSR8yhQgfA6a97La7CyLlhAfhAPaxQCOy1Lbk0wR5XOB168lPhlpHY3Z3mUYnv5PztE5vKVI4Gvlhk11owQLvB8IVf9qpVsb7dQWS6LDfO8'; // Replace with your actual token

//   Timer? _debounce;

//   Future<void> fetchTowns(int typeEventId, String token) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       towns.clear(); // Clear towns before fetching new data
//       isLoadingTowns = true;
//       notifyListeners();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '$baseUrl/user/gettown',
//             data: {'type_event_id': typeEventId},
//             options: Options(headers: {'Authorization': 'Bearer $token'}),
//           );
//           if (response.data['success']) {
//             towns = (response.data['data'] as List)
//                 .map((townData) => Data.fromJson(townData))
//                 .toList();
//             isLoadingTowns = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<void> fetchAreas(int typeEventId, int townId, String token) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       areas.clear(); // Clear areas before fetching new data
//       isLoadingAreas = true;
//       notifyListeners();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '$baseUrl/user/getarea',
//             data: {'type_event_id': typeEventId, 'town_id': townId},
//             options: Options(headers: {'Authorization': 'Bearer $token'}),
//           );
//           if (response.data['success']) {
//             areas = (response.data['data'] as List)
//                 .map((areaData) => AreaData.fromJson(areaData))
//                 .toList();
//             isLoadingAreas = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<Gethall> fetchHalls(int areaId, int townId, int typeEventId,
//       int budgetId, String token) async {
//     final dio = Dio();

//     // Prepare the request body with your data
//     final Map<String, dynamic> data = {
//       'budget_id': budgetId,
//       'area_id': areaId,
//       'town_id': townId,
//       'type_event_id': typeEventId,
//     };

//     // Add a header for the bearer token
//     dio.options.headers = {'Authorization': 'Bearer $token'};

//     try {
//       final response = await dio.post('$baseUrl/user/gethall', data: data);
//       if (response.statusCode == 200) {
//         return Gethall.fromJson(response.data); // Parse the response data
//       } else {
//         print('Error: ${response.data['message']}');
//         return Gethall(
//             success: false,
//             message: 'Error fetching halls',
//             data: [],
//             erros: null,
//             status: 0);
//       }
//     } on DioException catch (e) {
//       // Handle errors here
//       print('DioException: ${e.message}');
//       return Gethall(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: e,
//           status: 0);
//     } catch (e) {
//       print('Error: $e');
//       return Gethall(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: e,
//           status: 0);
//     }
//   }

//   Future<void> fetchBudgets(
//       int typeEventId, int townId, int areaId, String token) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       budgets.clear();
//       isLoadingBudgets = true;
//       notifyListeners();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '$baseUrl/user/getbudget',
//             data: {
//               'type_event_id': typeEventId,
//               'town_id': townId,
//               'area_id': areaId
//             },
//             options: Options(headers: {'Authorization': 'Bearer $token'}),
//           );
//           if (response.data['success']) {
//             // Parse response data into Budget1 instance
//             Budget1 budget1 = Budget1.fromJson(response.data);
//             // Assign data to budgets list
//             if (budget1.data != null) {
//               budgets.addAll(budget1.data!);
//             }
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//           isLoadingBudgets = false;
//           notifyListeners();
//         },
//       );
//     });
//   }

//   Future<void> fetchEventTypes(String token) async {
//     isLoadingEventTypes = true;
//     notifyListeners();

//     try {
//       final response = await _dio.get(
//         'http://10.0.2.2:8000/api/user/type_event',
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );
//       if (response.data['success']) {
//         eventTypes = (response.data['data'] as List)
//             .map((eventData) => HomeData.fromJson(eventData))
//             .toList();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//     isLoadingEventTypes = false;
//     notifyListeners();
//   }

//   Future<void> fetchDates(
//       {required int placeId,
//       required String month,
//       required String token}) async {
//     try {
//       final response = await _dio.post(
//         'http://10.0.2.2:8000/api/user/getdates',
//         data: {'place_id': placeId, 'month': month},
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );
//       if (response.data['success']) {
//         dates = (response.data['data'] as List)
//             .map((dateData) => Data.fromJson(dateData))
//             .toList();
//         notifyListeners();
//       } else {
//         print('Error: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       print('DioException: ${e.message}');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> _retry(Future<void> Function() request,
//       {int retries = 3}) async {
//     for (int attempt = 0; attempt < retries; attempt++) {
//       try {
//         await request();
//         return;
//       } on DioException catch (e) {
//         if (e.response?.statusCode == 429) {
//           final delay = Duration(seconds: 2 << attempt); // Exponential backoff
//           await Future.delayed(delay);
//         } else {
//           print('DioException: ${e.message}');
//           throw e;
//         }
//       } catch (e) {
//         print('Error: $e');
//         throw e;
//       }
//     }
//   }

//   void setTypeEventId(int id) {
//     typeEventId = id;
//     notifyListeners();
//   }

//   void clearTypeEventId() {
//     typeEventId = null;
//     notifyListeners();
//   }

//   void setTownId(int id) {
//     townId = id;
//     notifyListeners();
//   }

//   void setAreaId(int id) {
//     areaId = id;
//     notifyListeners();
//   }

//   void clearTownId() {
//     townId = null;
//     notifyListeners();
//   }

//   void clearAreaId() {
//     areaId = null;
//     notifyListeners();
//   }

//   void clearAreas() {
//     areas.clear();
//     notifyListeners();
//   }

//   void setBudgetId(int id) {
//     budgetId = id;
//     notifyListeners();
//   }
// }

























// class ApiModel extends Model {
//   final Dio _dio = Dio();
//   List<Data> towns = [];
//   List<AreaData> areas = [];
//   List<Data2> budgets = [];
//   int? typeEventId;
//   int? townId;
//   int? areaId;
//   int? budgetId;
//   bool isLoadingTowns = false;
//   bool isLoadingAreas = false;
//   bool isLoadingBudgets = false;
//   final String baseUrl = 'http://10.0.2.2:8000/api';
//   final String token =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTcyZTM4YTRkZDVhNTZjMjlmYWFhYzg0ZGQ4M2Q3ODM2ZmVmY2VhMjBmNTQ1NTEzYTJlMTE5MzE2MDRlZGM1OTZlZDEwOGYwNWU3YWExZGIiLCJpYXQiOjE3MTk2NjUwNjQuNDAxMzY3LCJuYmYiOjE3MTk2NjUwNjQuNDAxMzcsImV4cCI6MTc1MTIwMTA2NC4zMTU2ODEsInN1YiI6IjIiLCJzY29wZXMiOlsidXNlciJdfQ.eZuL6YKi1SGVWr4PJ5B8B0mQJqJpJufDP2jQGCXC6SCXKkhDwGepZ60mrl_G8_mYUB8dcekZPoyeuBFzIhhXWwMDGLSWdqdB_KzZDPOc1hgvXluJvf2h0teG523AgvbMRuL_s6yH7q5yVfPAUyTQdlAXSE3ionHHhGwyOpC60JtEDg_LR5UV2Ea4zcwUH7-z1urZzhfdMeDdfNSmPAvHTkDKZq3pz5KNvRzgTqwQiCdlq__k1xAjXVCEiGiKsPJCFNAXoaDX0n_qjfeooi3-dU6GV3_Cs6hNb_8zM9OOoHhBLv7ba1ORLMxYpYC8nhSMtiYuK6SKA4oTYQgxCwl3h67s4vkPleDajhtJHFPiK_-XmfZxryO2gt6Pr_7zmUCdr5H8rxfzbDbNqSSDGWF5-CmjumfXNaBNYwDNqIDnyrxo6uaLM0c7igkqIj6UxQPGPdkgZQAzLYx5Pg9lERsIabRHI6saUzcBe-mcyausxN5RkCXX1X8EZwfeTOh8_lYDCDai7EHiW-kcf79F6E6KfIPo_vHMg8tCNEorTXWexRzMUctFoVZKp7On5NWxqrM0Unyz0NoyLpH6HZy8S83oRnWPo6mOEY8qz8V_KLP6eOX-5wkJwsYJz-SRN-cRKPY2t-5GSbfvhvzcxUFszGJ9-AEV3b4iw5I7M3kOFilORIQ'; // Replace with your actual token

//   Timer? _debounce;

//   Future<void> fetchTowns(int typeEventId, String token) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       towns.clear(); // Clear towns before fetching new data
//       isLoadingTowns = true;
//       notifyListeners();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '$baseUrl/user/gettown',
//             data: {'type_event_id': typeEventId},
//             options: Options(headers: {'Authorization': 'Bearer $token'}),
//           );
//           if (response.data['success']) {
//             towns = (response.data['data'] as List)
//                 .map((townData) => Data.fromJson(townData))
//                 .toList();
//             isLoadingTowns = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<void> fetchAreas(int typeEventId, int townId, String token) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       areas.clear(); // Clear areas before fetching new data
//       isLoadingAreas = true;
//       notifyListeners();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '$baseUrl/user/getarea',
//             data: {'type_event_id': typeEventId, 'town_id': townId},
//             options: Options(headers: {'Authorization': 'Bearer $token'}),
//           );
//           if (response.data['success']) {
//             areas = (response.data['data'] as List)
//                 .map((areaData) => AreaData.fromJson(areaData))
//                 .toList();
//             isLoadingAreas = false;
//             notifyListeners();
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//         },
//       );
//     });
//   }

//   Future<Gethall> fetchHalls() async {
//     final dio = Dio();

//     // Prepare the request body with your data
//     final Map<String, dynamic> data = {
//       'budget_id': budgetId,
//       'area_id': areaId,
//       'town_id': townId,
//       'type_event_id': typeEventId,
//     };

//     // Add a header for the bearer token
//     dio.options.headers = {'Authorization': 'Bearer $token'};

//     try {
//       final response = await dio.post('$baseUrl/user/gethall', data: data);
//       if (response.statusCode == 200) {
//         return Gethall.fromJson(response.data); // Parse the response data
//       } else {
//         print('Error: ${response.data['message']}');
//         return Gethall(
//             success: false,
//             message: 'Error fetching halls',
//             data: [],
//             erros: null,
//             status: 0);
//       }
//     } on DioException catch (e) {
//       // Handle errors here
//       print('DioException: ${e.message}');
//       return Gethall(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: e,
//           status: 0);
//     } catch (e) {
//       print('Error: $e');
//       return Gethall(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: e,
//           status: 0);
//     }
//   }

//   Future<void> fetchBudgets(
//       int typeEventId, int townId, int areaId, String token) async {
//     if (_debounce?.isActive ?? false) _debounce!.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () async {
//       budgets.clear();
//       isLoadingBudgets = true;
//       notifyListeners();
//       await _retry(
//         () async {
//           final response = await _dio.post(
//             '$baseUrl/user/getbudget',
//             data: {
//               'type_event_id': typeEventId,
//               'town_id': townId,
//               'area_id': areaId
//             },
//             options: Options(headers: {'Authorization': 'Bearer $token'}),
//           );
//           if (response.data['success']) {
//             // Parse response data into Budget1 instance
//             Budget1 budget1 = Budget1.fromJson(response.data);
//             // Assign data to budgets list
//             if (budget1.data != null) {
//               budgets.addAll(budget1.data!);
//             }
//           } else {
//             print('Error: ${response.data['message']}');
//           }
//           isLoadingBudgets = false;
//           notifyListeners();
//         },
//       );
//     });
//   }



//   Future<void> _retry(Future<void> Function() request,
//       {int retries = 3}) async {
//     for (int attempt = 0; attempt < retries; attempt++) {
//       try {
//         await request();
//         return;
//       } on DioException catch (e) {
//         if (e.response?.statusCode == 429) {
//           final delay = Duration(seconds: 2 << attempt); // Exponential backoff
//           await Future.delayed(delay);
//         } else {
//           print('DioException: ${e.message}');
//           throw e;
//         }
//       } catch (e) {
//         print('Error: $e');
//         throw e;
//       }
//     }
//   }

//   void setTypeEventId(int id) {
//     typeEventId = id;
//     notifyListeners();
//   }

//   void clearTypeEventId() {
//     typeEventId = null;
//     notifyListeners();
//   }

//   void setTownId(int id) {
//     townId = id;
//     notifyListeners();
//   }

//   void setAreaId(int id) {
//     areaId = id;
//     notifyListeners();
//   }

//   void clearTownId() {
//     townId = null;
//     notifyListeners();
//   }

//   void clearAreaId() {
//     areaId = null;
//     notifyListeners();
//   }

//   void clearAreas() {
//     areas.clear();
//     notifyListeners();
//   }

//   void setBudgetId(int id) {
//     budgetId = id;
//     notifyListeners();
//   }
// }










  // Future<void> fetchBudgets(
  //     int typeEventId, int townId, int areaId, String token) async {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () async {
  //     budgets.clear();
  //     isLoadingBudgets = true;
  //     notifyListeners();
  //     await _retry(
  //       () async {
  //         final response = await _dio.post(
  //           '$baseUrl/user/getbudget',
  //           data: {
  //             'type_event_id': typeEventId,
  //             'town_id': townId,
  //             'area_id': areaId
  //           },
  //           options: Options(headers: {'Authorization': 'Bearer $token'}),
  //         );
  //         if (response.data['success']) {
  //           budgets = (response.data['data'] as List)
  //               .map((budgetData) => Data2.fromJson(budgetData))
  //               .toList();
  //         } else {
  //           print('Error: ${response.data['message']}');
  //         }
  //         isLoadingBudgets = false;
  //         notifyListeners();
  //       },
  //     );
  //   });
  // }






// class ApiModel extends Model {
//   final Dio _dio = Dio();
//   List<Data> towns = [];
//   List<AreaData> areas = [];
//   int? typeEventId;
//   int? townId;
//   final String baseUrl = 'http://10.0.2.2:8000/api';
//   final String token =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTcyZTM4YTRkZDVhNTZjMjlmYWFhYzg0ZGQ4M2Q3ODM2ZmVmY2VhMjBmNTQ1NTEzYTJlMTE5MzE2MDRlZGM1OTZlZDEwOGYwNWU3YWExZGIiLCJpYXQiOjE3MTk2NjUwNjQuNDAxMzY3LCJuYmYiOjE3MTk2NjUwNjQuNDAxMzcsImV4cCI6MTc1MTIwMTA2NC4zMTU2ODEsInN1YiI6IjIiLCJzY29wZXMiOlsidXNlciJdfQ.eZuL6YKi1SGVWr4PJ5B8B0mQJqJpJufDP2jQGCXC6SCXKkhDwGepZ60mrl_G8_mYUB8dcekZPoyeuBFzIhhXWwMDGLSWdqdB_KzZDPOc1hgvXluJvf2h0teG523AgvbMRuL_s6yH7q5yVfPAUyTQdlAXSE3ionHHhGwyOpC60JtEDg_LR5UV2Ea4zcwUH7-z1urZzhfdMeDdfNSmPAvHTkDKZq3pz5KNvRzgTqwQiCdlq__k1xAjXVCEiGiKsPJCFNAXoaDX0n_qjfeooi3-dU6GV3_Cs6hNb_8zM9OOoHhBLv7ba1ORLMxYpYC8nhSMtiYuK6SKA4oTYQgxCwl3h67s4vkPleDajhtJHFPiK_-XmfZxryO2gt6Pr_7zmUCdr5H8rxfzbDbNqSSDGWF5-CmjumfXNaBNYwDNqIDnyrxo6uaLM0c7igkqIj6UxQPGPdkgZQAzLYx5Pg9lERsIabRHI6saUzcBe-mcyausxN5RkCXX1X8EZwfeTOh8_lYDCDai7EHiW-kcf79F6E6KfIPo_vHMg8tCNEorTXWexRzMUctFoVZKp7On5NWxqrM0Unyz0NoyLpH6HZy8S83oRnWPo6mOEY8qz8V_KLP6eOX-5wkJwsYJz-SRN-cRKPY2t-5GSbfvhvzcxUFszGJ9-AEV3b4iw5I7M3kOFilORIQ'; // Replace with your actual token

//   Future<Autogenerated?> fetchTowns(int typeEventId, String token) async {
//     try {
//       final response = await _dio.post(
//         '$baseUrl/user/gettown',
//         data: {
//           'type_event_id': 1,
//         },
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );
//       if (response.data['success']) {
//         towns = (response.data['data'] as List)
//             .map((townData) => Data.fromJson(townData))
//             .toList();
//         notifyListeners();
//       }
//     } on DioException catch (e) {
//       print(e.error);
//       return Autogenerated(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: '',
//           status: 0);
//     }
//     return null;
//   }

// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//   Future<Gethall> fetchHalls() async {
//     final dio = Dio();

//     // Prepare the request body with your data
//     final Map<String, dynamic> data = {
//       'budget_id': 3,
//       'area_id': 4,
//       'town_id': 1,
//       'type_event_id': 1,
//     };

//     // Add a header for the bearer token
//     dio.options.headers = {'Authorization': 'Bearer $token'};

//     try {
//       final response = await dio.post('$baseUrl/user/gethall', data: data);
//       return Gethall.fromJson(response.data); // Parse the response data
//     } on DioException catch (e) {
//       // Handle errors here
//       print(e.error);
//       return Gethall(
//           success: false,
//           message: 'Error fetching halls',
//           data: [],
//           erros: e,
//           status: 0);
//     }
//   }

//   Future<void> fetchAreas(int typeEventId, int townId, String token) async {
//     try {
//       final response = await _dio.post(
//         '$baseUrl/user/getarea',
//         data: {'type_event_id': typeEventId, 'town_id': townId},
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );
//       if (response.data['success']) {
//         areas = (response.data['data'] as List)
//             .map((areaData) => AreaData.fromJson(areaData))
//             .toList();
//         notifyListeners();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void setTypeEventId(int id) {
//     typeEventId = id;
//     notifyListeners();
//   }

//   void clearTypeEventId() {
//     typeEventId = null;
//     notifyListeners();
//   }

//   void setTownId(int id) {
//     townId = id;
//     notifyListeners();
//   }

//   void clearTownId() {
//     townId = null;
//     notifyListeners();
//   }

//   void clearAreas() {
//     areas.clear();
//     notifyListeners();
//   }
// }
