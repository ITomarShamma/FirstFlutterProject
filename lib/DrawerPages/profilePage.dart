import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:pro2/models/profileModel.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({Key? key, required this.token}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: ColorManager.primaryColor6,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          title: Text(
            'Profile Page',
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
              Navigator.of(context).pop();
            },
          ),
        ),
        body: model.isLoadingProfile
            ? Center(child: CircularProgressIndicator())
            : model.profileData == null
                ? Center(child: Text('Failed to load profile data'))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name: ${model.profileData!.fullName}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email: ${model.profileData!.email}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
      );
    });
  }
}
