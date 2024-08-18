import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/page1.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Budget extends StatefulWidget {
  final int areaId;
  final int townId;
  final int typeEventId;
  final String token;

  const Budget({
    super.key,
    required this.areaId,
    required this.townId,
    required this.typeEventId,
    required this.token,
  });

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  bool first = false;
  bool second = false;
  bool third = false;

  @override
  void initState() {
    super.initState();
    // No need to fetch budgets from API
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ColorManager.primaryColor7,
              ),
            ),
            title: const Text(
              "Choose Your Budget",
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
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                    'lib/assets/d7546283-541f-4b9b-a9f9-71f5da6d6cfb.jpg'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "What is your budget?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primaryColor8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildBudgetOption("Premium", 1, model),
                  const SizedBox(height: 20),
                  buildBudgetOption("Moderate", 2, model),
                  const SizedBox(height: 20),
                  buildBudgetOption("Economical", 3, model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBudgetOption(String label, int id, ApiModel model) {
    bool isSelected =
        (id == 1 && first) || (id == 2 && second) || (id == 3 && third);

    Color getCardColor(String label) {
      switch (label) {
        case "Moderate":
          return ColorManager.primaryColor5;
        case "Economical":
          return ColorManager.primaryColor2;
        case "Premium":
          return ColorManager.primaryColor3;
        default:
          return ColorManager.primaryColor8;
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          first = id == 1;
          second = id == 2;
          third = id == 3;
          model.setBudgetId(id);
          model.setSelectedBudgetName(label);
        });
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                WeddingHallOmarWidget(
              areaId: widget.areaId,
              townId: widget.townId,
              typeEventId: widget.typeEventId,
              budgetId: id,
              token: widget.token,
            ),
          ),
        );
      },
      child: Card(
        color: getCardColor(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: isSelected ? 8.0 : 2.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}






























// class Budget extends StatefulWidget {
//   final int areaId;
//   final int townId;
//   final int typeEventId;
//   final String token;

//   const Budget({
//     super.key,
//     required this.areaId,
//     required this.townId,
//     required this.typeEventId,
//     required this.token,
//   });

//   @override
//   State<Budget> createState() => _BudgetState();
// }

// class _BudgetState extends State<Budget> {
//   bool first = false;
//   bool second = false;
//   bool third = false;
//   var clip = new DiagonalClipper();

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchBudgets(
//         widget.typeEventId, widget.townId, widget.areaId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             leading: IconButton(
//               onPressed: () {
//                 //model.clearAreaId(); // Clear areaId
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: ColorManager.primaryColor7,
//               ),
//             ),
//             title: const Text(
//               "Choose Your Budget",
//               style: TextStyle(
//                 fontFamily: 'Outfit',
//                 color: ColorManager.primaryColor8,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 2,
//           ),
//           body: model.isLoadingBudgets!
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                     image: const DecorationImage(
//                       image: AssetImage(
//                           'lib/assets/d7546283-541f-4b9b-a9f9-71f5da6d6cfb.jpg'),
//                       fit: BoxFit.fill,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 70),
//                     child: Column(
//                       children: model.budgets.map((budget) {
//                         return buildBudgetOption(budget.budget!.classify!, () {
//                           setState(() {
//                             first = budget.id == 1;
//                             second = budget.id == 2;
//                             third = budget.id == 3;
//                             model.setBudgetId(budget.id!);
//                             model.setSelectedBudgetName(
//                                 budget.budget!.classify!);
//                           });
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => WeddingHallOmarWidget(
//                                 areaId: widget.areaId,
//                                 townId: widget.townId,
//                                 typeEventId: widget.typeEventId,
//                                 budgetId: budget.id!,
//                                 token: widget.token,
//                               ),
//                             ),
//                           );
//                         });
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//         );
//       },
//     );
//   }

//   Widget buildBudgetOption(String label, VoidCallback onTap) {
//     bool isSelected = (label == "Moderate" && first) ||
//         (label == "Economical" && second) ||
//         (label == "Premium" && third);

//     Color getCardColor(String label) {
//       switch (label) {
//         case "Moderate":
//           return ColorManager.primaryColor2;
//         case "Economical":
//           return ColorManager.primaryColor2;
//         case "Premium":
//           return ColorManager.primaryColor2;
//         default:
//           return ColorManager.primaryColor2;
//       }
//     }

//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         color: getCardColor(label),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//         elevation: isSelected ? 8.0 : 2.0,
//         child: Container(
//           width: 200,
//           height: 200,
//           alignment: Alignment.center,
//           child: Text(
//             label,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildBudgetOptions() {
//     List<Map<String, dynamic>> options = [
//       {"label": "Moderate", "onTap": () {}},
//       {"label": "Economical", "onTap": () {}},
//       {"label": "Premium", "onTap": () {}},
//     ];

//     return Column(
//       children: options.asMap().entries.map((entry) {
//         int idx = entry.key;
//         Map<String, dynamic> option = entry.value;

//         return Align(
//           alignment:
//               idx % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: buildBudgetOption(option['label'], option['onTap']),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // Widget buildBudgetOption(String label, VoidCallback onTap) {
//   //   bool isSelected = (label == "Moderate" && first) ||
//   //       (label == "Economical" && second) ||
//   //       (label == "Premium" && third);

//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.center,
//   //     children: [
//   //       GestureDetector(
//   //         onTap: onTap,
//   //         child: Container(
//   //           padding: const EdgeInsets.all(70),
//   //           decoration: BoxDecoration(
//   //             shape: BoxShape.circle,
//   //             color: isSelected
//   //                 ? ColorManager.primaryColor4
//   //                 : ColorManager.primaryColor3,
//   //             border: Border.all(
//   //               color: ColorManager.primaryColor,
//   //               width: 4,
//   //             ),
//   //           ),
//   //           child: Text(
//   //             label,
//   //             style: const TextStyle(
//   //               fontSize: 30,
//   //               fontWeight: FontWeight.bold,
//   //               color: ColorManager.primaryColor8,
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _ClipPath() {
//     return ClipPath(
//         clipper: DiagonalClipper(),
//         child: Card(
//           color: ColorManager.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           elevation: 5,
//           child: Container(
//             width: 300,
//             height: 600,
//             child: Center(
//               child: Text(
//                 'title',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ));
//   }
// }

// class DiagonalClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();

//     path.lineTo(0, size.height); // Start at bottom left
//     path.quadraticBezierTo(
//       size.width,
//       size.height,
//       size.width - size.width / 2,
//       size.height - size.height / 2,
//     );
//     // path.quadraticBezierTo(
//     //   3 / 4 * size.width,
//     //   size.height,
//     //   size.width,
//     //   size.height - 30,
//     // );
//     path.lineTo(size.width, 0); // Draw to top right

//     // path.lineTo(size.width, size.height); // Draw to bottom right
//     path.close(); // Complete the path
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

























// class Budget extends StatefulWidget {
//   final int areaId;
//   final int townId;
//   final int typeEventId;
//   final String token;

//   const Budget({
//     super.key,
//     required this.areaId,
//     required this.townId,
//     required this.typeEventId,
//     required this.token,
//   });

//   @override
//   State<Budget> createState() => _BudgetState();
// }

// class _BudgetState extends State<Budget> {
//   bool first = false;
//   bool second = false;
//   bool third = false;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchBudgets(
//         widget.typeEventId, widget.townId, widget.areaId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             leading: IconButton(
//               onPressed: () {
//                 model.clearAreaId(); // Clear areaId
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: ColorManager.primaryColor7,
//               ),
//             ),
//             title: const Text(
//               "Choose Your Budget",
//               style: TextStyle(fontSize: 30, color: ColorManager.primaryColor7),
//             ),
//           ),
//           body: model.isLoadingBudgets
//               ? const Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: BoxDecoration(
//                     image: const DecorationImage(
//                       image: AssetImage(
//                           'lib/assets/d7546283-541f-4b9b-a9f9-71f5da6d6cfb.jpg'),
//                       fit: BoxFit.fill,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 70),
//                     child: Column(
//                       children: model.budgets.map((budget) {
//                         return buildBudgetOption(budget.budget!.classify!, () {
//                           setState(() {
//                             first = budget.id == 1;
//                             second = budget.id == 2;
//                             third = budget.id == 3;
//                             model.setBudgetId(budget.id!);
//                           });
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => WeddingHallOmarWidget(
//                                 areaId: widget.areaId,
//                                 townId: widget.townId,
//                                 typeEventId: widget.typeEventId,
//                                 budgetId: budget.id!,
//                                 token: widget.token,
//                               ),
//                             ),
//                           );
//                         });
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//         );
//       },
//     );
//   }

//   Widget buildBudgetOption(String label, VoidCallback onTap) {
//     bool isSelected = (label == "Moderate" && first) ||
//         (label == "Economical" && second) ||
//         (label == "Premium" && third);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             padding: const EdgeInsets.all(70),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isSelected
//                   ? ColorManager.primaryColor4
//                   : ColorManager.primaryColor3,
//               border: Border.all(
//                 color: ColorManager.primaryColor,
//                 width: 4,
//               ),
//             ),
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: ColorManager.primaryColor8,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }















// class Budget extends StatefulWidget {
//   final int areaId;
//   final int townId;
//   final int typeEventId;
//   final String token;

//   const Budget({
//     super.key,
//     required this.areaId,
//     required this.townId,
//     required this.typeEventId,
//     required this.token,
//   });

//   @override
//   State<Budget> createState() => _BudgetState();
// }

// class _BudgetState extends State<Budget> {
//   bool first = false;
//   bool second = false;
//   bool third = false;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchBudgets(
//         widget.typeEventId, widget.townId, widget.areaId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             leading: IconButton(
//               onPressed: () {
//                 model.clearAreaId(); // Clear areaId
//                 Navigator.of(context).pop();
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: ColorManager.primaryColor7,
//               ),
//             ),
//             title: Text(
//               "Choose Your Budget",
//               style: TextStyle(fontSize: 30, color: ColorManager.primaryColor7),
//             ),
//           ),
//           body: model.isLoadingBudgets
//               ? Center(child: CircularProgressIndicator())
//               : Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           'lib/assets/d7546283-541f-4b9b-a9f9-71f5da6d6cfb.jpg'),
//                       fit: BoxFit.fill,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 70),
//                     child: Column(
//                       children: [
//                         buildBudgetOption("Moderate", first, () {
//                           setState(() {
//                             first = true;
//                             second = false;
//                             third = false;
//                           });
//                         }),
//                         SizedBox(height: 15),
//                         buildBudgetOption("Economical", second, () {
//                           setState(() {
//                             first = false;
//                             second = true;
//                             third = false;
//                           });
//                         }),
//                         SizedBox(height: 15),
//                         buildBudgetOption("Premium", third, () {
//                           setState(() {
//                             first = false;
//                             second = false;
//                             third = true;
//                           });
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),
//         );
//       },
//     );
//   }

//   Widget buildBudgetOption(String label, bool isSelected, VoidCallback onTap) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             padding: EdgeInsets.all(70),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isSelected
//                   ? ColorManager.primaryColor4
//                   : ColorManager.primaryColor3,
//               border: Border.all(
//                 color: ColorManager.primaryColor,
//                 width: 4,
//               ),
//             ),
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: ColorManager.primaryColor8,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
