import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/homePagev.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';

class DetailsPageWidget extends StatefulWidget {
  const DetailsPageWidget({Key? key}) : super(key: key);

  @override
  _DetailsPageWidgetState createState() => _DetailsPageWidgetState();
}

class _DetailsPageWidgetState extends State<DetailsPageWidget> {
  int calculateTotalPrice(ApiModel model) {
    int total = 0;
    total += model.selectedChairsNumberPrice ?? 0;
    total += model.selectedTablesNumberPrice ?? 0;
    total += model.selectedThemePrice ?? 0;
    total += model.selectedThemeColorPrice ?? 0;
    total += model.selectedMainMealPrice ?? 0;
    total += model.selectedSweateTypePrice ?? 0;
    total += model.selectedMainCakePrice ?? 0;
    //total += model.selectedMusicTypePrice ?? 0;
    // Add any other prices if necessary
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
      int totalPrice = calculateTotalPrice(model);
      return Scaffold(
        backgroundColor: ColorManager.primaryColor8,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          title: Text(
            'DetailsPage',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: ColorManager.primaryColor8,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 2,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.purple[100],
              size: 30,
            ),
            onPressed: () {
              //model.clearTownId(); // Clear townId
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              buildDetailItem('Event Type', model.selectedEventType),
              buildDetailItem('Budget Name', model.selectedBudgetName),
              buildDetailTitle('HallLocationDetails'),
              buildDetailItem('Area Name', model.selectedAreaName),
              buildDetailItem('Town Name', model.selectedTownName),
              buildDetailTitle('DateDetails'),
              buildDetailItem('BookedDate', model.selectedDate),
              buildDetailTitle('DecorationDetails'),
              buildDetailItem('ChairsNumber', model.selectedChairsNumber),
              buildDetailItemPrice(
                  'ChairsNumberPrice', model.selectedChairsNumberPrice),
              buildDetailItem('TablesNumber', model.selectedTablesNumber),
              buildDetailItemPrice(
                  'TablesNumberPrice', model.selectedTablesNumberPrice),
              buildDetailItem('Lighting', model.selectedLighting),
              buildDetailItem('Theme', model.selectedTheme),
              buildDetailItemPrice('ThemePrice', model.selectedThemePrice),
              buildDetailItem('ThemeColor', model.selectedThemeColor),
              buildDetailItemPrice(
                  'ThemeColorPrice', model.selectedThemeColorPrice),
              buildDetailTitle('FoodDetails'),
              buildDetailItem('MainMeal', model.selectedMainMeal),
              buildDetailItemPrice(
                  'MainMealPrice', model.selectedMainMealPrice),
              buildDetailItem('SweateType', model.selectedSweateType),
              buildDetailItemPrice(
                  'SweateTypePrice', model.selectedSweateTypePrice),
              buildDetailItem('MainCake', model.selectedMainCake),
              buildDetailItemPrice(
                  'MainCakePrice', model.selectedMainCakePrice),
              buildDetailTitle('MusicDetails'),
              buildDetailItem('MusicType', model.selectedMusicType),
              buildDetailItemPrice(
                  'MusicTypePrice', model.selectedMusicTypePrice),
              buildDetailItem('Songs', model.selectedSong),
              buildDetailItem('More', model.selectedMoreDetails),
              buildDetailTitle('Total Price'),
              buildTotalPriceItem('Total Price', totalPrice),
              _SubmitButton(() async {
                model.fetchSubmit(totalPrice);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePageSaraWidget(),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  Widget buildDetailTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailItem(String title, String? detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Text(
              detail ?? 'Not set',
              style: const TextStyle(
                fontSize: 18,
                color: ColorManager.primaryColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailItemPrice(String title, int? detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Text(
              '\$${detail.toString()}' ?? 'Not set',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTotalPriceItem(String title, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: Text(
              '\$${total.toString()}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SubmitButton(VoidCallback onPressed) {
    return Container(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          backgroundColor: ColorManager.primaryColor,
          foregroundColor: ColorManager.primaryColor8,
          textStyle: const TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: ColorManager.primaryColor,
              width: 3,
            ),
          ),
        ),
        child: const Text('Next'),
      ),
    );
  }
}

























// class DetailsPageWidget extends StatefulWidget {
//   const DetailsPageWidget({Key? key}) : super(key: key);

//   @override
//   _DetailsPageWidgetState createState() => _DetailsPageWidgetState();
// }

// class _DetailsPageWidgetState extends State<DetailsPageWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return Scaffold(
//         backgroundColor: ColorManager.primaryColor8,
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           title: Text(
//             'DetailsPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: ColorManager.primaryColor8,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.purple[100],
//               size: 30,
//             ),
//             onPressed: () {
//               //model.clearTownId(); // Clear townId
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             scrollDirection: Axis.vertical,
//             children: [
//               // buildDetailItem('Music Details', 'model.selectedMusicDetails'),
//               // buildDetailItem('Food Details', 'model.selectedFoodDetails'),
//               // buildDetailItem(
//               //     'Decoration Details', 'model.selectedDecorationDetails'),
//               buildDetailItem('Event Type', model.selectedEventType),
//               buildDetailItem('Budget Name', model.selectedBudgetName),
//               buildDetailTitle('HallLocationDetails'),

//               buildDetailItem('Area Name', model.selectedAreaName),
//               buildDetailItem('Town Name', model.selectedTownName),
//               buildDetailTitle('DateDetails'),
//               //buildDetailItem('Month', model.selectedMonth),
//               buildDetailItem('BookedDate', model.selectedDate),
//               // buildDetailItem('Music Details', model.selectedMusicDetails),
//               // buildDetailItem('Food Details', model.selectedFoodDetails),
//               //             String? selectedChairsNumber;
//               // String? selectedTablesNumber;
//               // String? selectedLighting;
//               // String? selectedTheme;
//               // String? selectedThemeColor;
//               buildDetailTitle('DecororationDetails'),
//               buildDetailItem('ChairsNumber', model.selectedChairsNumber),
//               buildDetailItemPrice(
//                   'ChairsNumberPrice', model.selectedChairsNumberPrice),
//               buildDetailItem('TablesNumber', model.selectedTablesNumber),
//               buildDetailItemPrice(
//                   'TablesNumberPrice', model.selectedTablesNumberPrice),
//               buildDetailItem('Lighting', model.selectedLighting),
//               buildDetailItem('Theme', model.selectedTheme),
//               buildDetailItemPrice('ThemePrice', model.selectedThemePrice),
//               buildDetailItem('ThemeColor', model.selectedThemeColor),
//               buildDetailItemPrice(
//                   'ThemeColorPrice', model.selectedThemeColorPrice),

//               buildDetailTitle('FoodDetails'),
//               buildDetailItem('mainMeal', model.selectedMainMeal),
//               buildDetailItemPrice('mainMeaPrice', model.selectedMainMealPrice),
//               buildDetailItem('sweateType', model.selectedSweateType),
//               buildDetailItemPrice(
//                   'SweateTypePrice', model.selectedSweateTypePrice),
//               buildDetailItem('mainCake', model.selectedMainCake),
//               buildDetailItemPrice(
//                   'MainCakePrice', model.selectedMainCakePrice),

//               buildDetailTitle('MusicDetails'),
//               buildDetailItem('MusicType', model.selectedMusicType),
//               buildDetailItemPrice(
//                   'MusicTypePrice', model.selectedMusicTypePrice),
//               buildDetailItem('Songs', model.selectedSong),
//               buildDetailItem('More', model.selectedMoreDetails),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget buildDetailTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             '$title: ',
//             style: const TextStyle(
//               color: ColorManager.primaryColor,
//               fontWeight: FontWeight.bold,
//               fontSize: 28,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDetailItem(String title, String? detail) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$title: ',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               detail ?? 'Not set',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: ColorManager.primaryColor2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDetailItemPrice(String title, int? detail) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$title: ',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               detail.toString() ?? 'Not set',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
