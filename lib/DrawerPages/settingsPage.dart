// import 'package:flutter/material.dart';
// import 'package:pro2/global/localizationModel.dart';
// import 'package:pro2/main.dart';
// import 'package:scoped_model/scoped_model.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<LocalizationModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(model.translate('settings')),
//             backgroundColor: Colors.deepPurple,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   model.translate('settings'),
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 ListTile(
//                   leading: const Icon(Icons.language),
//                   title: Text(model.translate('language')),
//                   subtitle: Text(
//                       model.locale.languageCode == 'en' ? 'English' : 'Arabic'),
//                   onTap: () {
//                     _showLanguageDialog(context, model);
//                   },
//                 ),
//                 // ListTile(
//                 //   leading: const Icon(Icons.brightness_6),
//                 //   title: Text(model.translate('app_theme')),
//                 //   subtitle: Text(model.isDarkTheme ? model.translate('dark') : model.translate('light')),
//                 //   onTap: () {
//                 //    model.toggleTheme();
//                 //   },
//                 //    trailing: Switch(
//                 //      value: model.isDarkTheme,
//                 //      onChanged: (value) {
//                 //        model.toggleTheme();
//                 //     },
//                 //    ),
//                 // ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showLanguageDialog(BuildContext context, LocalizationModel model) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(model.translate('language')),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile(
//                 title: const Text('English'),
//                 value: 'en',
//                 groupValue: model.locale.languageCode,
//                 onChanged: (value) {
//                   model.changeLanguage(value as String);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               RadioListTile(
//                 title: const Text('Arabic'),
//                 value: 'ar',
//                 groupValue: model.locale.languageCode,
//                 onChanged: (value) {
//                   model.changeLanguage(value as String);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:pro2/auth/loginPage.dart'; // Update this import based on your actual login page

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/cubit/authCubit.dart';
import 'package:pro2/auth/loginPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor6,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: Text(
          'Settings',
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
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state is LogoutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logout failed')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: Text(selectedLanguage),
                onTap: () {
                  _showLanguageDialog();
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('App Theme'),
                subtitle: Text(isDarkTheme ? 'Dark' : 'Light'),
                onTap: () {
                  setState(() {
                    isDarkTheme = !isDarkTheme;
                  });
                },
                trailing: Switch(
                  value: isDarkTheme,
                  onChanged: (value) {
                    setState(() {
                      isDarkTheme = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorManager.primaryColor8,
                    backgroundColor: ColorManager.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text('English'),
                value: 'English',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value as String;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: const Text('Arabic'),
                value: 'Arabic',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value as String;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}















// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isDarkTheme = false;
//   String selectedLanguage = 'English';

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: Text(
//               'UI settings',
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
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Settings',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 ListTile(
//                   leading: const Icon(Icons.language),
//                   title: const Text('Language'),
//                   subtitle: Text(selectedLanguage),
//                   onTap: () {
//                     _showLanguageDialog();
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.brightness_6),
//                   title: const Text('App Theme'),
//                   subtitle: Text(isDarkTheme ? 'Dark' : 'Light'),
//                   onTap: () {
//                     setState(() {
//                       isDarkTheme = !isDarkTheme;
//                     });
//                   },
//                   trailing: Switch(
//                     value: isDarkTheme,
//                     onChanged: (value) {
//                       setState(() {
//                         isDarkTheme = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton.icon(
//                     onPressed: () async {
//                       final logoutResult = await model.logout();
//                       if (logoutResult.success == true) {
//                         model.clearToken();
//                         Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()),
//                           (route) => false,
//                         );
//                       } else {
//                         // Handle logout failure
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                               content: Text(
//                                   logoutResult.message ?? 'Logout failed')),
//                         );
//                       }
//                     },
//                     icon: const Icon(Icons.logout),
//                     label: const Text('Logout'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorManager.primaryColor,
//                       disabledBackgroundColor: ColorManager.primaryColor8,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showLanguageDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Select Language'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile(
//                 title: const Text('English'),
//                 value: 'English',
//                 groupValue: selectedLanguage,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedLanguage = value as String;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               RadioListTile(
//                 title: const Text('Arabic'),
//                 value: 'Arabic',
//                 groupValue: selectedLanguage,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedLanguage = value as String;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
















// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isDarkTheme = false;
//   String selectedLanguage = 'English';

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             title: Text(
//               'UI settings',
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
//                 Navigator.of(context).pop();
//               },
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(
//                   Icons.logout,
//                   color: Colors.purple[100],
//                   size: 30,
//                 ),
//                 onPressed: () async {
//                   final logoutResult = await model.logout();
//                   if (logoutResult.success!) {
//                     model.clearToken();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   } else {
//                     _showErrorDialog(context, logoutResult.message);
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Settings',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 ListTile(
//                   leading: const Icon(Icons.language),
//                   title: const Text('Language'),
//                   subtitle: Text(selectedLanguage),
//                   onTap: () {
//                     _showLanguageDialog();
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.brightness_6),
//                   title: const Text('App Theme'),
//                   subtitle: Text(isDarkTheme ? 'Dark' : 'Light'),
//                   onTap: () {
//                     setState(() {
//                       isDarkTheme = !isDarkTheme;
//                     });
//                   },
//                   trailing: Switch(
//                     value: isDarkTheme,
//                     onChanged: (value) {
//                       setState(() {
//                         isDarkTheme = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showLanguageDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Select Language'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile(
//                 title: const Text('English'),
//                 value: 'English',
//                 groupValue: selectedLanguage,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedLanguage = value as String;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//               RadioListTile(
//                 title: const Text('Arabic'),
//                 value: 'Arabic',
//                 groupValue: selectedLanguage,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedLanguage = value as String;
//                   });
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showErrorDialog(BuildContext context, String? message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message ?? 'An error occurred'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }













// import 'package:flutter/material.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Settings',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Account'),
//               onTap: () {
//                 // Handle account settings navigation
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.notifications),
//               title: const Text('Notifications'),
//               onTap: () {
//                 // Handle notifications settings navigation
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.lock),
//               title: const Text('Privacy'),
//               onTap: () {
//                 // Handle privacy settings navigation
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.help),
//               title: const Text('Help'),
//               onTap: () {
//                 // Handle help settings navigation
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {
//                 // Handle about settings navigation
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
