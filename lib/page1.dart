import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pro2/datePage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/models/getHallModel.dart';
import 'package:pro2/musicPage.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

class WeddingHallOmarWidget extends StatefulWidget {
  final int areaId;
  final int townId;
  final int typeEventId;
  final int budgetId;
  final String token;

  const WeddingHallOmarWidget({
    super.key,
    required this.areaId,
    required this.townId,
    required this.typeEventId,
    required this.budgetId,
    required this.token,
  });

  @override
  State<WeddingHallOmarWidget> createState() => _WeddingHallOmarWidgetState();
}

class _WeddingHallOmarWidgetState extends State<WeddingHallOmarWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchHalls(
      widget.areaId,
      widget.townId,
      widget.typeEventId,
      widget.budgetId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 180, 20, 180),
        appBar: buildAppBar(context),
        body: buildBody(model),
      );
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.primaryColor,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: ColorManager.primaryColor8,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Choose Your Hall',
        style: TextStyle(
          fontFamily: 'Outfit',
          color: ColorManager.primaryColor8,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 2,
    );
  }

  Widget buildBody(ApiModel model) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'lib/assets/a4dad8b9-ae37-441e-8877-335a81e4bce7.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: FutureBuilder<Gethall>(
              future: model.fetchHalls(
                widget.areaId,
                widget.townId,
                widget.typeEventId,
                widget.budgetId,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching halls: ${snapshot.error}'),
                  );
                }

                if (snapshot.hasData) {
                  final halls = snapshot.data!.data;
                  return ListView.builder(
                    itemCount: halls?.length,
                    itemBuilder: (context, index) {
                      final hall = halls?[index];
                      // model.setHallPrice(HallPrice: hall?.price ?? 0);
                      return buildHallCard('lib/assets/sheraton-600x410_0.jpg',
                          hall?.name, hall?.id, model);
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHallCard(
      String? imagePath, String? name, int? placeId, ApiModel model) {
    return GestureDetector(
      onTap: () async {
        if (placeId != null) {
          model.setPlaceId(placeId); // Set the placeId in ApiModel
          model.setSelectedHallName(name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DatePage7alaWidget(
                placeId: placeId,
                token: widget.token,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Material(
          color: Colors.transparent,
          elevation: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(imagePath!),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 80,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: ColorManager.primaryColor2,
                width: 10,
              ),
            ),
            child: Align(
              alignment: const AlignmentDirectional(-1, 1),
              child: buildnameBanner(name!),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildnameBanner(String name) {
    return Material(
      color: Colors.transparent,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(26),
        ),
      ),
      child: Container(
        width: 250,
        height: 40,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor2,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(26),
          ),
          border: Border.all(
            color: ColorManager.primaryColor2,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'Merriweather',
              color: ColorManager.primaryColor8,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
















// class WeddingHallOmarWidget extends StatefulWidget {
//   final int areaId;
//   final int townId;
//   final int typeEventId;
//   final int budgetId;
//   final String token;

//   const WeddingHallOmarWidget({
//     super.key,
//     required this.areaId,
//     required this.townId,
//     required this.typeEventId,
//     required this.budgetId,
//     required this.token,
//   });

//   @override
//   State<WeddingHallOmarWidget> createState() => _WeddingHallOmarWidgetState();
// }

// class _WeddingHallOmarWidgetState extends State<WeddingHallOmarWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final apiModel = ApiModel();
//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchHalls(widget.areaId, widget.townId, widget.typeEventId,
//         widget.budgetId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Color.fromARGB(255, 180, 20, 180),
//         appBar: buildAppBar(context),
//         body: buildBody(),
//       );
//     });
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color.fromARGB(255, 95, 11, 86),
//       automaticallyImplyLeading: false,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back_rounded,
//           color: Colors.purple[100],
//           size: 30,
//         ),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       title: Text(
//         'Choose Your Hall',
//         style: TextStyle(
//           fontFamily: 'Outfit',
//           color: Colors.purple[100],
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       centerTitle: true,
//       elevation: 2,
//     );
//   }

//   Widget buildBody() {
  
//     return GestureDetector(
      
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                     'lib/assets/a4dad8b9-ae37-441e-8877-335a81e4bce7.jpg'),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: FutureBuilder<Gethall>(
//               future: apiModel.fetchHalls(widget.areaId, widget.townId,
//                   widget.typeEventId, widget.budgetId, widget.token),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   // Show error message
//                   return Center(
//                     child: Text('Error fetching halls: ${snapshot.error}'),
//                   );
//                 }

//                 if (snapshot.hasData) {
//                   final halls = snapshot.data!.data;
//                   return ListView.builder(
                    
//                     itemCount: halls?.length,
//                     itemBuilder: (context, index) {
//                       final hall = halls?[index];
//                       return buildHallCard('lib/assets/sheraton-600x410_0.jpg',
//                           hall?.name, hall?.id);
//                     },
//                   );
//                 }

//                 // Show loading indicator while waiting for data
//                 return const Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildHallCard(String? imagePath, String? name, int? placeId) {
//     return GestureDetector(
//       onTap: () async {
//         if (placeId != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => DatePage7alaWidget(
//                 placeId: placeId,
//                 token: widget.token,
//               ),
//             ),
//           );
//         }
//       },
//       child: Material(
//         color: Colors.transparent,
//         elevation: 100,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Container(
//           width: double.infinity,
//           height: 130,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: AssetImage(imagePath!),
//             ),
//             boxShadow: const [
//               BoxShadow(
//                 blurRadius: 80,
//                 color: Color(0x33000000),
//                 offset: Offset(0, 2),
//               ),
//             ],
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(
//               color: Colors.indigo[900]!,
//               width: 10,
//             ),
//           ),
//           child: Align(
//             alignment: const AlignmentDirectional(-1, 1),
//             child: buildnameBanner(name!),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildnameBanner(String name) {
//     return Material(
//       color: Colors.transparent,
//       elevation: 3,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(16),
//           bottomRight: Radius.circular(0),
//           topLeft: Radius.circular(0),
//           topRight: Radius.circular(26),
//         ),
//       ),
//       child: Container(
//         width: 250,
//         height: 40,
//         decoration: BoxDecoration(
//           color: Colors.indigo[900],
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(0),
//             topLeft: Radius.circular(0),
//             topRight: Radius.circular(26),
//           ),
//           border: Border.all(
//             color: Colors.indigo[900]!,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             name,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }











           




















// class WeddingHallOmarWidget extends StatefulWidget {
//   final int areaId;
//   final int townId;
//   final int typeEventId;
//   final int budgetId;
//   final String token;

//   const WeddingHallOmarWidget({
//     super.key,
//     required this.areaId,
//     required this.townId,
//     required this.typeEventId,
//     required this.budgetId,
//     required this.token,
//   });

//   @override
//   State<WeddingHallOmarWidget> createState() => _WeddingHallOmarWidgetState();
// }

// class _WeddingHallOmarWidgetState extends State<WeddingHallOmarWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final apiModel = ApiModel();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color.fromARGB(255, 180, 20, 180),
//       appBar: buildAppBar(context),
//       body: buildBody(),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color.fromARGB(255, 95, 11, 86),
//       automaticallyImplyLeading: false,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back_rounded,
//           color: Colors.purple[100],
//           size: 30,
//         ),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       title: Text(
//         'Choose Your Hall',
//         style: TextStyle(
//           fontFamily: 'Outfit',
//           color: Colors.purple[100],
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       centerTitle: true,
//       elevation: 2,
//     );
//   }

//   Widget buildBody() {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                     'lib/assets/a4dad8b9-ae37-441e-8877-335a81e4bce7.jpg'),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: FutureBuilder<Gethall>(
//               future: apiModel.fetchHalls(widget.areaId, widget.townId,
//                   widget.typeEventId, widget.budgetId, widget.token),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   // Show error message
//                   return Center(
//                     child: Text('Error fetching halls: ${snapshot.error}'),
//                   );
//                 }

//                 if (snapshot.hasData) {
//                   final halls = snapshot.data!.data;
//                   return ListView.builder(
//                     itemCount: halls?.length,
//                     itemBuilder: (context, index) {
//                       final hall = halls?[index];
//                       return buildHallCard(
//                           'lib/assets/sheraton-600x410_0.jpg', hall?.name);
//                     },
//                   );
//                 }

//                 // Show loading indicator while waiting for data
//                 return const Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildHallCard(String? imagePath, String? name) {
//     return Material(
//       color: Colors.transparent,
//       elevation: 100,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Container(
//         width: double.infinity,
//         height: 130,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: AssetImage(imagePath!),
//           ),
//           boxShadow: const [
//             BoxShadow(
//               blurRadius: 80,
//               color: Color(0x33000000),
//               offset: Offset(0, 2),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.indigo[900]!,
//             width: 10,
//           ),
//         ),
//         child: Align(
//           alignment: const AlignmentDirectional(-1, 1),
//           child: buildnameBanner(name!),
//         ),
//       ),
//     );
//   }

//   Widget buildnameBanner(String name) {
//     return Material(
//       color: Colors.transparent,
//       elevation: 3,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(16),
//           bottomRight: Radius.circular(0),
//           topLeft: Radius.circular(0),
//           topRight: Radius.circular(26),
//         ),
//       ),
//       child: Container(
//         width: 250,
//         height: 40,
//         decoration: BoxDecoration(
//           color: Colors.indigo[900],
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(0),
//             topLeft: Radius.circular(0),
//             topRight: Radius.circular(26),
//           ),
//           border: Border.all(
//             color: Colors.indigo[900]!,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             name,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




























// class WeddingHallOmarWidget extends StatefulWidget {
//   final int areaId;
//   final int townId;
//   final int typeEventId;
//   final int budgetId;
//   final String token;

//   const WeddingHallOmarWidget({
//     super.key,
//     required this.areaId,
//     required this.townId,
//     required this.typeEventId,
//     required this.budgetId,
//     required this.token,
//   });

//   @override
//   State<WeddingHallOmarWidget> createState() => _WeddingHallOmarWidgetState();
// }

// class _WeddingHallOmarWidgetState extends State<WeddingHallOmarWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final apiModel = ApiModel();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color.fromARGB(255, 180, 20, 180),
//       appBar: buildAppBar(context),
//       body: buildBody(),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color.fromARGB(255, 95, 11, 86),
//       automaticallyImplyLeading: false,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back_rounded,
//           color: Colors.purple[100],
//           size: 30,
//         ),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       title: Text(
//         'Choose Your Hall',
//         style: TextStyle(
//           fontFamily: 'Outfit',
//           color: Colors.purple[100],
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       centerTitle: true,
//       elevation: 2,
//     );
//   }

//   Widget buildBody() {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                     'lib/assets/a4dad8b9-ae37-441e-8877-335a81e4bce7.jpg'),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: FutureBuilder<Gethall>(
//               future: apiModel.fetchHalls(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   // Show error message
//                   return Center(
//                     child: Text('Error fetching halls: ${snapshot.error}'),
//                   );
//                 }

//                 if (snapshot.hasData) {
//                   final halls = snapshot.data!.data;
//                   return ListView.builder(
//                     itemCount: halls?.length,
//                     itemBuilder: (context, index) {
//                       final hall = halls?[index];
//                       return buildHallCard(
//                           'lib/assets/sheraton-600x410_0.jpg', hall?.name);
//                     },
//                   );
//                 }

//                 // Show loading indicator while waiting for data
//                 return const Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildHallCard(String? imagePath, String? name) {
//     return Material(
//       color: Colors.transparent,
//       elevation: 100,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Container(
//         width: double.infinity,
//         height: 130,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: AssetImage(imagePath!),
//           ),
//           boxShadow: const [
//             BoxShadow(
//               blurRadius: 80,
//               color: Color(0x33000000),
//               offset: Offset(0, 2),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.indigo[900]!,
//             width: 10,
//           ),
//         ),
//         child: Align(
//           alignment: const AlignmentDirectional(-1, 1),
//           child: buildnameBanner(name!),
//         ),
//       ),
//     );
//   }

//   Widget buildnameBanner(String name) {
//     return Material(
//       color: Colors.transparent,
//       elevation: 3,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(16),
//           bottomRight: Radius.circular(0),
//           topLeft: Radius.circular(0),
//           topRight: Radius.circular(26),
//         ),
//       ),
//       child: Container(
//         width: 250,
//         height: 40,
//         decoration: BoxDecoration(
//           color: Colors.indigo[900],
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(0),
//             topLeft: Radius.circular(0),
//             topRight: Radius.circular(26),
//           ),
//           border: Border.all(
//             color: Colors.indigo[900]!,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             name,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




















// Widget buildBody() {
  //   return GestureDetector(
  //     onTap: () => FocusScope.of(context).unfocus(),
  //     child: Stack(
  //       // Use Stack to layer widgets
  //       children: [
  //         Container(
  //           width: double.infinity,
  //           height: double.infinity,
  //           decoration: const BoxDecoration(
  //             image: DecorationImage(
  //               fit: BoxFit.cover,
  //               image: AssetImage(
  //                   'lib/assets/a4dad8b9-ae37-441e-8877-335a81e4bce7.jpg'),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: ListView.builder(
  //             // Use ListView.builder
  //             itemCount: 2, // Replace with actual data length later
  //             itemBuilder: (context, index) {
  //               var hallData = {
  //                 // Replace with actual data structure
  //                 'imagePath': 'lib/assets/sheraton-600x410_0.jpg',
  //                 'name': 'Sheraton Hall',
  //               };
  //               return buildHallCard(hallData['imagePath'], hallData['name']);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }