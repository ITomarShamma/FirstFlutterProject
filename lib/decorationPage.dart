import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:pro2/detailsPage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/models/decorationModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';

class ServicesDecorationPageWidget extends StatefulWidget {
  final int placeId;
  final String token;
  final VoidCallback onNext;

  const ServicesDecorationPageWidget({
    Key? key,
    required this.placeId,
    required this.token,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ServicesDecorationPageWidget> createState() =>
      _ServicesDecorationPageWidgetState();
}

class _ServicesDecorationPageWidgetState
    extends State<ServicesDecorationPageWidget> {
  String? dropDownValue1;
  String? dropDownValue2;
  String? dropDownValue3;
  String? dropDownValue4;
  String? dropDownValue5;

  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchDecorationOptions(widget.placeId);
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
            'Decoration Session',
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
        body: model.isLoadingDecoration
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'lib/assets/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
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
                          'Chairs Number',
                          dropDownValue1,
                          (val) {
                            setState(() {
                              dropDownValue1 = val;
                              final selectedChair = model.chairsNumber
                                  .firstWhere((e) =>
                                      '${e.char!.num} (\$${e.char!.price})' ==
                                      val);
                              model.setSelectedDecorationDetails(
                                chairsNumber:
                                    selectedChair.char!.num.toString(),
                                chairsNumberPrice: selectedChair.char!.price!,
                                tablesNumber: model.selectedTablesNumber ?? '',
                                tablesNumberPrice:
                                    model.selectedTablesNumberPrice ?? 0,
                                lighting: model.selectedLighting ?? '',
                                theme: model.selectedTheme ?? '',
                                themePrice: model.selectedThemePrice ?? 0,
                                themeColor: model.selectedThemeColor ?? '',
                                themeColorPrice:
                                    model.selectedThemeColorPrice ?? 0,
                              );
                            });
                          },
                          model.chairsNumber
                              .map((e) => '${e.char!.num} (\$${e.char!.price})')
                              .toList(),
                        ),
                        _buildDropdown(
                          'Tables Number',
                          dropDownValue2,
                          (val) {
                            setState(() {
                              dropDownValue2 = val;
                              final selectedTable = model.tableesNumber
                                  .firstWhere((e) =>
                                      '${e.table!.num} (\$${e.table!.price})' ==
                                      val);
                              model.setSelectedDecorationDetails(
                                chairsNumber: model.selectedChairsNumber ?? '',
                                chairsNumberPrice:
                                    model.selectedChairsNumberPrice ?? 0,
                                tablesNumber:
                                    selectedTable.table!.num.toString(),
                                tablesNumberPrice: selectedTable.table!.price!,
                                lighting: model.selectedLighting ?? '',
                                theme: model.selectedTheme ?? '',
                                themePrice: model.selectedThemePrice ?? 0,
                                themeColor: model.selectedThemeColor ?? '',
                                themeColorPrice:
                                    model.selectedThemeColorPrice ?? 0,
                              );
                            });
                          },
                          model.tableesNumber
                              .map((e) =>
                                  '${e.table!.num} (\$${e.table!.price})')
                              .toList(),
                        ),
                        _buildDropdown(
                          'Lighting',
                          dropDownValue3,
                          (val) {
                            setState(() {
                              dropDownValue3 = val;
                              model.setSelectedDecorationDetails(
                                chairsNumber: model.selectedChairsNumber ?? '',
                                chairsNumberPrice:
                                    model.selectedChairsNumberPrice ?? 0,
                                tablesNumber: model.selectedTablesNumber ?? '',
                                tablesNumberPrice:
                                    model.selectedTablesNumberPrice ?? 0,
                                lighting: val!,
                                theme: model.selectedTheme ?? '',
                                themePrice: model.selectedThemePrice ?? 0,
                                themeColor: model.selectedThemeColor ?? '',
                                themeColorPrice:
                                    model.selectedThemeColorPrice ?? 0,
                              );
                            });
                          },
                          ['Option 1', 'Option 2', 'Option 3'],
                        ),
                        _buildDropdown(
                          'Theme',
                          dropDownValue4,
                          (val) {
                            setState(() {
                              dropDownValue4 = val;
                              final selectedTheme = model.theme.firstWhere(
                                  (e) =>
                                      '${e.typeTheme} (\$${e.price})' == val);
                              model.setSelectedDecorationDetails(
                                chairsNumber: model.selectedChairsNumber ?? '',
                                chairsNumberPrice:
                                    model.selectedChairsNumberPrice ?? 0,
                                tablesNumber: model.selectedTablesNumber ?? '',
                                tablesNumberPrice:
                                    model.selectedTablesNumberPrice ?? 0,
                                lighting: model.selectedLighting ?? '',
                                theme: selectedTheme.typeTheme!,
                                themePrice: selectedTheme.price!,
                                themeColor: model.selectedThemeColor ?? '',
                                themeColorPrice:
                                    model.selectedThemeColorPrice ?? 0,
                              );
                            });
                          },
                          model.theme
                              .map((e) => '${e.typeTheme} (\$${e.price})')
                              .toList(),
                        ),
                        _buildDropdown(
                          'Theme Color',
                          dropDownValue5,
                          (val) {
                            setState(() {
                              dropDownValue5 = val;
                              final selectedThemeColor = model.themeColor
                                  .firstWhere(
                                      (e) => '${e.type} (\$${e.price})' == val);
                              model.setSelectedDecorationDetails(
                                chairsNumber: model.selectedChairsNumber ?? '',
                                chairsNumberPrice:
                                    model.selectedChairsNumberPrice ?? 0,
                                tablesNumber: model.selectedTablesNumber ?? '',
                                tablesNumberPrice:
                                    model.selectedTablesNumberPrice ?? 0,
                                lighting: model.selectedLighting ?? '',
                                theme: model.selectedTheme ?? '',
                                themePrice: model.selectedThemePrice ?? 0,
                                themeColor: selectedThemeColor.type!,
                                themeColorPrice: selectedThemeColor.price!,
                              );
                            });
                          },
                          model.themeColor
                              .map((e) => '${e.type} (\$${e.price})')
                              .toList(),
                        ),
                        _buildNextButton(() {
                          if (dropDownValue1 != null &&
                              dropDownValue2 != null &&
                              dropDownValue3 != null &&
                              dropDownValue4 != null &&
                              dropDownValue5 != null) {
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

// class ServicesDecorationPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesDecorationPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesDecorationPageWidget> createState() =>
//       _ServicesDecorationPageWidgetState();
// }

// class _ServicesDecorationPageWidgetState
//     extends State<ServicesDecorationPageWidget> {
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;
//   String? dropDownValue4;
//   String? dropDownValue5;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchDecorationOptions(widget.placeId);
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
//             'Decoration Session',
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
//         body: model.isLoadingDecoration
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
//                           'Chairs Number',
//                           dropDownValue1,
//                           (val) => setState(() => dropDownValue1 = val),
//                           model.chairsNumber
//                               .map((e) => e.char!.num.toString())
//                               .toList(),
//                         ),
//                         _buildDropdown(
//                           'Tables Number',
//                           dropDownValue2,
//                           (val) => setState(() => dropDownValue2 = val),
//                           model.tableesNumber
//                               .map((e) => e.table!.num.toString())
//                               .toList(),
//                         ),
//                         _buildDropdown(
//                           'Lighting',
//                           dropDownValue3,
//                           (val) => setState(() => dropDownValue3 = val),
//                           ['Option 1', 'Option 2', 'Option 3'],
//                         ),
//                         _buildDropdown(
//                           'Theme',
//                           dropDownValue4,
//                           (val) => setState(() => dropDownValue4 = val),
//                           model.theme.map((e) => e.typeTheme!).toList(),
//                         ),
//                         _buildDropdown(
//                           'Theme Color',
//                           dropDownValue5,
//                           (val) => setState(() => dropDownValue5 = val),
//                           model.themeColor.map((e) => e.type!).toList(),
//                         ),
//                         _buildNextButton(() {
//                           model.setSelectedDecorationDetails(
//                             chairsNumber: dropDownValue1!,
//                             tablesNumber: dropDownValue2!,
//                             lighting: dropDownValue3!,
//                             theme: dropDownValue4!,
//                             themeColor: dropDownValue5!,
//                           );
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const DetailsPageWidget(),
//                             ),
//                           );
//                         }),
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

// Widget _buildDropdown(
//   String hint,
//   String? value,
//   Function(String?) onChanged,
//   List<String> items,
// ) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: Container(
//       width: 300,
//       height: 56,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2C2C54),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xFF9575CD), width: 2),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//           icon: const Icon(Icons.keyboard_arrow_down_rounded,
//               color: Color(0xFF757575), size: 24),
//           isExpanded: true,
//           onChanged: onChanged,
//           items: items.map<DropdownMenuItem<String>>((String option) {
//             return DropdownMenuItem<String>(
//               value: option,
//               child: Text(option,
//                   style: const TextStyle(
//                       color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//             );
//           }).toList(),
//         ),
//       ),
//     ),
//   );
// }

// return Padding(
//   padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//   child: ElevatedButton(
//     onPressed: widget.onNext,
//     style: ElevatedButton.styleFrom(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       backgroundColor: ColorManager.primaryColor,
//       foregroundColor: ColorManager.primaryColor8,
//       textStyle: const TextStyle(
//           fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(
//           color: ColorManager.primaryColor,
//           width: 3,
//         ),
//       ),
//     ),
//     child: Text('Next'),
//   ),
// );

// class ServicesDecorationPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesDecorationPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesDecorationPageWidget> createState() =>
//       _ServicesDecorationPageWidgetState();
// }

// class _ServicesDecorationPageWidgetState
//     extends State<ServicesDecorationPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;
//   String? dropDownValue4;
//   String? dropDownValue5;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchDecorationOptions(widget.placeId);
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
//               'DecorationPage',
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
//           body: model.isLoadingDecoration
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
//                             'Chairs Number',
//                             dropDownValue1,
//                             (val) => setState(() => dropDownValue1 = val),
//                             model.chairsNumber
//                                 .map((e) => e.char!.num.toString())
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Tables Number',
//                             dropDownValue2,
//                             (val) => setState(() => dropDownValue2 = val),
//                             model.tableesNumber
//                                 .map((e) => e.table!.num.toString())
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'Lighting',
//                             dropDownValue3,
//                             (val) => setState(() => dropDownValue3 = val),
//                             ['Option 1', 'Option 2', 'Option 3'],
//                           ),
//                           _buildDropdown(
//                             'Theme',
//                             dropDownValue4,
//                             (val) => setState(() => dropDownValue4 = val),
//                             model.theme.map((e) => e.typeTheme!).toList(),
//                           ),
//                           _buildDropdown(
//                             'Theme Color',
//                             dropDownValue5,
//                             (val) => setState(() => dropDownValue5 = val),
//                             model.themeColor.map((e) => e.type!).toList(),
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

// class ServicesDecorationPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesDecorationPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesDecorationPageWidget> createState() =>
//       _ServicesDecorationPageWidgetState();
// }

// class _ServicesDecorationPageWidgetState
//     extends State<ServicesDecorationPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   late FocusNode _unfocusNode;
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;
//   String? dropDownValue4;
//   String? dropDownValue5;

//   @override
//   void initState() {
//     super.initState();
//     _unfocusNode = FocusNode();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchDecorationOptions(widget.placeId);
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
//               'DecorationPage',
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: Color.fromARGB(255, 174, 56, 153),
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//           ),
//           body: model.isLoadingDecoration
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                           'lib/assets/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
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
//                             'ChairsNumber',
//                             dropDownValue1,
//                             (val) => setState(() => dropDownValue1 = val),
//                             model.chairsNumber
//                                 .map((e) => e.char!.num.toString())
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'TablesNumber',
//                             dropDownValue2,
//                             (val) => setState(() => dropDownValue2 = val),
//                             model.tableesNumber
//                                 .map((e) => e.table!.num.toString())
//                                 .toList(),
//                           ),
//                           // _buildDropdown(
//                           //   'Lighting',
//                           //   dropDownValue3,
//                           //   (val) => setState(() => dropDownValue3 = val),
//                           //   model.lighting.map((e) => e.toString()).toList(),
//                           // ),
//                           _buildDropdown(
//                             'Theme',
//                             dropDownValue4,
//                             (val) => setState(() => dropDownValue4 = val),
//                             model.theme
//                                 .map((e) => e.typeTheme.toString())
//                                 .toList(),
//                           ),
//                           _buildDropdown(
//                             'ThemeColor',
//                             dropDownValue5,
//                             (val) => setState(() => dropDownValue5 = val),
//                             model.themeColor
//                                 .map((e) => e.type.toString())
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
//             hint: Text(hint,
//                 style:
//                     const TextStyle(color: Color.fromARGB(255, 181, 35, 147))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 207, 51, 205),
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {
//           // Navigate to the next page
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A), // Correct parameter
//           foregroundColor:
//               const Color.fromARGB(255, 201, 59, 168), // Correct parameter
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

// class ServicesDecorationPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesDecorationPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesDecorationPageWidget> createState() =>
//       _ServicesDecorationPageWidgetState();
// }

// class _ServicesDecorationPageWidgetState
//     extends State<ServicesDecorationPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? selectedChairsNumber;
//   String? selectedTableesNumber;
//   String? selectedLighting;
//   String? selectedTheme;
//   String? selectedThemeColor;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchDecoration(widget.placeId);
//     });
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
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFF4A148C),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C2C54),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F), size: 30),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'DecorationPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color.fromARGB(255, 174, 56, 153),
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.isLoadingDecoration) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
//                 ),
//               ),
//               child: Align(
//                 alignment: AlignmentDirectional(0, -1),
//                 child: Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       _buildDropdown(
//                         'ChairsNumber',
//                         selectedChairsNumber,
//                         (val) => setState(() => selectedChairsNumber = val),
//                         model.chairsNumber
//                             .map((e) => e.char!.num.toString())
//                             .toList(),
//                       ),
//                       _buildDropdown(
//                         'TableesNumber',
//                         selectedTableesNumber,
//                         (val) => setState(() => selectedTableesNumber = val),
//                         model.tableesNumber
//                             .map((e) => e.table!.num.toString())
//                             .toList(),
//                       ),
//                       // _buildDropdown(
//                       //   'Lighting',
//                       //   selectedLighting,
//                       //   (val) => setState(() => selectedLighting = val),
//                       //   model.lighting
//                       //       .map((e) => e.toString())
//                       //       .toList(), // Adjust this line as per your Lighting model
//                       // ),
//                       _buildDropdown(
//                         'Theme',
//                         selectedTheme,
//                         (val) => setState(() => selectedTheme = val),
//                         model.theme.map((e) => e.typeTheme!).toList(),
//                       ),
//                       _buildDropdown(
//                         'ThemeColor',
//                         selectedThemeColor,
//                         (val) => setState(() => selectedThemeColor = val),
//                         model.themeColor.map((e) => e.type!).toList(),
//                       ),
//                       _buildNextButton(),
//                     ].divide(const SizedBox(height: 4)),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
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
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle the next action
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
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

extension ListExtensions<T> on List<T> {
  List<T> divide(T divider) {
    if (isEmpty) return this;
    return this.length == 1
        ? this
        : this.sublist(0, this.length - 1).fold<List<T>>(
            [],
            (initialValue, element) => [...initialValue, element, divider],
          )
      ..add(this.last);
  }
}























// class ServicesDecorationPageWidget extends StatefulWidget {
//   const ServicesDecorationPageWidget({super.key});

//   @override
//   State<ServicesDecorationPageWidget> createState() =>
//       _ServicesDecorationPageWidgetState();
// }

// class _ServicesDecorationPageWidgetState
//     extends State<ServicesDecorationPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;
//   String? dropDownValue4;
//   String? dropDownValue5;
//   List<String>? checkboxGroupValues = [];
//   late Dio _dio;

//   @override
//   void initState() {
//     super.initState();
//     _dio = Dio();
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
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFF4A148C),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C2C54),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F), size: 30),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'DecorationPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color.fromARGB(255, 174, 56, 153),
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: const AssetImage(
//                   'assets/images/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
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
//                   _buildDropdown('ChairsNumber', dropDownValue1,
//                       (val) => setState(() => dropDownValue1 = val)),
//                   _buildDropdown('TableesNumber', dropDownValue2,
//                       (val) => setState(() => dropDownValue2 = val)),
//                   _buildDropdown('Lighting', dropDownValue3,
//                       (val) => setState(() => dropDownValue3 = val)),
//                   _buildDropdown('Theme', dropDownValue4,
//                       (val) => setState(() => dropDownValue4 = val)),
//                   _buildDropdown('ThemeColor', dropDownValue5,
//                       (val) => setState(() => dropDownValue5 = val)),
                  
//                   _buildNextButton(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(
//       String hint, String? value, Function(String?) onChanged) {
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
//             hint: Text(hint,
//                 style: TextStyle(color: Color.fromARGB(255, 181, 35, 147))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: ['Option 1'].map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 207, 51, 205),
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

 

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {
//           print('Button pressed ...');
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A), // Correct parameter
//           foregroundColor:
//               Color.fromARGB(255, 201, 59, 168), // Correct parameter
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













 // Widget _buildCheckboxGroup() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Container(
  //       width: 300,
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [
  //             const Color(0xFF2C2C54),
  //             const Color(0xFF2E2E3A),
  //             const Color(0xFF4A148C),
  //             const Color(0xFFD1C4E9)
  //           ],
  //           stops: const [0, 1, 1, 1],
  //           begin: AlignmentDirectional(1, -1),
  //           end: AlignmentDirectional(-1, 1),
  //         ),
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(color: const Color(0xFF9575CD), width: 2),
  //       ),
  //       child: CheckboxListTile(
  //         title: const Text('Fancy WeddingReception',
  //             style: TextStyle(color: Color.fromARGB(255, 199, 67, 174))),
  //         value:
  //             checkboxGroupValues?.contains('Fancy WeddingReception') ?? false,
  //         onChanged: (bool? val) {
  //           setState(() {
  //             if (val == true) {
  //               checkboxGroupValues?.add('Fancy WeddingReception');
  //             } else {
  //               checkboxGroupValues?.remove('Fancy WeddingReception');
  //             }
  //           });
  //         },
  //         activeColor: const Color(0xFF9575CD),
  //         checkColor: const Color(0xFF2C2C54),
  //       ),
  //     ),
  //   );
  // }