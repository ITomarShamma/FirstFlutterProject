import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pro2/DrawerPages/aboutUsPage.dart';
import 'package:pro2/DrawerPages/contactUsPage.dart';
import 'package:pro2/DrawerPages/myWalletPage.dart';
import 'package:pro2/DrawerPages/profilePage.dart';
import 'package:pro2/DrawerPages/settingsPage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/provincesPage.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageSaraWidget extends StatefulWidget {
  const HomePageSaraWidget({super.key});

  @override
  State<HomePageSaraWidget> createState() => _HomePageSaraWidgetState();
}

class _HomePageSaraWidgetState extends State<HomePageSaraWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final apiModel = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    apiModel.fetchEventTypes(); // Fetch event types with token
    apiModel.fetchProfile(); // Fetch profile data
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: ColorManager.primaryColor4,
          drawer: Drawer(
            elevation: 16,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.primaryColor5,
                    ColorManager.primaryColor
                  ],
                  stops: [0, 1],
                  begin: AlignmentDirectional(1, 0),
                  end: AlignmentDirectional(-1, 0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 310,
                    height: 175,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.primaryColor3,
                          ColorManager.primaryColor,
                          ColorManager.primaryColor4,
                          ColorManager.primaryColor6
                        ],
                        stops: [0, 1, 1, 1],
                        begin: AlignmentDirectional(1, -1),
                        end: AlignmentDirectional(-1, 1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 66, 0, 0),
                          child: Text(
                            model.profileData?.fullName ?? 'hello',
                            style: const TextStyle(
                              color: ColorManager.primaryColor8,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          model.profileData?.email ?? 'example@gmail.com',
                          style: const TextStyle(
                            color: ColorManager.primaryColor8,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildDrawerItem(
                    'profile',
                    Icons.person,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfilePage(token: model.token!),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    'about_us',
                    Icons.groups,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUsPage(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    'wallet_activities',
                    Icons.wallet,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyWalletHistoryPage(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    'contact_us',
                    Icons.phone,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsPage(),
                        ),
                      );
                    },
                  ),
                  buildDrawerItem(
                    'settings',
                    Icons.settings,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            automaticallyImplyLeading: false,
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => scaffoldKey.currentState?.openDrawer(),
              child: Icon(
                Icons.dehaze,
                color: ColorManager.primaryColor8,
                size: 32,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(58.0, 0, 0, 0),
              child: Text(
                'HomePage',
                style: TextStyle(
                  fontFamily: 'Merriweather',
                  color: ColorManager.primaryColor8,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('lib/assets/InsaventLogo.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 2,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.primaryColor3,
                  ColorManager.primaryColor5,
                  ColorManager.primaryColor5,
                  ColorManager.primaryColor7,
                ],
                stops: [0, 1, 0, 0],
                begin: AlignmentDirectional(1, 0),
                end: AlignmentDirectional(-1, 0),
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                buildEventType(),
                const SizedBox(height: 40),
                Expanded(
                  child: model.isLoadingEventTypes
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: model.eventTypes.length,
                          itemBuilder: (context, index) {
                            final eventType = model.eventTypes[index];
                            final imagePath =
                                getEventTypeImage(eventType.typeEvent!);

                            return buildCategory(
                              context,
                              eventType.typeEvent!,
                              imagePath,
                              () {
                                if (eventType.typeEvent! == 'Birthdays' ||
                                    eventType.typeEvent! == 'Graduation') {
                                  // Show Coming Soon Message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${eventType.typeEvent!} is coming soon!',
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                    ),
                                  );
                                } else {
                                  model.setTypeEventId(eventType.id!);
                                  model.setSelectedEventType(
                                      eventType.typeEvent!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Provinces(
                                        typeEventId: eventType.id!,
                                        token: model.token!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              eventType.typeEvent! == 'Birthdays' ||
                                  eventType.typeEvent! == 'Graduation',
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 310,
        height: 70,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor3,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text(
                title,
                style: const TextStyle(
                  color: ColorManager.primaryColor8,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Icon(
                icon,
                color: ColorManager.primaryColor8,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventType() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(52, 16, 52, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorManager.primaryColor4,
              ColorManager.primaryColor2,
              ColorManager.primaryColor6,
              ColorManager.primaryColor8,
            ],
            stops: [0, 1, 1, 1],
            begin: AlignmentDirectional(1, -1),
            end: AlignmentDirectional(-1, 1),
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 3,
          ),
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'EventType :',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'Merriweather',
              color: ColorManager.primaryColor8,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategory(
    BuildContext context,
    String title,
    String imagePath,
    VoidCallback onTap,
    bool isComingSoon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.black, width: 3, style: BorderStyle.solid),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (isComingSoon)
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black54,
                ),
                child: Center(
                  child: Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String getEventTypeImage(String eventType) {
    switch (eventType) {
      case 'Wedding & Engagement':
        return 'lib/assets/EventType/Wedding&Engagement2.jpg';
      case 'Graduation':
        return 'lib/assets/EventType/Graduation2.jpg';
      case 'Birthdays':
        return 'lib/assets/EventType/Birthday6.jpg';
      case 'PrivateEvents':
        return 'lib/assets/EventType/PublicEvent6.jpg';
      default:
        return 'lib/assets/EventType/Wedding&Engagement2.jpg';
    }
  }
}



























// class HomePageSaraWidget extends StatefulWidget {
//   const HomePageSaraWidget({super.key});

//   @override
//   State<HomePageSaraWidget> createState() => _HomePageSaraWidgetState();
// }

// class _HomePageSaraWidgetState extends State<HomePageSaraWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     final apiModel = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     apiModel.fetchEventTypes(); // Fetch event types with token
//     apiModel.fetchProfile(); // Fetch profile data
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: ColorManager.primaryColor4,
//           drawer: Drawer(
//             elevation: 16,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     ColorManager.primaryColor5,
//                     ColorManager.primaryColor
//                   ],
//                   stops: [0, 1],
//                   begin: AlignmentDirectional(1, 0),
//                   end: AlignmentDirectional(-1, 0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 310,
//                     height: 175,
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           ColorManager.primaryColor3,
//                           ColorManager.primaryColor,
//                           ColorManager.primaryColor4,
//                           ColorManager.primaryColor6
//                         ],
//                         stops: [0, 1, 1, 1],
//                         begin: AlignmentDirectional(1, -1),
//                         end: AlignmentDirectional(-1, 1),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 66, 0, 0),
//                           child: Text(
//                             model.profileData?.fullName ?? 'hello',
//                             style: const TextStyle(
//                               color: ColorManager.primaryColor8,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           model.profileData?.email ?? 'example@gmail.com',
//                           style: const TextStyle(
//                             color: ColorManager.primaryColor8,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buildDrawerItem(
//                     'profile',
//                     Icons.person,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ProfilePage(token: model.token!),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'about_us',
//                     Icons.groups,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AboutUsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'wallet_activities',
//                     Icons.wallet,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MyWalletHistoryPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'contact_us',
//                     Icons.phone,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ContactUsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'settings',
//                     Icons.settings,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SettingsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             automaticallyImplyLeading: false,
//             leading: InkWell(
//               splashColor: Colors.transparent,
//               focusColor: Colors.transparent,
//               hoverColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onTap: () => scaffoldKey.currentState?.openDrawer(),
//               child: Icon(
//                 Icons.dehaze,
//                 color: ColorManager.primaryColor8,
//                 size: 32,
//               ),
//             ),
//             title: Padding(
//               padding: const EdgeInsets.fromLTRB(58.0, 0, 0, 0),
//               child: Text(
//                 'HomePage',
//                 style: TextStyle(
//                   fontFamily: 'Merriweather',
//                   color: ColorManager.primaryColor8,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             actions: [
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('lib/assets/InsaventLogo.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             centerTitle: false,
//             elevation: 2,
//           ),
//           body: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   ColorManager.primaryColor3,
//                   ColorManager.primaryColor5,
//                   ColorManager.primaryColor5,
//                   ColorManager.primaryColor7,
//                 ],
//                 stops: [0, 1, 0, 0],
//                 begin: AlignmentDirectional(1, 0),
//                 end: AlignmentDirectional(-1, 0),
//               ),
//             ),
//             width: double.infinity,
//             height: double.infinity,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 buildEventType(),
//                 const SizedBox(height: 40),
//                 Expanded(
//                   child: model.isLoadingEventTypes
//                       ? const Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           padding: EdgeInsets.zero,
//                           itemCount: model.eventTypes.length,
//                           itemBuilder: (context, index) {
//                             final eventType = model.eventTypes[index];
//                             final imagePath =
//                                 getEventTypeImage(eventType.typeEvent!);

//                             return buildCategory(
//                               context,
//                               eventType.typeEvent!,
//                               imagePath,
//                               () {
//                                 model.setTypeEventId(eventType.id!);
//                                 model
//                                     .setSelectedEventType(eventType.typeEvent!);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Provinces(
//                                       typeEventId: eventType.id!,
//                                       token: model.token!,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 310,
//         height: 70,
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor3,
//           border: Border.all(
//               color: Colors.black, width: 1, style: BorderStyle.solid),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: ColorManager.primaryColor8,
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
//               child: Icon(
//                 icon,
//                 color: ColorManager.primaryColor8,
//                 size: 28,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildEventType() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(52, 16, 52, 0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               ColorManager.primaryColor4,
//               ColorManager.primaryColor2,
//               ColorManager.primaryColor6,
//               ColorManager.primaryColor8,
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             width: 3,
//           ),
//         ),
//         child: const Align(
//           alignment: Alignment.center,
//           child: Text(
//             'EventType :',
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: ColorManager.primaryColor8,
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory(
//     BuildContext context,
//     String title,
//     String imagePath,
//     VoidCallback onTap,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//                 color: Colors.black, width: 3, style: BorderStyle.solid),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String getEventTypeImage(String eventType) {
//     switch (eventType) {
//       case 'Wedding & Engagement':
//         return 'lib/assets/EventType/Wedding&Engagement2.jpg';
//       case 'Graduation':
//         return 'lib/assets/EventType/Graduation2.jpg';
//       case 'Birthdays':
//         return 'lib/assets/EventType/Birthday6.jpg';
//       case 'PrivateEvents':
//         return 'lib/assets/EventType/PublicEvent6.jpg';
//       default:
//         return 'lib/assets/EventType/Wedding&Engagement2.jpg';
//     }
//   }
// }
























































// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:pro2/DrawerPages/aboutUsPage.dart';
// import 'package:pro2/DrawerPages/contactUsPage.dart';
// import 'package:pro2/DrawerPages/profilePage.dart';
// import 'package:pro2/DrawerPages/settingsPage.dart';
// import 'package:pro2/global/color.dart';
// import 'package:pro2/global/localizationModel.dart';
// import 'package:pro2/global/navBar.dart';
// import 'package:pro2/models/homePageModel.dart';
// import 'package:pro2/provincesPage.dart';
// import 'package:pro2/services/apiModel.dart';
// import 'package:scoped_model/scoped_model.dart';

// // import 'profile_page.dart'; // Import the ProfilePage
// // import 'about_us_page.dart'; // Import the AboutUsPage
// // import 'contact_us_page.dart'; // Import the ContactUsPage
// // import 'settings_page.dart'; // Import the SettingsPage
// // import 'localization_model.dart'; // Import the LocalizationModel

// class HomePageSaraWidget extends StatefulWidget {
//   const HomePageSaraWidget({super.key});

//   @override
//   State<HomePageSaraWidget> createState() => _HomePageSaraWidgetState();
// }

// class _HomePageSaraWidgetState extends State<HomePageSaraWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     final apiModel = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     apiModel.fetchEventTypes(); // Fetch event types with token
//     apiModel.fetchProfile(); // Fetch profile data
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: ColorManager.primaryColor4,
//           drawer: Drawer(
//             elevation: 16,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     ColorManager.primaryColor5,
//                     ColorManager.primaryColor
//                   ],
//                   stops: [0, 1],
//                   begin: AlignmentDirectional(1, 0),
//                   end: AlignmentDirectional(-1, 0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 310,
//                     height: 175,
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           ColorManager.primaryColor3,
//                           ColorManager.primaryColor,
//                           ColorManager.primaryColor4,
//                           ColorManager.primaryColor6
//                         ],
//                         stops: [0, 1, 1, 1],
//                         begin: AlignmentDirectional(1, -1),
//                         end: AlignmentDirectional(-1, 1),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 66, 0, 0),
//                           child: Text(
//                             model.profileData?.fullName ?? 'hello',
//                             // localizationModel.translate('hello'),
//                             style: const TextStyle(
//                               color: ColorManager.primaryColor8,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           model.profileData?.email ?? 'example@gmail.com',
//                           style: const TextStyle(
//                             color: ColorManager.primaryColor8,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buildDrawerItem(
//                     'profile',
//                     // localizationModel.translate('profile'),
//                     Icons.person,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ProfilePage(token: model.token!),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'about_us',
//                     // localizationModel.translate('about_us'),
//                     Icons.groups,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AboutUsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'wallet_activities',
//                     //localizationModel.translate('wallet_activities'),
//                     Icons.wallet,
//                     () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => Provinces(),
//                       //   ),
//                       // );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'contact_us',
//                     // localizationModel.translate('contact_us'),
//                     Icons.phone,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ContactUsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'settings',
//                     //localizationModel.translate('settings'),
//                     Icons.settings,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SettingsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             automaticallyImplyLeading: false,
//             leading: InkWell(
//               splashColor: Colors.transparent,
//               focusColor: Colors.transparent,
//               hoverColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onTap: () => scaffoldKey.currentState?.openDrawer(),
//               child: Icon(
//                 Icons.dehaze,
//                 color: ColorManager.primaryColor8,
//                 size: 32,
//               ),
//             ),
//             title: Padding(
//               padding: const EdgeInsets.fromLTRB(58.0, 0, 0, 0),
//               child: Text(
//                 'HomePage',
//                 style: TextStyle(
//                   fontFamily: 'Merriweather',
//                   color: ColorManager.primaryColor8,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             actions: [
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('lib/assets/InsaventLogo.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             centerTitle: false,
//             elevation: 2,
//           ),
//           body: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   ColorManager.primaryColor3,
//                   ColorManager.primaryColor5,
//                   ColorManager.primaryColor5,
//                   ColorManager.primaryColor7,
//                 ],
//                 stops: [0, 1, 0, 0],
//                 begin: AlignmentDirectional(1, 0),
//                 end: AlignmentDirectional(-1, 0),
//               ),
//             ),
//             width: double.infinity,
//             height: double.infinity,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 buildEventType(),
//                 const SizedBox(height: 40),
//                 Expanded(
//                   child: model.isLoadingEventTypes
//                       ? const Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           padding: EdgeInsets.zero,
//                           itemCount: model.eventTypes.length,
//                           itemBuilder: (context, index) {
//                             final eventType = model.eventTypes[index];
//                             return buildCategory(
//                               context,
//                               eventType.typeEvent!,
//                               //lib/assets/EventType/Wedding&Engagement2.jpg for the first event
//                               //lib/assets/EventType/Graduation2.jpg   for the second event
//                               //lib/assets/EventType/Birthday1.jpg for the third event
//                               //lib/assets/EventType/Birthday3.jpg for the fourth event
//                               'lib/assets/EventType/Wedding&Engagement2.jpg',
//                               () {
//                                 model.setTypeEventId(eventType.id!);
//                                 model
//                                     .setSelectedEventType(eventType.typeEvent!);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Provinces(
//                                       typeEventId: eventType.id!,
//                                       token: model.token!,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//           //bottomNavigationBar: Navbar(),
//         ),
//       );
//     });
//   }

//   Widget buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 310,
//         height: 70,
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor3,
//           border: Border.all(
//               color: Colors.black, width: 1, style: BorderStyle.solid),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: ColorManager.primaryColor8,
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
//               child: Icon(
//                 icon,
//                 color: ColorManager.primaryColor8,
//                 size: 28,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildEventType() {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(52, 16, 52, 0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               ColorManager.primaryColor4,
//               ColorManager.primaryColor2,
//               ColorManager.primaryColor6,
//               ColorManager.primaryColor8,
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             width: 3,
//           ),
//         ),
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             'EventType :',
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory(
//     BuildContext context,
//     String title,
//     String imagePath,
//     VoidCallback onTap,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//                 color: Colors.black, width: 3, style: BorderStyle.solid),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








































// class HomePageSaraWidget extends StatefulWidget {
//   const HomePageSaraWidget({super.key});

//   @override
//   State<HomePageSaraWidget> createState() => _HomePageSaraWidgetState();
// }

// class _HomePageSaraWidgetState extends State<HomePageSaraWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     final apiModel = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     apiModel.fetchEventTypes(apiModel.token); // Fetch event types with token
//     apiModel.fetchProfile(apiModel.token!); // Fetch profile data
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           key: scaffoldKey,
//           backgroundColor: ColorManager.primaryColor4,
//           drawer: Drawer(
//             elevation: 16,
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     ColorManager.primaryColor5,
//                     ColorManager.primaryColor
//                   ],
//                   stops: [0, 1],
//                   begin: AlignmentDirectional(1, 0),
//                   end: AlignmentDirectional(-1, 0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 310,
//                     height: 175,
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           ColorManager.primaryColor3,
//                           ColorManager.primaryColor,
//                           ColorManager.primaryColor4,
//                           ColorManager.primaryColor6
//                         ],
//                         stops: [0, 1, 1, 1],
//                         begin: AlignmentDirectional(1, -1),
//                         end: AlignmentDirectional(-1, 1),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 66, 0, 0),
//                           child: Text(
//                             model.profileData?.fullName ?? 'FullName',
//                             style: const TextStyle(
//                               color: ColorManager.primaryColor8,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           model.profileData?.email ?? 'example@gmail.com',
//                           style: const TextStyle(
//                             color: ColorManager.primaryColor8,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   buildDrawerItem(
//                     'Profile',
//                     Icons.person,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ProfilePage(token: model.token!),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'Wallet&Activities',
//                     Icons.wallet,
//                     () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => Provinces(),
//                       //   ),
//                       // );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'About Us',
//                     Icons.groups,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AboutUsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'Contact Us',
//                     Icons.phone,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ContactUsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   buildDrawerItem(
//                     'UI Settings',
//                     Icons.settings,
//                     () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SettingsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             automaticallyImplyLeading: false,
//             leading: InkWell(
//               splashColor: Colors.transparent,
//               focusColor: Colors.transparent,
//               hoverColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onTap: () => scaffoldKey.currentState?.openDrawer(),
//               child: Icon(
//                 Icons.dehaze,
//                 color: ColorManager.primaryColor8,
//                 size: 32,
//               ),
//             ),
//             title: Padding(
//               padding: const EdgeInsets.fromLTRB(58.0, 0, 0, 0),
//               child: Text(
//                 'HomePage',
//                 style: TextStyle(
//                   fontFamily: 'Merriweather',
//                   color: ColorManager.primaryColor8,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             actions: [
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('lib/assets/InsaventLogo.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             centerTitle: false,
//             elevation: 2,
//           ),
//           body: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   ColorManager.primaryColor3,
//                   ColorManager.primaryColor5,
//                   ColorManager.primaryColor5,
//                   ColorManager.primaryColor7,
//                 ],
//                 stops: [0, 1, 0, 0],
//                 begin: AlignmentDirectional(1, 0),
//                 end: AlignmentDirectional(-1, 0),
//               ),
//             ),
//             width: double.infinity,
//             height: double.infinity,
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 buildEventType(),
//                 SizedBox(height: 40),
//                 Expanded(
//                   child: model.isLoadingEventTypes
//                       ? const Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           padding: EdgeInsets.zero,
//                           itemCount: model.eventTypes.length,
//                           itemBuilder: (context, index) {
//                             final eventType = model.eventTypes[index];
//                             return buildCategory(
//                               context,
//                               eventType.typeEvent!,
//                               'lib/assets/7b5up0ry.png',
//                               () {
//                                 model.setTypeEventId(eventType.id!);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Provinces(
//                                       typeEventId: eventType.id!,
//                                       token: model.token!,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 310,
//         height: 70,
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor3,
//           border: Border.all(
//               color: Colors.black, width: 1, style: BorderStyle.solid),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: ColorManager.primaryColor8,
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
//               child: Icon(
//                 icon,
//                 color: ColorManager.primaryColor8,
//                 size: 28,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildEventType() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(52, 16, 52, 0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               ColorManager.primaryColor4,
//               ColorManager.primaryColor2,
//               ColorManager.primaryColor6,
//               ColorManager.primaryColor8,
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             width: 3,
//           ),
//         ),
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             'EventType :',
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory(
//     BuildContext context,
//     String title,
//     String imagePath,
//     VoidCallback onTap,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//                 color: Colors.black, width: 3, style: BorderStyle.solid),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

















































//           body: Container(
  //             child: apiModel.isLoadingEventTypes!
  //                 ? const Center(child: CircularProgressIndicator())
  //                 : ListView(
  //                     padding: EdgeInsets.zero,
  //                     children: [
  //                       Column(
  //                         children: [
  //                           // buildCarouselSlider(),
  //                           buildEventType(),
  //                           ...apiModel.eventTypes.map((eventType) {
  //                             return buildCategory(
  //                               eventType.id!,
  //                               context,
  //                               eventType.typeEvent!,
  //                               'lib/assets/7b5up0ry.png',
  //                               () async {
  //                                 apiModel.setTypeEventId(eventType.id!);

  //                                 await Navigator.pushNamed(
  //                                   context,
  //                                   '/provinces',
  //                                 );
  //                               },
  //                             );
  //                           }).toList(),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //           ),
  //         ));
  //   });
  // }









// Widget buildCarouselSlider() {
//   return Padding(
//     padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
//     child: Container(
//       width: double.infinity,
//       height: 220,
//       child: CarouselSlider(
//         items: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               'https://picsum.photos/seed/432/600',
//               width: 300,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Stack(
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(24),
//                   child: Image.network(
//                     'https://picsum.photos/seed/981/600',
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               'https://picsum.photos/seed/452/600',
//               width: 300,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               'https://picsum.photos/seed/763/600',
//               width: 300,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//         //carouselController: apiModel.carouselController,
//         options: CarouselOptions(
//           initialPage: 1,
//           viewportFraction: 0.8,
//           disableCenter: true,
//           enlargeCenterPage: true,
//           enlargeFactor: 0.25,
//           enableInfiniteScroll: true,
//           scrollDirection: Axis.horizontal,
//           autoPlay: true,
//           autoPlayAnimationDuration: Duration(milliseconds: 800),
//           autoPlayInterval: Duration(milliseconds: (800 + 4000)),
//           autoPlayCurve: Curves.linear,
//           pauseAutoPlayInFiniteScroll: true,
//           //onPageChanged: (index, _) => apiModel.carouselCurrentIndex = index,
//         ),
//       ),
//     ),
//   );
// }




































// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:pro2/models/homePageModel.dart';
// import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';
// //import 'homePageModel.dart';

// class HomePageSaraWidget extends StatefulWidget {
//   const HomePageSaraWidget({super.key});

//   @override
//   State<HomePageSaraWidget> createState() => _HomePageSaraWidgetState();
// }

// class _HomePageSaraWidgetState extends State<HomePageSaraWidget> {
//   late HomePageSaraModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = ScopedModel.of<HomePageSaraModel>(context, rebuildOnChange: false);
//     _model.fetchEventTypes(_model.token); // Fetch event types with token
//   }

//   @override
//   void dispose() {
//     _model.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.blueAccent,
//         drawer: Drawer(
//           elevation: 16,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blueAccent, Colors.purpleAccent],
//                 stops: [0, 1],
//                 begin: AlignmentDirectional(1, 0),
//                 end: AlignmentDirectional(-1, 0),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: 310,
//                   height: 175,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.deepPurple,
//                         Colors.indigo,
//                         Colors.deepPurple,
//                         Colors.deepPurple
//                       ],
//                       stops: [0, 1, 1, 1],
//                       begin: AlignmentDirectional(1, -1),
//                       end: AlignmentDirectional(-1, 1),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                         child: Container(
//                           width: 80,
//                           height: 80,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: Image.network(
//                             'https://picsum.photos/seed/376/600',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
//                         child: Text(
//                           'Hello World',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'example@gmail.com',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 buildDrawerItem('Wallet&Activities', Icons.wallet),
//                 buildDrawerItem('About Us', Icons.groups),
//                 buildDrawerItem('Contact Us', Icons.phone),
//                 buildDrawerItem('Settings', Icons.settings),
//               ],
//             ),
//           ),
//         ),
//         appBar: AppBar(
//           backgroundColor: Colors.deepPurple,
//           automaticallyImplyLeading: false,
//           leading: InkWell(
//             splashColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () => scaffoldKey.currentState?.openDrawer(),
//             child: Icon(
//               Icons.dehaze,
//               color: Colors.purple[100],
//               size: 24,
//             ),
//           ),
//           title: Text(
//             'Home page',
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           actions: [
//             Align(
//               alignment: AlignmentDirectional(0, 0),
//               child: Container(
//                 width: 120,
//                 height: 120,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.asset(
//                   'assets/images/Instavent.png-removebg-preview_(1).png',
//                   fit: BoxFit.cover,
//                   alignment: Alignment(0, 0),
//                 ),
//               ),
//             ),
//           ],
//           centerTitle: false,
//           elevation: 2,
//         ),
//         body: Container(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               Column(
//                 children: [
//                   buildCarouselSlider(),
//                   buildEventType(),
//                   buildCategory(
//                     context,
//                     'Wedding',
//                     'assets/images/wedding.jpg',
//                     () {
//                       Navigator.pushNamed(context, '/wedding');
//                     },
//                   ),
//                   buildCategory(
//                     context,
//                     'Birthday',
//                     'assets/images/birthday.jpg',
//                     () {
//                       Navigator.pushNamed(context, '/birthday');
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildDrawerItem(String title, IconData icon) {
//     return Container(
//       width: 310,
//       height: 70,
//       decoration: BoxDecoration(
//         color: Colors.indigo,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontFamily: 'Roboto',
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
//             child: Icon(
//               icon,
//               color: Colors.white,
//               size: 28,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCarouselSlider() {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
//       child: Container(
//         width: double.infinity,
//         height: 220,
//         child: CarouselSlider(
//           items: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 'https://picsum.photos/seed/432/600',
//                 width: 300,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Stack(
//               children: [
//                 Align(
//                   alignment: AlignmentDirectional(0, 0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(24),
//                     child: Image.network(
//                       'https://picsum.photos/seed/981/600',
//                       width: double.infinity,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 'https://picsum.photos/seed/452/600',
//                 width: 300,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 'https://picsum.photos/seed/763/600',
//                 width: 300,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ],
//           carouselController: _model.carouselController ??= CarouselController(),
//           options: CarouselOptions(
//             initialPage: 1,
//             viewportFraction: 0.8,
//             disableCenter: true,
//             enlargeCenterPage: true,
//             enlargeFactor: 0.25,
//             enableInfiniteScroll: true,
//             scrollDirection: Axis.horizontal,
//             autoPlay: true,
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             autoPlayInterval: Duration(milliseconds: 4800),
//             autoPlayCurve: Curves.linear,
//             pauseAutoPlayInFiniteScroll: true,
//             onPageChanged: (index, _) => setState(() {
//               _model.carouselCurrentIndex = index;
//             }),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildEventType() {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(16, 16, 150, 16),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.deepPurple,
//               Colors.indigo,
//               Colors.purpleAccent,
//               Colors.purple,
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(width: 3),
//         ),
//         child: Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Text(
//             'EventType :',
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontFamily: 'Merriweather',
//               color: Colors.purple[100],
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory(BuildContext context, String title, String imagePath, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }