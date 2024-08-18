import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro2/DrawerPages/myWalletPage.dart';
import 'package:pro2/DrawerPages/profilePage.dart';
import 'package:pro2/DrawerPages/settingsPage.dart';
import 'package:pro2/areaPage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/global/navigationModel.dart';
import 'package:pro2/homePagev.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro2/global/color.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    //HomePageSaraWidget(),
    MyWalletHistoryPage(),
    SettingsPage(),
    ProfilePage(
      token: ApiModel().token,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: ColorManager.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: ColorManager.primaryColor,
            activeColor: ColorManager.primaryColor8,
            color: ColorManager.primaryColor8,
            tabBackgroundColor: Colors.purpleAccent.withAlpha(100),
            gap: 8,
            padding: EdgeInsets.all(8),
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            tabs: const [
              // GButton(
              //   icon: Icons.home,
              //   text: 'home',
              // ),
              GButton(
                icon: Icons.wallet,
                text: 'MyWallet',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:pro2/global/color.dart';

// class Navbar extends StatelessWidget {
//   const Navbar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: ColorManager.primaryColor,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//         child: GNav(
//           backgroundColor: ColorManager.primaryColor,
//           activeColor: ColorManager.primaryColor8,
//           color: ColorManager.primaryColor8,
//           tabBackgroundColor: Colors.purpleAccent.withAlpha(100),
//           gap: 8,
//           padding: EdgeInsets.all(8),
//           tabs: const [
//             GButton(
//               icon: Icons.home,
//               text: 'home',
//             ),
//             GButton(
//               icon: Icons.wallet,
//               text: 'MyWallet',
//             ),
//             GButton(
//               icon: Icons.settings,
//               text: 'Settings',
//             ),
//             GButton(
//               icon: Icons.person,
//               text: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
