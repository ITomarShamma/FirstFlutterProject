import 'package:flutter/material.dart';
import 'package:pro2/decorationPage.dart';
import 'package:pro2/detailsPage.dart';
import 'package:pro2/foodPage.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/musicPage.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:scoped_model/scoped_model.dart';

class TabbedPageWidget extends StatefulWidget {
  final int placeId;
  final String token;

  const TabbedPageWidget({
    Key? key,
    required this.placeId,
    required this.token,
  }) : super(key: key);

  @override
  State<TabbedPageWidget> createState() => _TabbedPageWidgetState();
}

class _TabbedPageWidgetState extends State<TabbedPageWidget> {
  final PageController _pageController = PageController();

  void _navigateToPage(int pageIndex) {
    setState(() {
      if (pageIndex == 1) {}
    });
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        return Scaffold(
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
              'Services',
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
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ServicesMusicPageWidget(
                placeId: widget.placeId,
                token: widget.token,
                onNext: () => _navigateToPage(1),
              ),
              ServicesFoodPageWidget(
                placeId: widget.placeId,
                token: widget.token,
                onNext: () => _navigateToPage(2),
              ),
              ServicesDecorationPageWidget(
                placeId: widget.placeId,
                token: widget.token,
                onNext: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsPageWidget(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}














// class TabbedPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const TabbedPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//   }) : super(key: key);

//   @override
//   _TabbedPageWidgetState createState() => _TabbedPageWidgetState();
// }

// class _TabbedPageWidgetState extends State<TabbedPageWidget>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);

//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         // Fetch data for the respective tab when switching tabs
//         final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//         if (_tabController.index == 1) {
//           model.fetchFoodOptions(widget.placeId);
//         } else if (_tabController.index == 2) {
//           model.fetchDecorationOptions(widget.placeId);
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void navigateToNextTab() {
//     if (_tabController.index < 2) {
//       _tabController.animateTo(_tabController.index + 1);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Tabbed Page'),
//             bottom: TabBar(
//               indicatorColor: ColorManager.primaryColor,
//               controller: _tabController,
//               tabs: const [
//                 Tab(text: 'Music'),
//                 Tab(text: 'Food'),
//                 Tab(text: 'Decoration'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             controller: _tabController,
//             children: [
//               ServicesMusicPageWidget(
//                 placeId: widget.placeId,
//                 token: widget.token,
//                 onNext: navigateToNextTab,
//               ),
//               ServicesFoodPageWidget(
//                 placeId: widget.placeId,
//                 token: widget.token,
//                 onNext: navigateToNextTab,
//               ),
//               ServicesDecorationPageWidget(
//                 placeId: widget.placeId,
//                 token: widget.token,
//                 onNext: navigateToNextTab,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



















// class TabbedPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const TabbedPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//   }) : super(key: key);

//   @override
//   State<TabbedPageWidget> createState() => _TabbedPageWidgetState();
// }

// class _TabbedPageWidgetState extends State<TabbedPageWidget>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   void navigateToNextTab() {
//     if (_tabController.index < 2) {
//       _tabController.animateTo(_tabController.index + 1);
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<ApiModel>(
//       model: ApiModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Tabbed Page'),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           physics: NeverScrollableScrollPhysics(), // Disable swipe navigation
//           children: [
//             ServicesMusicPageWidget(
//               placeId: widget.placeId,
//               token: widget.token,
//               onNext: navigateToNextTab,
//             ),
//             ServicesFoodPageWidget(
//               placeId: widget.placeId,
//               token: widget.token,
//               onNext: navigateToNextTab,
//             ),
//             ServicesDecorationPageWidget(
//               placeId: widget.placeId,
//               token: widget.token,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















// class TabbedPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const TabbedPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<TabbedPageWidget> createState() => _TabbedPageWidgetState();
// }

// class _TabbedPageWidgetState extends State<TabbedPageWidget>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           title: Text(
//             'Tabbed Page',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: ColorManager.primaryColor8,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//           bottom: TabBar(
//             controller: _tabController,
//             tabs: const [
//               Tab(text: "Music"),
//               Tab(text: "Food"),
//               Tab(text: "Decoration"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             ServicesMusicPageWidget(
//                 placeId: widget.placeId, token: widget.token),
//             ServicesFoodPageWidget(
//                 placeId: widget.placeId, token: widget.token),
//             ServicesDecorationPageWidget(
//                 placeId: widget.placeId, token: widget.token),
//           ],
//         ),
//       );
//     });
//   }
// }
