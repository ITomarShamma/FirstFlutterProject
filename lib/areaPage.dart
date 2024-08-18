import 'package:flutter/material.dart';
import 'package:pro2/budgetPage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AreaPage extends StatefulWidget {
  final int townId;
  final int typeEventId;
  final String token;

  const AreaPage(
      {super.key,
      required this.townId,
      required this.typeEventId,
      required this.token});

  @override
  _AreaPageState createState() => _AreaPageState();
}

var apiModel = ApiModel();

class _AreaPageState extends State<AreaPage> {
  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchAreas(
      widget.typeEventId,
      widget.townId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Colors.deepPurpleAccent,
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            title: Text(
              'Choose Hall Area',
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
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/2870be27-7a41-4de9-a575-1fba2cc28fd8.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: model.isLoadingAreas
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 3 / 2,
                      ),
                      // gridDelegate:
                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 2,
                      //   crossAxisSpacing: 80,
                      //   mainAxisSpacing: 40,
                      // ),
                      itemCount: model.areas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final area = model.areas[index];
                        return GestureDetector(
                          onTap: () async {
                            model.setSelectedAreaName(area.name!);
                            model.setAreaId(area.id!);
                            // Set the

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Budget(
                                        areaId: area.id!,
                                        townId: widget.townId,
                                        typeEventId: widget.typeEventId,
                                        token: widget.token,
                                        // token: ApiModel().token,
                                      )),
                            );
                          },
                          child: Card(
                            color: ColorManager.primaryColor2,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  area.name!,
                                  style: TextStyle(
                                    color: ColorManager.primaryColor8,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          // child: Container(
                          //   decoration: BoxDecoration(
                          //     gradient: const LinearGradient(
                          //       colors: [
                          //         ColorManager.primaryColor8,
                          //         ColorManager.primaryColor2,
                          //       ],
                          //       begin: Alignment.bottomLeft,
                          //       end: Alignment.topRight,
                          //     ),
                          //     borderRadius: BorderRadius.circular(20),
                          //     border: Border.all(
                          //         color: ColorManager.primaryColor, width: 5),
                          //   ),
                          //   child: Center(
                          //     child: Text(
                          //       area.name!,
                          //       style: const TextStyle(
                          //         color: ColorManager.primaryColor,
                          //         fontSize: 28,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}


























// class AreaPage extends StatefulWidget {
//   final int townId;
//   final int typeEventId;
//   final String token;

//   const AreaPage(
//       {super.key,
//       required this.townId,
//       required this.typeEventId,
//       required this.token});

//   @override
//   _AreaPageState createState() => _AreaPageState();
// }

// var apiModel = ApiModel();

// class _AreaPageState extends State<AreaPage> {
//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchAreas(widget.typeEventId, widget.townId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           backgroundColor: Colors.deepPurpleAccent,
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: Text(
//               'Choose Hall Area',
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: ColorManager.primaryColor8,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_rounded,
//                 color: Colors.purple[100],
//                 size: 30,
//               ),
//               onPressed: () {
//                 //model.clearTownId(); // Clear townId
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     'lib/assets/2870be27-7a41-4de9-a575-1fba2cc28fd8.jpg'),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: model.isLoadingAreas
//                   ? const Center(child: CircularProgressIndicator())
//                   : GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 3 / 2,
//                       ),
//                       // gridDelegate:
//                       //     const SliverGridDelegateWithFixedCrossAxisCount(
//                       //   crossAxisCount: 2,
//                       //   crossAxisSpacing: 80,
//                       //   mainAxisSpacing: 40,
//                       // ),
//                       itemCount: model.areas.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final area = model.areas[index];
//                         return GestureDetector(
//                           onTap: () async {
//                             model.setSelectedAreaName(area.name!);
//                             model.setAreaId(area.id!);
//                             // Set the

//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Budget(
//                                         areaId: area.id!,
//                                         townId: widget.townId,
//                                         typeEventId: widget.typeEventId,
//                                         token: widget.token,
//                                         // token: ApiModel().token,
//                                       )),
//                             );
//                           },
//                           child: Card(
//                             color: ColorManager.primaryColor2,
//                             margin: EdgeInsets.all(8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 5,
//                             child: Center(
//                               child: Padding(
//                                 padding: EdgeInsets.all(16),
//                                 child: Text(
//                                   area.name!,
//                                   style: TextStyle(
//                                     color: ColorManager.primaryColor8,
//                                     fontSize: 26,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // child: Container(
//                           //   decoration: BoxDecoration(
//                           //     gradient: const LinearGradient(
//                           //       colors: [
//                           //         ColorManager.primaryColor8,
//                           //         ColorManager.primaryColor2,
//                           //       ],
//                           //       begin: Alignment.bottomLeft,
//                           //       end: Alignment.topRight,
//                           //     ),
//                           //     borderRadius: BorderRadius.circular(20),
//                           //     border: Border.all(
//                           //         color: ColorManager.primaryColor, width: 5),
//                           //   ),
//                           //   child: Center(
//                           //     child: Text(
//                           //       area.name!,
//                           //       style: const TextStyle(
//                           //         color: ColorManager.primaryColor,
//                           //         fontSize: 28,
//                           //         fontWeight: FontWeight.bold,
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                         );
//                       },
//                     ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }























// class AreaPage extends StatelessWidget {
//   final int townId;
//   final int typeEventId;
//   final String token;

//   const AreaPage(
//       {super.key,
//       required this.townId,
//       required this.typeEventId,
//       required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         model.fetchAreas(typeEventId, townId, token);
//         return Scaffold(
//           backgroundColor: Colors.deepPurpleAccent,
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: const Center(
//               child: Text(
//                 'Choose Hall Area',
//                 style: TextStyle(color: ColorManager.primaryColor8),
//               ),
//             ),
//             leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.purple[100],
//                   size: 30,
//                 ),
//                 onPressed: () async {
//                   model.clearAreas();
//                   model.clearTownId();
//                   Navigator.of(context).pop();
//                 }),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: model.areas.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 80,
//                       mainAxisSpacing: 40,
//                     ),
//                     itemCount: model.areas.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final area = model.areas[index];
//                       return Container(
//                         child: Center(
//                           child: Text(
//                             area.name!,
//                             style: TextStyle(
//                               color: ColorManager.primaryColor,
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               ColorManager.primaryColor8,
//                               ColorManager.primaryColor2,
//                             ],
//                             begin: Alignment.bottomLeft,
//                             end: Alignment.topRight,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: ColorManager.primaryColor, width: 5),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }















// class AreaPage extends StatelessWidget {
//   final int townId;
//   final int typeEventId;
//   final String token;

//   const AreaPage(
//       {super.key,
//       required this.townId,
//       required this.typeEventId,
//       required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         model.fetchAreas(typeEventId, townId, token);
//         return Scaffold(
//           backgroundColor: Colors.deepPurpleAccent,
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: const Center(
//               child: Text(
//                 'Choose Hall Area',
//                 style: TextStyle(color: ColorManager.primaryColor8),
//               ),
//             ),
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_rounded,
//                 color: Colors.purple[100],
//                 size: 30,
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: model.areas.isEmpty
//                 ? Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 80,
//                             mainAxisSpacing: 40),
//                     itemCount: model.areas.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final area = model.areas[index];
//                       return Container(
//                         child: Center(
//                           child: Text(
//                             area.name!,
//                             style: TextStyle(
//                               color: ColorManager.primaryColor,
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [
//                               ColorManager.primaryColor8,
//                               ColorManager.primaryColor2,
//                             ],
//                             begin: Alignment.bottomLeft,
//                             end: Alignment.topRight,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: ColorManager.primaryColor, width: 5),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }













// import 'package:flutter/material.dart';
// import 'package:pro2/global/color.dart';

// class Area extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurpleAccent,
//       appBar: AppBar(
//         backgroundColor: ColorManager.primaryColor,
//         title: const Padding(
//           padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
//           child: Center(
//             child: Text(
//               'Choose Hall Area',
//               style: TextStyle(color: ColorManager.primaryColor8),
//             ),
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_rounded,
//             color: Colors.purple[100],
//             size: 30,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, crossAxisSpacing: 80, mainAxisSpacing: 40),
//           itemCount: 20,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               child: Center(
//                   child: Text(
//                 'Altal',
//                 style: TextStyle(
//                     color: ColorManager.primaryColor,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold),
//               )),
//               decoration: BoxDecoration(
//                   gradient: const LinearGradient(colors: [
//                     ColorManager.primaryColor8,
//                     ColorManager.primaryColor2,
//                   ], begin: Alignment.bottomLeft, end: Alignment.topRight),
//                   borderRadius: BorderRadius.circular(20),
//                   border:
//                       Border.all(color: ColorManager.primaryColor, width: 5)),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
