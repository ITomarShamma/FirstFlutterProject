//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/decorationPage.dart';
import 'package:pro2/page1.dart';
//import 'package:provider/provider.dart';

//import 'services_food_page_model.dart';
//export 'services_food_page_model.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';

import 'package:pro2/global/color.dart';

class ServicesFoodPageWidget extends StatefulWidget {
  final int placeId;
  final String token;
  final VoidCallback onNext;

  const ServicesFoodPageWidget({
    Key? key,
    required this.placeId,
    required this.token,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
}

class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
  String? dropDownValue1;
  String? dropDownValue2;
  String? dropDownValue3;

  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchFoodOptions(widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: const Color(0xFF4A148C),
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Food Session',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: ColorManager.primaryColor8,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: model.isLoadingFood
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDropdown(
                          'Main Meal',
                          dropDownValue1,
                          (val) {
                            setState(() {
                              dropDownValue1 = val;
                              final selectedMeal = model.mainMeals.firstWhere((e) =>
                                  '${e.foodType!.name!} (\$${e.foodType!.price})' ==
                                  val);
                              model.setSelectedFoodDetails(
                                mainMeal: selectedMeal.foodType!.name!,
                                mainMealPrice: selectedMeal.foodType!.price!,
                                sweateType: model.selectedSweateType ?? '',
                                sweateTypePrice:
                                    model.selectedSweateTypePrice ?? 0,
                                mainCake: model.selectedMainCake ?? '',
                                mainCakePrice: model.selectedMainCakePrice ?? 0,
                              );
                            });
                          },
                          model.mainMeals
                              .map((e) =>
                                  '${e.foodType!.name!} (\$${e.foodType!.price})')
                              .toList(),
                        ),
                        _buildDropdown(
                          'Sweate Type',
                          dropDownValue2,
                          (val) {
                            setState(() {
                              dropDownValue2 = val;
                              final selectedSweate = model.sweateTypes
                                  .firstWhere((e) =>
                                      '${e.sweateType!.name!} (\$${e.sweateType!.price})' ==
                                      val);
                              model.setSelectedFoodDetails(
                                mainMeal: model.selectedMainMeal ?? '',
                                mainMealPrice: model.selectedMainMealPrice ?? 0,
                                sweateType: selectedSweate.sweateType!.name!,
                                sweateTypePrice:
                                    selectedSweate.sweateType!.price!,
                                mainCake: model.selectedMainCake ?? '',
                                mainCakePrice: model.selectedMainCakePrice ?? 0,
                              );
                            });
                          },
                          model.sweateTypes
                              .map((e) =>
                                  '${e.sweateType!.name!} (\$${e.sweateType!.price})')
                              .toList(),
                        ),
                        _buildDropdown(
                          'Main Cake',
                          dropDownValue3,
                          (val) {
                            setState(() {
                              dropDownValue3 = val;
                              final selectedCake = model.mainCakes.firstWhere((e) =>
                                  '${e.mainCake!.name!} (\$${e.mainCake!.price})' ==
                                  val);
                              model.setSelectedFoodDetails(
                                mainMeal: model.selectedMainMeal ?? '',
                                mainMealPrice: model.selectedMainMealPrice ?? 0,
                                sweateType: model.selectedSweateType ?? '',
                                sweateTypePrice:
                                    model.selectedSweateTypePrice ?? 0,
                                mainCake: selectedCake.mainCake!.name!,
                                mainCakePrice: selectedCake.mainCake!.price!,
                              );
                            });
                          },
                          model.mainCakes
                              .map((e) =>
                                  '${e.mainCake!.name!} (\$${e.mainCake!.price})')
                              .toList(),
                        ),
                        //       _buildNextButton(() {
                        //   if (selectedMusicType != null &&
                        //       selectedSong != null &&
                        //       selectedMore != null) {
                        //     widget.onNext();
                        //   } else {
                        //     _showErrorDialog(context);
                        //   }
                        // }),
                        _buildNextButton(() {
                          if (dropDownValue1 != null &&
                              dropDownValue2 != null &&
                              dropDownValue3 != null) {
                            widget.onNext();
                          } else {
                            _showErrorDialog(context);
                          }
                        }),
                      ].divide(const SizedBox(height: 4)),
                    ),
                  ),
                ),
              ),
      );
    });
  }

  Widget _buildDropdown(
    String hint,
    String? value,
    Function(String?) onChanged,
    List<String> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 350,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorManager.primaryColor2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorManager.primaryColor, width: 2),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint,
                style: const TextStyle(color: ColorManager.primaryColor8)),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF757575), size: 24),
            isExpanded: true,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option,
                    style: const TextStyle(
                        color: ColorManager.primaryColor8,
                        fontWeight: FontWeight.w800)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(VoidCallback onPressed) {
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

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorManager.primaryColor7,
          title: Text('Error'),
          content: Text(
            'Please fill all the fields before proceeding.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
// class ServicesFoodPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesFoodPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
// }

// class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchFoodOptions(widget.placeId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return Scaffold(
//         backgroundColor: const Color(0xFF4A148C),
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           automaticallyImplyLeading: false,
//           title: Text(
//             'Food Session',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: ColorManager.primaryColor8,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: model.isLoadingFood
//             ? const Center(child: CircularProgressIndicator())
//             : Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                         'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
//                   ),
//                 ),
//                 child: Align(
//                   alignment: AlignmentDirectional(0, -1),
//                   child: Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         _buildDropdown(
//                           'Main Meal',
//                           dropDownValue1,
//                           (val) => setState(() => dropDownValue1 = val),
//                           model.mainMeals
//                               .map((e) => e.foodType!.name!)
//                               .toList(),
//                         ),
//                         _buildDropdown(
//                           'Sweate Type',
//                           dropDownValue2,
//                           (val) => setState(() => dropDownValue2 = val),
//                           model.sweateTypes
//                               .map((e) => e.sweateType!.name!)
//                               .toList(),
//                         ),
//                         _buildDropdown(
//                           'Main Cake',
//                           dropDownValue3,
//                           (val) => setState(() => dropDownValue3 = val),
//                           model.mainCakes
//                               .map((e) => e.mainCake!.name!)
//                               .toList(),
//                         ),
//                         // _buildNextButton(() {
//                         //   model.setSelectedFoodDetails(
//                         //     mainMeal: dropDownValue1!,
//                         //     sweateType: dropDownValue2!,
//                         //     mainCake: dropDownValue3!,
//                         //   );
//                         //   widget.onNext();
//                         // }),
//                         _buildNextButton(() {
//                           model.setSelectedFoodDetails(
//                             mainMeal: dropDownValue1!,
//                             mainMealPrice: model.selectedMainMealPrice ?? 0,
//                             sweateType: dropDownValue2!,
//                             sweateTypePrice: model.selectedSweateTypePrice ?? 0,
//                             mainCake: dropDownValue3!,
//                             mainCakePrice: model.selectedMainCakePrice ?? 0,
//                           );
//                           widget.onNext();
//                         }),
//                         //  model.setSelectedFoodDetails(
//                         //         mainMeal: model.selectedMainMeal ?? '',
//                         //         mainMealPrice:
//                         //             model.selectedMainMealPrice ?? 0,
//                         //         sweateType: model.selectedSweateType ?? '',
//                         //         sweateTypePrice:
//                         //             model.selectedSweateTypePrice ?? 0,
//                         //         mainCake: selectedCake.mainCake!.name!,
//                         //         mainCakePrice: selectedCake.mainCake!.price!,
//                         //       );
//                         //     });
//                       ].divide(const SizedBox(height: 4)),
//                     ),
//                   ),
//                 ),
//               ),
//       );
//     });
//   }

//   Widget _buildDropdown(
//     String hint,
//     String? value,
//     Function(String?) onChanged,
//     List<String> items,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 350,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor2,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: ColorManager.primaryColor, width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint,
//                 style: const TextStyle(color: ColorManager.primaryColor8)),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: ColorManager.primaryColor8,
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton(VoidCallback onPressed) {
//     return Container(
//       width: 150,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: ColorManager.primaryColor,
//           foregroundColor: ColorManager.primaryColor8,
//           textStyle: const TextStyle(
//               fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: BorderSide(
//               color: ColorManager.primaryColor,
//               width: 3,
//             ),
//           ),
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: widget.onNext,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: ColorManager.primaryColor,
//           foregroundColor: ColorManager.primaryColor8,
//           textStyle: const TextStyle(
//               fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: BorderSide(
//               color: ColorManager.primaryColor,
//               width: 3,
//             ),
//           ),
//         ),
//         child: Text('Next'),
//       ),
//     );
//   }
// }

// class ServicesFoodPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesFoodPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
// }

// class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchFoodOptions(widget.placeId);
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: _unfocus,
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: const Color(0xFF4A148C),
//           appBar: AppBar(
//             backgroundColor: const Color(0xFF2C2C54),
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_rounded,
//                   color: Color(0xFFD32F2F), size: 30),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: const Text(
//               'FoodPage',
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: Color(0xFFD32F2F),
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//           ),
//           body: model.isLoadingFood
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                           'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: AlignmentDirectional(0, -1),
//                     child: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           _buildDropdown(
//                             'Main Meal',
//                             dropDownValue1,
//                             (val) => setState(() => dropDownValue1 = val),
//                             model.mainMeals
//                                 .map((e) => e.foodType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Sweate Type',
//                             dropDownValue2,
//                             (val) => setState(() => dropDownValue2 = val),
//                             model.sweateTypes
//                                 .map((e) => e.sweateType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Main Cake',
//                             dropDownValue3,
//                             (val) => setState(() => dropDownValue3 = val),
//                             model.mainCakes
//                                 .map((e) => e.mainCake!.name!)
//                                 .toList(),
//                           ),
//                           _buildNextButton(),
//                         ].divide(const SizedBox(height: 4)),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       );
//     });
//   }

//   Widget _buildDropdown(
//     String hint,
//     String? value,
//     Function(String?) onChanged,
//     List<String> items,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: widget.onNext,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// class ServicesFoodPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesFoodPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
// }

// class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchFoodOptions(widget.placeId);
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: _unfocus,
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: const Color(0xFF4A148C),
//           appBar: AppBar(
//             backgroundColor: const Color(0xFF2C2C54),
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_rounded,
//                   color: Color(0xFFD32F2F), size: 30),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: const Text(
//               'FoodPage',
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: Color(0xFFD32F2F),
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//           ),
//           body: model.isLoadingFood
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                           'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: AlignmentDirectional(0, -1),
//                     child: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           _buildDropdown(
//                             'Main Meal',
//                             dropDownValue1,
//                             (val) => setState(() => dropDownValue1 = val),
//                             model.mainMeals
//                                 .map((e) => e.foodType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Sweate Type',
//                             dropDownValue2,
//                             (val) => setState(() => dropDownValue2 = val),
//                             model.sweateTypes
//                                 .map((e) => e.sweateType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Main Cake',
//                             dropDownValue3,
//                             (val) => setState(() => dropDownValue3 = val),
//                             model.mainCakes
//                                 .map((e) => e.mainCake!.name!)
//                                 .toList(),
//                           ),
//                           _buildNextButton(),
//                         ].divide(const SizedBox(height: 4)),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       );
//     });
//   }

//   Widget _buildDropdown(
//     String hint,
//     String? value,
//     Function(String?) onChanged,
//     List<String> items,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: widget.onNext,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// extension on List<Widget> {
//   List<Widget> divide(Widget divider) {
//     if (isEmpty) return this;
//     final List<Widget> divided = [];
//     for (var i = 0; i < length; i++) {
//       divided.add(this[i]);
//       if (i < length - 1) {
//         divided.add(divider);
//       }
//     }
//     return divided;
//   }
// }

// class ServicesFoodPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   const ServicesFoodPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
// }

// class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   late FocusNode _unfocusNode;
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;

//   @override
//   void initState() {
//     super.initState();
//     _unfocusNode = FocusNode();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchFoodOptions(widget.placeId);
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: _unfocus,
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: const Color(0xFF4A148C),
//           appBar: AppBar(
//             backgroundColor: const Color(0xFF2C2C54),
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_rounded,
//                   color: Color(0xFFD32F2F), size: 30),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: const Text(
//               'FoodPage',
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: Color(0xFFD32F2F),
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//           ),
//           body: model.isLoadingFood
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                           'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: AlignmentDirectional(0, -1),
//                     child: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           _buildDropdown(
//                             'Main Meal',
//                             dropDownValue1,
//                             (val) => setState(() => dropDownValue1 = val),
//                             model.mainMeals
//                                 .map((e) => e.foodType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Sweate Type',
//                             dropDownValue2,
//                             (val) => setState(() => dropDownValue2 = val),
//                             model.sweateTypes
//                                 .map((e) => e.sweateType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Main Cake',
//                             dropDownValue3,
//                             (val) => setState(() => dropDownValue3 = val),
//                             model.mainCakes
//                                 .map((e) => e.mainCake!.name!)
//                                 .toList(),
//                           ),
//                           _buildNextButton(),
//                         ].divide(const SizedBox(height: 4)),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       );
//     });
//   }

//   Widget _buildDropdown(
//     String hint,
//     String? value,
//     Function(String?) onChanged,
//     List<String> items,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: () {
//           // Navigate to the next page
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// extension ListExtensions<T> on List<T> {
//   List<T> divide(T divider) {
//     if (isEmpty) return this;
//     final List<T> divided = [];
//     for (var i = 0; i < length; i++) {
//       divided.add(this[i]);
//       if (i < length - 1) {
//         divided.add(divider);
//       }
//     }
//     return divided;
//   }
// }

// class ServicesFoodPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   const ServicesFoodPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
// }

// class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchFoodOptions(widget.placeId);
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: _unfocus,
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: const Color(0xFF4A148C),
//           appBar: AppBar(
//             backgroundColor: const Color(0xFF2C2C54),
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_rounded,
//                   color: Color(0xFFD32F2F), size: 30),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: const Text(
//               'FoodPage',
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: Color(0xFFD32F2F),
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//           ),
//           body: model.isLoadingFood
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                           'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: AlignmentDirectional(0, -1),
//                     child: Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           _buildDropdown(
//                             'Main Meal',
//                             dropDownValue1,
//                             (val) => setState(() => dropDownValue1 = val),
//                             model.mainMeals
//                                 .map((e) => e.foodType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Sweate Type',
//                             dropDownValue2,
//                             (val) => setState(() => dropDownValue2 = val),
//                             model.sweateTypes
//                                 .map((e) => e.sweateType!.name!)
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Main Cake',
//                             dropDownValue3,
//                             (val) => setState(() => dropDownValue3 = val),
//                             model.mainCakes
//                                 .map((e) => e.mainCake!.name!)
//                                 .toList(),
//                           ),
//                           _buildNextButton(),
//                         ].divide(const SizedBox(height: 4)),
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       );
//     });
//   }

//   Widget _buildDropdown(
//     String hint,
//     String? value,
//     Function(String?) onChanged,
//     List<String> items,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: () {
//           // Navigate to the next page
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

extension on List<Widget> {
  List<Widget> divide(Widget divider) {
    if (isEmpty) return this;
    final List<Widget> divided = [];
    for (var i = 0; i < length; i++) {
      divided.add(this[i]);
      if (i < length - 1) {
        divided.add(divider);
      }
    }
    return divided;
  }
}


































// class ServicesFoodPageWidget extends StatefulWidget {
//   const ServicesFoodPageWidget({super.key});

//   @override
//   State<ServicesFoodPageWidget> createState() => _ServicesFoodPageWidgetState();
// }

// class _ServicesFoodPageWidgetState extends State<ServicesFoodPageWidget> {
//   //late ServicesFoodPageModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;
//   // String? dropDownValue4;
//   // List<String> checkboxGroupValues = [];

//   @override
//   void initState() {
//     super.initState();
//     //_model = createModel(context, () => ServicesFoodPageModel());
//   }

//   @override
//   void dispose() {
//     //_model.dispose();
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(
//             0xFF4A148C), // Replace FlutterFlowTheme.of(context).frenchViolet
//         appBar: AppBar(
//           backgroundColor: const Color(
//               0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F),
//                 size: 30), // Replace FlutterFlowIconButton
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'FoodPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color(
//                   0xFFD32F2F), // Replace FlutterFlowTheme.of(context).mauve
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ), // Replace FlutterFlowTheme.of(context).headlineMedium.override
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage(
//                   'lib/assets/9e53e86f-2567-4b46-bc88-8cc4c43f5acb.jpg'),
//             ),
//           ),
//           child: Align(
//             alignment: AlignmentDirectional(0, -1),
//             child: Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _buildDropdown('mainMeal', dropDownValue1,
//                       (val) => setState(() => dropDownValue1 = val)),
//                   _buildDropdown('SweateType', dropDownValue2,
//                       (val) => setState(() => dropDownValue2 = val)),
//                   _buildDropdown('MainCake', dropDownValue3,
//                       (val) => setState(() => dropDownValue3 = val)),
//                   // _buildDropdown(dropDownValue4,
//                   //     (val) => setState(() => dropDownValue4 = val)),
//                   //_buildCheckboxGroup(),
//                   _buildNextButton(),
//                 ].divide(
//                   const SizedBox(height: 4),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(
//       String listName, String? value, Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(
//               0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet2
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//               color: const Color(0xFF9575CD),
//               width: 2), // Replace FlutterFlowTheme.of(context).amethyst
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(listName,
//                 style: TextStyle(
//                     color: Color(
//                         0xFFD32F2F))), // Replace FlutterFlowTheme.of(context).mauve
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575),
//                 size: 24), // Replace FlutterFlowTheme.of(context).secondaryText
//             isExpanded: true,
//             onChanged: onChanged,
//             items: ['Option 1'].map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F),
//                         fontWeight: FontWeight
//                             .w800)), // Replace FlutterFlowTheme.of(context).bodyMedium.override
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: () {
//           //Navigator.push(
//           //    context,
//           //     MaterialPageRoute(
//           //         builder: (context) => const WeddingHallOmarWidget()));
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A), // Correct parameter
//           foregroundColor: const Color(0xFFD32F2F), // Correct parameter
//           textStyle: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(
//               color: Color(0xFF2C2C54),
//               width: 3), // Replace FlutterFlowTheme.of(context).russianViolet
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// extension on List<Widget> {
//   List<Widget> divide(Widget divider) {
//     if (isEmpty) return this;
//     final List<Widget> divided = [];
//     for (var i = 0; i < length; i++) {
//       divided.add(this[i]);
//       if (i < length - 1) {
//         divided.add(divider);
//       }
//     }
//     return divided;
//   }
// }












// Widget _buildCheckboxGroup() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Container(
  //       width: 300,
  //       decoration: BoxDecoration(
  //         gradient: const LinearGradient(
  //           colors: [
  //             Color(
  //                 0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet
  //             Color(
  //                 0xFF2E2E3A), // Replace FlutterFlowTheme.of(context).persianIndigo
  //             Color(
  //                 0xFF4A148C), // Replace FlutterFlowTheme.of(context).frenchViolet
  //             Color(
  //                 0xFFD1C4E9) // Replace FlutterFlowTheme.of(context).heliotrope
  //           ],
  //           stops: [0, 1, 1, 1],
  //           begin: AlignmentDirectional(1, -1),
  //           end: AlignmentDirectional(-1, 1),
  //         ),
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //             color: const Color(0xFF9575CD),
  //             width: 2), // Replace FlutterFlowTheme.of(context).amethyst
  //       ),
  //       child: Align(
  //         alignment: AlignmentDirectional(0, 0),
  //         child: Padding(
  //           padding: const EdgeInsets.all(2),
  //           child: Column(
  //             children: ['Soft drinks', 'Alcoholic beverages'].map((option) {
  //               return CheckboxListTile(
  //                 title: Text(option,
  //                     style: const TextStyle(
  //                         color: Color(
  //                             0xFFD32F2F))), // Replace FlutterFlowTheme.of(context).mauve
  //                 value: checkboxGroupValues.contains(option),
  //                 onChanged: (bool? val) {
  //                   setState(() {
  //                     if (val == true) {
  //                       checkboxGroupValues.add(option);
  //                     } else {
  //                       checkboxGroupValues.remove(option);
  //                     }
  //                   });
  //                 },
  //                 activeColor: const Color(
  //                     0xFF9575CD), // Replace FlutterFlowTheme.of(context).amethyst
  //                 checkColor: const Color(
  //                     0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
