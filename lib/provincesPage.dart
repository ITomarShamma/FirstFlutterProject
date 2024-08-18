import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pro2/areaPage.dart';
import 'package:pro2/models/provinceModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';
import '../../../global/color.dart';

class Provinces extends StatefulWidget {
  final int typeEventId;
  final String token;

  const Provinces({super.key, required this.typeEventId, required this.token});

  @override
  _ProvincesState createState() => _ProvincesState();
}

class _ProvincesState extends State<Provinces> {
  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchTowns(widget.typeEventId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: ColorManager.primaryColor8,
                size: 30,
              ),
              onPressed: () {
                // model.clearTypeEventId(); // Clear typeEventId
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Choose Hall location',
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
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/2870be27-7a41-4de9-a575-1fba2cc28fd8.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: model.isLoadingTowns!
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: model.towns.length,
                      itemBuilder: (context, index) {
                        final town = model.towns[index];
                        return GestureDetector(
                          onTap: () async {
                            model.setTownId(town.id!); // Set the town_id
                            //model.clearAreas(); // Clear previous areas
                            model.setSelectedTownName(
                                town.town!.name!); // Set the
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AreaPage(
                                  townId: town.id!,
                                  typeEventId: widget.typeEventId,
                                  token: widget.token,
                                ),
                              ),
                            );
                          },

                          child: Card(
                            color: ColorManager.primaryColor2,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                        "lib/assets/Cities/${town.town!.name!}.png",
                                        // scale: 3,
                                        height: 160,
                                        width: 160,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        town.town!.name!,
                                        style: TextStyle(
                                          color: ColorManager.primaryColor8,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // child: Container(
                          //   height: 80,
                          //   margin: const EdgeInsets.only(bottom: 10),
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image: AssetImage(
                          //           'lib/assets/a4dad8b9-ae37-441e-8877-335a81e4bce7.jpg'),
                          //     ),
                          //     // gradient: const LinearGradient(
                          //     //   colors: [
                          //     //     ColorManager.primaryColor8,
                          //     //     ColorManager.primaryColor2,
                          //     //   ],
                          //     //   begin: Alignment.topRight,
                          //     //   end: Alignment.bottomLeft,
                          //     // ),
                          //     borderRadius: BorderRadius.circular(20),
                          //     border: Border.all(
                          //       color: ColorManager.primaryColor,
                          //       width: 5,
                          //     ),
                          //   ),
                          //   child: Center(
                          //     child: Text(
                          //       town.town!.name!,
                          //       style: TextStyle(
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

Widget _ItemListView() {
  return ListView.builder(
    itemCount: 3,
    itemBuilder: (context, index) {
      // final town = apiModel.towns[index];
      return Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'lib/assets/sheraton-600x410_0.jpg',
                  scale: 3,
                ),
                // child: Image.network(
                //   apiModel.towns[index].imageUrl,
                //   height: 100,
                //   width: 100,
                //   fit: BoxFit.cover,
                // ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  '111111111',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}




//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         model.fetchTowns(typeEventId, token);
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: const Center(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
//                 child: Text(
//                   'Choose Hall location',
//                   style: TextStyle(color: ColorManager.primaryColor8),
//                 ),
//               ),
//             ),
//             leading: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.purple[100],
//                   size: 30,
//                 ),
//                 onPressed: () async {
//                   model.clearAreas(); // Clear previous areas
//                   model.clearTypeEventId();
//                   Navigator.of(context).pop();
//                 }),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: model.towns.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: model.towns.length,
//                     itemBuilder: (context, index) {
//                       final town = model.towns[index].town;
//                       return GestureDetector(
//                         onTap: () async {
//                           await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AreaPage(
//                                 townId: town.id!,
//                                 typeEventId: typeEventId,
//                                 token: token,
//                               ),
//                             ),
//                           );
//                           model.clearTownId(); // Clear townId when returning
//                         },
//                         child: Container(
//                           height: 80,
//                           margin: const EdgeInsets.only(bottom: 10),
//                           decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               colors: [
//                                 ColorManager.primaryColor8,
//                                 ColorManager.primaryColor2,
//                               ],
//                               begin: Alignment.topRight,
//                               end: Alignment.bottomLeft,
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: ColorManager.primaryColor,
//                               width: 5,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               town!.name!,
//                               style: const TextStyle(
//                                 color: ColorManager.primaryColor,
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
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
// import 'package:pro2/areaPage.dart';

// import '../../../global/color.dart';

// class Provinces extends StatelessWidget {
//   const Provinces({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           title: const Padding(
//             padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
//             child: Center(
//               child: Text(
//                 'Choose Hall location',
//                 style: TextStyle(color: ColorManager.primaryColor8),
//               ),
//             ),
//           ),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.purple[100],
//               size: 30,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView.separated(
//               itemBuilder: (context, int) => GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Area()));
//                     },
//                     child: Container(
//                       height: 80,
//                       child: Center(
//                           child: Text(
//                         'Damascus',
//                         style: TextStyle(
//                             color: ColorManager.primaryColor,
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold),
//                       )),
//                       decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                               colors: [
//                                 ColorManager.primaryColor8,
//                                 ColorManager.primaryColor2,
//                               ],
//                               begin: Alignment.topRight,
//                               end: Alignment.bottomLeft),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: ColorManager.primaryColor, width: 5)),
//                     ),
//                   ),
//               separatorBuilder: (context, int) => const SizedBox(
//                     height: 10,
//                   ),
//               itemCount: 14),
//         ));
//   }
// }
