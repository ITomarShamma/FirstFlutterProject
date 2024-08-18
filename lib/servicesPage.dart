import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/models/servicesModel.dart';

class ServicesPageOmarWidget extends StatefulWidget {
  const ServicesPageOmarWidget({super.key});

  @override
  State<ServicesPageOmarWidget> createState() => _ServicesPageOmarWidgetState();
}

class _ServicesPageOmarWidgetState extends State<ServicesPageOmarWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabBarController;

  // Replace this with your data model class
  // You can likely remove most of this class
  ServicesPageOmarModel? _model; // Assuming you have a model class

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:
            const Color(0xFF2B3442), // Assuming you have color constants
        appBar: AppBar(
          backgroundColor: const Color(0xFF3B4355),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color(0xFF9B59B6),
          ),
          title: const Text(
            'Services',
            style: TextStyle(
              color: Color(0xFF9B59B6),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            )
            // const Color(0xFF9B59B6),

            ,
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF3B4355), const Color(0xFF819CBE)],
              stops: const [0, 1],
              begin: AlignmentDirectional(-1, 1),
              end: AlignmentDirectional(1, -1),
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: _buildTabBar(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabBarController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildDecorationView(),
                      _buildFoodView(),
                      _buildMusicView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        controller: _tabBarController,
        labelStyle: GoogleFonts.readexPro(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        unselectedLabelStyle: GoogleFonts.readexPro(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],

        //backgroundColor: const Color(0xFF3B4355),
        //unselectedBackgroundColor: const Color(0xFF2B3442),
        indicatorColor: Colors.transparent, // Remove border
        tabs: const [
          Tab(text: 'Decoration'),
          Tab(text: 'Food'),
          Tab(text: 'Music'),
        ],
      ),
    );
  }

  Widget _buildDecorationView() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('lib/assets/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0, -1),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDropDownMenu(
                title: 'ChairsNumber',
                initialValue: 'Option 1', // Replace with initial value
                onChanged: (value) =>
                    setState(() => _model?.dropDownValue1 = value),
              ),
              const SizedBox(height: 4.0), // Add spacing between dropdowns
              // Add more dropdown menus here using the same pattern as _buildDropDownMenu
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownMenu({
    required String title,
    required String initialValue,
    required Function(dynamic) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      items: ['Option 1', 'Option 2', 'Option 3'] // Replace with your options
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: onChanged,
      hint: Text(title),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: 24.0,
      //fillColor: const Color(0xFF3B4355),
      elevation: 2,
      focusColor: Colors.transparent, // Remove highlight on focus
      dropdownColor: const Color(0xFF3B4355),
      borderRadius: BorderRadius.circular(8.0),
      style: GoogleFonts.readexPro(
        color: const Color(0xFF9B59B6),
        fontSize: 16.0,
      ),
    );
  }

  Widget _buildFoodView() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('lib/assets/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0, -1),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDropDownMenu(
                title: 'ChairsNumber',
                initialValue: 'Option 1', // Replace with initial value
                onChanged: (value) =>
                    setState(() => _model?.dropDownValue1 = value),
              ),
              const SizedBox(height: 4.0), // Add spacing between dropdowns
              // Add more dropdown menus here using the same pattern as _buildDropDownMenu
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMusicView() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('lib/assets/733ab634-5a82-4c40-9d4f-1159cb79b623.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0, -1),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDropDownMenu(
                title: 'ChairsNumber',
                initialValue: 'Option 1', // Replace with initial value
                onChanged: (value) =>
                    setState(() => _model?.dropDownValue1 = value),
              ),
              const SizedBox(height: 4.0), // Add spacing between dropdowns
              // Add more dropdown menus here using the same pattern as _buildDropDownMenu
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPickerDropdown() {
    return DropdownButtonFormField<String>(
      value: 'White', // Replace with initial value
      items: ['White', 'Black', 'Blue'] // Replace with your options
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (value) => setState(
          () => _model?.dropDownValue2 = value!), // Update model if needed
      hint: Text('Color'),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: 24.0,
      //fillColor: const Color(0xFF3B4355),
      elevation: 2,
      focusColor: Colors.transparent, // Remove highlight on focus
      dropdownColor: const Color(0xFF3B4355),
      borderRadius: BorderRadius.circular(8.0),
      style: GoogleFonts.readexPro(
        color: const Color(0xFF9B59B6),
        fontSize: 16.0,
      ),
    );
  }
}
