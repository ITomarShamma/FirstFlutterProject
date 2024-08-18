import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';

import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

class MyWalletHistoryPage extends StatefulWidget {
  const MyWalletHistoryPage({super.key});

  @override
  State<MyWalletHistoryPage> createState() => _MyWalletHistoryPageState();
}

class _MyWalletHistoryPageState extends State<MyWalletHistoryPage> {
  final List<Map<String, dynamic>> eventHistory = [
    {
      'eventName': 'Wedding',
      'eventDate': DateTime(2023, 5, 20),
      'eventDetails': 'Wedding of John and Jane',
    },
    {
      'eventName': 'Birthday Party',
      'eventDate': DateTime(2023, 7, 15),
      'eventDetails': 'Birthday party for Jake',
    },
    {
      'eventName': 'Corporate Event',
      'eventDate': DateTime(2023, 8, 30),
      'eventDetails': 'Annual corporate event',
    },
  ];

  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchWallet();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: ColorManager.primaryColor6,
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            title: const Text(
              'My Wallet & History',
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
              icon: const Icon(Icons.arrow_back,
                  color: ColorManager.primaryColor8),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '   Balance      :   \$${model.wallet.toString()}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primaryColor8,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Event History:",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: eventHistory.isEmpty
                      ? const Text(
                          'No event history found.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      : ListView.builder(
                          itemCount: eventHistory.length,
                          itemBuilder: (context, index) {
                            final event = eventHistory[index];
                            return Card(
                              color: ColorManager.primaryColor2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(
                                  event['eventName'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  '${event['eventDate'].toLocal()}'
                                          .split(' ')[0] +
                                      '\n${event['eventDetails']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

























// class MyWalletHistoryPage extends StatefulWidget {
//   const MyWalletHistoryPage({super.key});

//   @override
//   State<MyWalletHistoryPage> createState() => _MyWalletHistoryPageState();
// }

// class _MyWalletHistoryPageState extends State<MyWalletHistoryPage> {
//   final List<Map<String, dynamic>> eventHistory = [
//     {
//       'eventName': 'Wedding',
//       'eventDate': DateTime(2023, 5, 20),
//       'eventDetails': 'Wedding of John and Jane',
//     },
//     {
//       'eventName': 'Birthday Party',
//       'eventDate': DateTime(2023, 7, 15),
//       'eventDetails': 'Birthday party for Jake',
//     },
//     {
//       'eventName': 'Corporate Event',
//       'eventDate': DateTime(2023, 8, 30),
//       'eventDetails': 'Annual corporate event',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchWallet();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           backgroundColor: ColorManager.primaryColor6,
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: const Text(
//               'My Wallet & History',
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
//               icon: const Icon(Icons.arrow_back,
//                   color: ColorManager.primaryColor8),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     '   Balance      :   \$${model.wallet?.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: ColorManager.primaryColor8,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Event History:",
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: ColorManager.primaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: eventHistory.isEmpty
//                       ? const Text(
//                           'No event history found.',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: eventHistory.length,
//                           itemBuilder: (context, index) {
//                             final event = eventHistory[index];
//                             return Card(
//                               color: ColorManager.primaryColor2,
//                               margin: const EdgeInsets.symmetric(vertical: 8),
//                               child: ListTile(
//                                 title: Text(
//                                   event['eventName'],
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   '${event['eventDate'].toLocal()}'
//                                           .split(' ')[0] +
//                                       '\n${event['eventDetails']}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
































// class MyWalletHistoryPage extends StatefulWidget {
//   const MyWalletHistoryPage({super.key});

//   @override
//   State<MyWalletHistoryPage> createState() => _MyWalletHistoryPageState();
// }

// class _MyWalletHistoryPageState extends State<MyWalletHistoryPage> {
//   final List<Map<String, dynamic>> eventHistory = [
//     {
//       'eventName': 'Wedding',
//       'eventDate': DateTime(2023, 5, 20),
//       'eventDetails': 'Wedding of John and Jane',
//     },
//     {
//       'eventName': 'Birthday Party',
//       'eventDate': DateTime(2023, 7, 15),
//       'eventDetails': 'Birthday party for Jake',
//     },
//     {
//       'eventName': 'Corporate Event',
//       'eventDate': DateTime(2023, 8, 30),
//       'eventDetails': 'Annual corporate event',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchWallet();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           backgroundColor: ColorManager.primaryColor6,
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: const Text(
//               'My Wallet & History',
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
//               icon: const Icon(Icons.arrow_back,
//                   color: ColorManager.primaryColor8),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     '   Balance      :   \$${model.wallet?.toStringAsFixed(2) ?? '0.00'}',
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: ColorManager.primaryColor8,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Event History:",
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: ColorManager.primaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: eventHistory.isEmpty
//                       ? const Text(
//                           'No event history found.',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: eventHistory.length,
//                           itemBuilder: (context, index) {
//                             final event = eventHistory[index];
//                             return Card(
//                               color: ColorManager.primaryColor2,
//                               margin: const EdgeInsets.symmetric(vertical: 8),
//                               child: ListTile(
//                                 title: Text(
//                                   event['eventName'],
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   '${event['eventDate'].toLocal()}'
//                                           .split(' ')[0] +
//                                       '\n${event['eventDetails']}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }













// class MyWalletHistoryPage extends StatefulWidget {
//   const MyWalletHistoryPage({super.key});

//   @override
//   State<MyWalletHistoryPage> createState() => _MyWalletHistoryPageState();
// }

// class _MyWalletHistoryPageState extends State<MyWalletHistoryPage> {
//   // Mock Data
//   final String walletValue = '\$1,000,000,000';
//   final List<Map<String, dynamic>> eventHistory = [
//     {
//       'eventName': 'Wedding',
//       'eventDate': DateTime(2023, 5, 20),
//       'eventDetails': 'Wedding of John and Jane',
//     },
//     {
//       'eventName': 'Birthday Party',
//       'eventDate': DateTime(2023, 7, 15),
//       'eventDetails': 'Birthday party for Jake',
//     },
//     {
//       'eventName': 'Corporate Event',
//       'eventDate': DateTime(2023, 8, 30),
//       'eventDetails': 'Annual corporate event',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.primaryColor6,
//       appBar: AppBar(
//         backgroundColor: ColorManager.primaryColor,
//         title: const Text(
//           'My Wallet & History',
//           style: TextStyle(
//             fontFamily: 'Outfit',
//             color: ColorManager.primaryColor8,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 2,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: ColorManager.primaryColor8),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 '   Balance      :   $walletValue',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: ColorManager.primaryColor8,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Event History:",
//               style: TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//                 color: ColorManager.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: eventHistory.isEmpty
//                   ? const Text(
//                       'No event history found.',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: eventHistory.length,
//                       itemBuilder: (context, index) {
//                         final event = eventHistory[index];
//                         return Card(
//                           color: ColorManager.primaryColor2,
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: ListTile(
//                             title: Text(
//                               event['eventName'],
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             subtitle: Text(
//                               '${event['eventDate'].toLocal()}'.split(' ')[0] +
//                                   '\n${event['eventDetails']}',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }































// import 'package:flutter/material.dart';
// import 'package:pro2/global/color.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:scoped_model/scoped_model.dart';

// class MyWalletHistoryPage extends StatefulWidget {
//   const MyWalletHistoryPage({super.key});

//   @override
//   State<MyWalletHistoryPage> createState() => _MyWalletHistoryPageState();
// }

// class _MyWalletHistoryPageState extends State<MyWalletHistoryPage> {
//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchWalletNumber();
//     model.fetchEventHistory();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: const Text(
//               'My Wallet & History',
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
//               icon: const Icon(Icons.arrow_back, color: ColorManager.primaryColor8),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: model.isLoadingWallet || model.isLoadingHistory
//               ? const Center(child: CircularProgressIndicator())
//               : Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.7),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           'Wallet Number: ${model.walletNumber}',
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         'Event History:',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: ColorManager.primaryColor8,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Expanded(
//                         child: model.eventHistory.isEmpty
//                             ? const Text(
//                                 'No event history found.',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : ListView.builder(
//                                 itemCount: model.eventHistory.length,
//                                 itemBuilder: (context, index) {
//                                   final event = model.eventHistory[index];
//                                   return Card(
//                                     color: ColorManager.primaryColor2,
//                                     margin: const EdgeInsets.symmetric(vertical: 8),
//                                     child: ListTile(
//                                       title: Text(
//                                         event.eventName,
//                                         style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       subtitle: Text(
//                                         '${event.eventDate.toLocal()}'.split(' ')[0] +
//                                             '\n${event.eventDetails}',
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.white70,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//         );
//       },
//     );
//   }
// }

