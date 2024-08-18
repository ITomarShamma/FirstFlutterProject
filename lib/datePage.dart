import 'package:flutter/material.dart';
import 'package:pro2/foodPage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/musicPage.dart';
import 'package:pro2/servicesTabbedPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:pro2/models/dateModel.dart';

class DatePage7alaWidget extends StatefulWidget {
  final int placeId;
  final String token;

  const DatePage7alaWidget({
    super.key,
    required this.placeId,
    required this.token,
  });

  @override
  State<DatePage7alaWidget> createState() => _DatePage7alaWidgetState();
}

class _DatePage7alaWidgetState extends State<DatePage7alaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedMonth;
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchAvailableMonths(widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: ColorManager.primaryColor,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: ColorManager.primaryColor8,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'DatePage',
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
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'lib/assets/c8ee76ae-1d78-4a9d-889f-05a2aaa7d8c4.jpg',
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 100, 25, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      hint: Text('Select the month',
                          style: const TextStyle(
                              color: ColorManager.primaryColor8)),
                      value: selectedMonth,
                      items: model.availableMonths.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(
                                  color: ColorManager.primaryColor8,
                                  fontWeight: FontWeight.w800)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedMonth = val;
                          selectedDate = null;
                        });
                        model.fetchDates(
                          placeId: widget.placeId,
                          month: val!,
                          // token: widget.token,
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  ColorManager.primaryColor2), // Border color
                        ),
                        filled: true,
                        fillColor:
                            ColorManager.primaryColor2, // Background color
                      ),
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      hint: Text('Select exact date',
                          style: const TextStyle(
                              color: ColorManager.primaryColor8)),
                      value: selectedDate,
                      items: model.dates
                          .map<DropdownMenuItem<String>>((DateData date) {
                        return DropdownMenuItem<String>(
                          value: date.date,
                          child: Text(date.date ?? '',
                              style: const TextStyle(
                                  color: ColorManager.primaryColor8,
                                  fontWeight: FontWeight.w800)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedDate = val;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  ColorManager.primaryColor2), // Border color
                        ),
                        filled: true,
                        fillColor:
                            ColorManager.primaryColor2, // Background color
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedMonth != null && selectedDate != null) {
                            model.setPlaceId(widget.placeId);
                            model.setSelectedDateDetails(
                              month: selectedMonth!,
                              date: selectedDate!,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabbedPageWidget(
                                  placeId: widget.placeId,
                                  token: widget.token,
                                ),
                                // ServicesFoodPageWidget(
                                //   placeId: widget.placeId,
                                //   token: widget.token,
                                // ),
                                // ServicesMusicPageWidget(
                                //   placeId: widget.placeId,
                                //   token: widget.token,
                                // ),
                              ),
                            );
                          } else {
                            _showErrorDialog(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: ColorManager.primaryColor,
                          foregroundColor: ColorManager.primaryColor8,
                          textStyle: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: ColorManager.primaryColor,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text('Next'),
                      ),
                    ),
                  ].divide(SizedBox(height: 16)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorManager.primaryColor8,
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






















// class DatePage7alaWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const DatePage7alaWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<DatePage7alaWidget> createState() => _DatePage7alaWidgetState();
// }

// class _DatePage7alaWidgetState extends State<DatePage7alaWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   String? selectedMonth;
//   String? selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchAvailableMonths(widget.placeId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Scaffold(
//             key: scaffoldKey,
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.deepPurple,
//               automaticallyImplyLeading: false,
//               leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               title: Text(
//                 'DatePage',
//                 style: TextStyle(
//                   fontFamily: 'Outfit',
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               centerTitle: true,
//               elevation: 2,
//             ),
//             body: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     'lib/assets/c8ee76ae-1d78-4a9d-889f-05a2aaa7d8c4.jpg',
//                   ),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(top: 100),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedMonth,
//                       items: model.availableMonths.map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedMonth = val;
//                           selectedDate = null;
//                         });
//                         model.fetchDates(
//                           placeId: widget.placeId,
//                           month: val!,
//                           token: widget.token,
//                         );
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select the month',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       value: selectedDate,
//                       items: model.dates
//                           .map<DropdownMenuItem<String>>((DateData date) {
//                         return DropdownMenuItem<String>(
//                           value: date.date,
//                           child: Text(date.date ?? ''),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedDate = val;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select exact date',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     ElevatedButton(
//                       onPressed: () {
//                         print('Button pressed ...');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo,
//                         padding: EdgeInsets.symmetric(horizontal: 24),
//                         textStyle: TextStyle(
//                           fontFamily: 'Readex Pro',
//                           color: Colors.white,
//                           fontSize: 20,
//                           letterSpacing: 3,
//                           fontWeight: FontWeight.w800,
//                         ),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: Colors.deepPurple,
//                             width: 3,
//                           ),
//                         ),
//                       ),
//                       child: Text('Next'),
//                     ),
//                   ].divide(SizedBox(height: 16)),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// extension ListExtensions<T> on List<T> {
//   List<T> divide(T divider) {
//     if (this.isEmpty) return this;
//     return this.length == 1
//         ? this
//         : this.sublist(0, this.length - 1).fold<List<T>>(
//             [],
//             (initialValue, element) => [...initialValue, element, divider],
//           )
//       ..add(this.last);
//   }
// }












//----------------------------------------------------------------the page without months api ...
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:dio/dio.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:pro2/models/dateModel.dart';

// class DatePage7alaWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const DatePage7alaWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<DatePage7alaWidget> createState() => _DatePage7alaWidgetState();
// }

// class _DatePage7alaWidgetState extends State<DatePage7alaWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   String? selectedMonth;
//   String? selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Scaffold(
//             key: scaffoldKey,
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.deepPurple,
//               automaticallyImplyLeading: false,
//               leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               title: Text(
//                 'DatePage',
//                 style: TextStyle(
//                   fontFamily: 'Outfit',
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               centerTitle: true,
//               elevation: 2,
//             ),
//             body: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     'lib/assets/c8ee76ae-1d78-4a9d-889f-05a2aaa7d8c4.jpg',
//                   ),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(top: 100),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedMonth,
//                       items: ['Option 1'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedMonth = val;
//                         });
//                         model.fetchDates(
//                           placeId: 1,
//                           month: '7',
//                           token: widget.token,
//                           // placeId: widget.placeId,
//                           // month: val!,
//                           // token: widget.token,
//                         );
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select the month',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       value: selectedDate,
//                       items: model.dates
//                           .map<DropdownMenuItem<String>>((DateData date) {
//                         return DropdownMenuItem<String>(
//                           value: date.date,
//                           child: Text(date.date ?? ''),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedDate = val;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select exact date',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     ElevatedButton(
//                       onPressed: () {
//                         print('Button pressed ...');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo,
//                         padding: EdgeInsets.symmetric(horizontal: 24),
//                         textStyle: TextStyle(
//                           fontFamily: 'Readex Pro',
//                           color: Colors.white,
//                           fontSize: 20,
//                           letterSpacing: 3,
//                           fontWeight: FontWeight.w800,
//                         ),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: Colors.deepPurple,
//                             width: 3,
//                           ),
//                         ),
//                       ),
//                       child: Text('Next'),
//                     ),
//                   ].divide(SizedBox(height: 16)),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// extension ListExtensions<T> on List<T> {
//   List<T> divide(T divider) {
//     if (this.isEmpty) return this;
//     return this.length == 1
//         ? this
//         : this.sublist(0, this.length - 1).fold<List<T>>(
//             [],
//             (initialValue, element) => [...initialValue, element, divider],
//           )
//       ..add(this.last);
//   }
// }
//................................................................


































// class DatePage7alaWidget extends StatefulWidget {
//   const DatePage7alaWidget({super.key});

//   @override
//   State<DatePage7alaWidget> createState() => _DatePage7alaWidgetState();
// }

// class _DatePage7alaWidgetState extends State<DatePage7alaWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   String? selectedMonth;
//   String? selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Scaffold(
//             key: scaffoldKey,
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.deepPurple,
//               automaticallyImplyLeading: false,
//               leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               title: Text(
//                 'DatePage',
//                 style: TextStyle(
//                   fontFamily: 'Outfit',
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               centerTitle: true,
//               elevation: 2,
//             ),
//             body: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     'lib/assets/c8ee76ae-1d78-4a9d-889f-05a2aaa7d8c4.jpg',
//                   ),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(top: 100),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedMonth,
//                       items: model.dates
//                           .map<DropdownMenuItem<String>>((DateData date) {
//                         return DropdownMenuItem<String>(
//                           value: date.month,
//                           child: Text(date.month ?? ''),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedMonth = val;
//                         });
//                         model.fetchDates(
//                           placeId: 1, // Use the actual placeId from your logic
//                           month: val!,
//                           token: model.token,
//                         );
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select the month',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       value: selectedDate,
//                       items: model.dates
//                           .map<DropdownMenuItem<String>>((DateData date) {
//                         return DropdownMenuItem<String>(
//                           value: date.date,
//                           child: Text(date.date ?? ''),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedDate = val;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select exact date',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     ElevatedButton(
//                       onPressed: () {
//                         print('Button pressed ...');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo,
//                         padding: EdgeInsets.symmetric(horizontal: 24),
//                         textStyle: TextStyle(
//                           fontFamily: 'Readex Pro',
//                           color: Colors.white,
//                           fontSize: 20,
//                           letterSpacing: 3,
//                           fontWeight: FontWeight.w800,
//                         ),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: Colors.deepPurple,
//                             width: 3,
//                           ),
//                         ),
//                       ),
//                       child: Text('Next'),
//                     ),
//                   ].divide(SizedBox(height: 16)),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// extension ListExtensions<T> on List<T> {
//   List<T> divide(T divider) {
//     if (this.isEmpty) return this;
//     return this.length == 1
//         ? this
//         : this.sublist(0, this.length - 1).fold<List<T>>(
//             [],
//             (initialValue, element) => [...initialValue, element, divider],
//           )
//       ..add(this.last);
//   }
// }



















// class DatePage7alaWidget extends StatefulWidget {
//   const DatePage7alaWidget({super.key});

//   @override
//   State<DatePage7alaWidget> createState() => _DatePage7alaWidgetState();
// }

// class _DatePage7alaWidgetState extends State<DatePage7alaWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   String? selectedMonth;
//   String? selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Scaffold(
//             key: scaffoldKey,
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.deepPurple,
//               automaticallyImplyLeading: false,
//               leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               title: Text(
//                 'DatePage',
//                 style: TextStyle(
//                   fontFamily: 'Outfit',
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               centerTitle: true,
//               elevation: 2,
//             ),
//             body: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     'assets/images/c8ee76ae-1d78-4a9d-889f-05a2aaa7d8c4.jpg',
//                   ),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(top: 100),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedMonth,
//                       items: ['Option 1'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedMonth = val;
//                         });
//                         model.fetchDates(
//                           placeId: 1, // Use the actual placeId from your logic
//                           month: val!,
//                           token: model.token,
//                         );
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select the month',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       value: selectedDate,
//                       items: model.dates.map((Data date) {
//                         return DropdownMenuItem<String>(
//                           value: date.date,
//                           child: Text(date.date ?? ''),
//                         );
//                       }).toList(),
//                       onChanged: (val) {
//                         setState(() {
//                           selectedDate = val;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Select exact date',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     ElevatedButton(
//                       onPressed: () {
//                         print('Button pressed ...');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo,
//                         padding: EdgeInsets.symmetric(horizontal: 24),
//                         textStyle: TextStyle(
//                           fontFamily: 'Readex Pro',
//                           color: Colors.white,
//                           fontSize: 20,
//                           letterSpacing: 3,
//                           fontWeight: FontWeight.w800,
//                         ),
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(
//                             color: Colors.deepPurple,
//                             width: 3,
//                           ),
//                         ),
//                       ),
//                       child: Text('Next'),
//                     ),
//                   ].divide(const SizedBox(height: 16)),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


