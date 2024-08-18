import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/global/color.dart';
import 'package:pro2/models/musicModel.dart';
import 'package:pro2/page1.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';

import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';

class ServicesMusicPageWidget extends StatefulWidget {
  final int placeId;
  final String token;
  final VoidCallback onNext;

  const ServicesMusicPageWidget({
    Key? key,
    required this.placeId,
    required this.token,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ServicesMusicPageWidget> createState() =>
      _ServicesMusicPageWidgetState();
}

class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
  String? selectedMusicType;
  String? selectedSong;
  String? selectedMore;
  int? selectedMusicTypePrice;

  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
    model.fetchMusic(widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ApiModel>(
      builder: (context, child, model) {
        if (model.isLoadingMusic) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Music Session',
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildDropdown(
                    'MusicType',
                    model.typemusic
                        .map((type) => '${type.music?.typeMusic} ')
                        .toList(),
                    selectedMusicType,
                    (val) {
                      setState(() {
                        selectedMusicType = val;
                        final selectedType = model.typemusic.firstWhere(
                            (type) => '${type.music?.typeMusic} ' == val);
                        selectedMusicTypePrice = selectedType.music?.price;
                        model.setSelectedMusicDetails(
                          musicType: selectedType.music!.typeMusic!,
                          musicTypePrice: selectedType.music!.price!,
                          song: selectedSong ?? '',
                          moreDetails: selectedMore ?? '',
                        );
                      });
                    },
                  ),
                  _buildDropdown(
                    'SongsList',
                    model.sing
                        .map((sing) => sing.nameSinge ?? 'Unknown')
                        .toList(),
                    selectedSong,
                    (val) {
                      setState(() {
                        selectedSong = val;
                        model.setSelectedMusicDetails(
                          musicType: selectedMusicType ?? '',
                          musicTypePrice: selectedMusicTypePrice ?? 0,
                          song: selectedSong!,
                          moreDetails: selectedMore ?? '',
                        );
                      });
                    },
                  ),
                  _buildDropdown(
                    'More...',
                    model.more.map((more) => more.more ?? 'Unknown').toList(),
                    selectedMore,
                    (val) {
                      setState(() {
                        selectedMore = val;
                        model.setSelectedMusicDetails(
                          musicType: selectedMusicType ?? '',
                          musicTypePrice: selectedMusicTypePrice ?? 0,
                          song: selectedSong ?? '',
                          moreDetails: selectedMore!,
                        );
                      });
                    },
                  ),
                  _buildNextButton(() {
                    if (selectedMusicType != null &&
                        selectedSong != null &&
                        selectedMore != null) {
                      widget.onNext();
                    } else {
                      _showErrorDialog(context);
                    }
                  }),
                ].divide(const SizedBox(height: 2)),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String? value,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 350,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorManager.primaryColor2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorManager.primaryColor, width: 2),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint,
                style: const TextStyle(color: ColorManager.primaryColor8)),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF757575), size: 24),
            isExpanded: true,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option,
                    style: const TextStyle(
                        color: ColorManager.primaryColor8,
                        fontWeight: FontWeight.w800)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(VoidCallback _onPressed) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
      child: Container(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: _onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: ColorManager.primaryColor,
            foregroundColor: ColorManager.primaryColor8,
            textStyle: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: ColorManager.primaryColor,
                width: 3,
              ),
            ),
          ),
          child: Text('Next'),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorManager.primaryColor8,
          title: Text('Error'),
          content: Text(
            'Please fill all the fields before proceeding.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesMusicPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;
//   int? selectedMusicTypePrice;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchMusic(widget.placeId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         if (model.isLoadingMusic) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             automaticallyImplyLeading: false,
//             title: Text(
//               'Music Session',
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
//           body: Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                     'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _buildDropdown(
//                     'MusicType',
//                     model.typemusic
//                         .map((type) =>
//                             '${type.music?.typeMusic} (\$${type.music?.price})')
//                         .toList(),
//                     selectedMusicType,
//                     (val) {
//                       setState(() {
//                         selectedMusicType = val;
//                         final selectedType = model.typemusic.firstWhere((type) =>
//                             '${type.music?.typeMusic} (\$${type.music?.price})' ==
//                             val);
//                         selectedMusicTypePrice = selectedType.music?.price;
//                         model.setSelectedMusicDetails(
//                           musicType: selectedType.music!.typeMusic!,
//                           musicTypePrice: selectedType.music!.price!,
//                           song: selectedSong ?? '',
//                           moreDetails: selectedMore ?? '',
//                         );
//                       });
//                     },
//                   ),
//                   _buildDropdown(
//                     'SongsList',
//                     model.sing
//                         .map((sing) => sing.nameSinge ?? 'Unknown')
//                         .toList(),
//                     selectedSong,
//                     (val) {
//                       setState(() {
//                         selectedSong = val;
//                         model.setSelectedMusicDetails(
//                           musicType: selectedMusicType ?? '',
//                           musicTypePrice: selectedMusicTypePrice ?? 0,
//                           song: selectedSong!,
//                           moreDetails: selectedMore ?? '',
//                         );
//                       });
//                     },
//                   ),
//                   _buildDropdown(
//                     'More...',
//                     model.more.map((more) => more.more ?? 'Unknown').toList(),
//                     selectedMore,
//                     (val) {
//                       setState(() {
//                         selectedMore = val;
//                         model.setSelectedMusicDetails(
//                           musicType: selectedMusicType ?? '',
//                           musicTypePrice: selectedMusicTypePrice ?? 0,
//                           song: selectedSong ?? '',
//                           moreDetails: selectedMore!,
//                         );
//                       });
//                     },
//                   ),
//                   _buildNextButton(() {
//                     if (selectedMusicType != null &&
//                         selectedSong != null &&
//                         selectedMore != null) {
//                       widget.onNext();
//                     }
//                   }),
//                 ].divide(const SizedBox(height: 2)),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items, String? value,
//       Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 350,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor2,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: ColorManager.primaryColor, width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint,
//                 style: const TextStyle(color: ColorManager.primaryColor8)),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: ColorManager.primaryColor8,
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton(VoidCallback _onPressed) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: _onPressed,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: ColorManager.primaryColor,
//           foregroundColor: ColorManager.primaryColor8,
//           textStyle: const TextStyle(
//               fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: BorderSide(
//               color: ColorManager.primaryColor,
//               width: 3,
//             ),
//           ),
//         ),
//         child: Text('Next'),
//       ),
//     );
//   }
// }

// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesMusicPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchMusic(widget.placeId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ApiModel>(
//       builder: (context, child, model) {
//         if (model.typemusic.isEmpty &&
//             model.sing.isEmpty &&
//             model.more.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorManager.primaryColor,
//             automaticallyImplyLeading: false,
//             title: Text(
//               'Music Session',
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
//           body: Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                     'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _buildDropdown(
//                     'MusicType',
//                     model.typemusic
//                         .map((type) => type.music?.typeMusic ?? 'Unknown')
//                         .toList(),
//                     selectedMusicType,
//                     (val) => setState(() => selectedMusicType = val),
//                   ),
//                   _buildDropdown(
//                     'SongsList',
//                     model.sing
//                         .map((sing) => sing.nameSinge ?? 'Unknown')
//                         .toList(),
//                     selectedSong,
//                     (val) => setState(() => selectedSong = val),
//                   ),
//                   _buildDropdown(
//                     'More...',
//                     model.more.map((more) => more.more ?? 'Unknown').toList(),
//                     selectedMore,
//                     (val) => setState(() => selectedMore = val),
//                   ),
//                   _buildNextButton(() {
//                     model.setSelectedMusicDetails(
//                       musicType: selectedMusicType!,
//                       song: selectedSong!,
//                       moreDetails: selectedMore!,
//                     );
//                     widget.onNext();
//                   }),
//                 ].divide(const SizedBox(height: 2)),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items, String? value,
//       Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 350,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor2,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: ColorManager.primaryColor, width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint,
//                 style: const TextStyle(color: ColorManager.primaryColor8)),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: ColorManager.primaryColor8,
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
//   // Widget _buildDropdown(String hint, List<String> items, String? value,
//   //     Function(String?) onChanged) {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//   //     child: Container(
//   //       width: 350,
//   //       height: 56,
//   //       padding: const EdgeInsets.symmetric(horizontal: 16),
//   //       decoration: BoxDecoration(
//   //         color: const Color(0xFF2C2C54),
//   //         borderRadius: BorderRadius.circular(8),
//   //         border: Border.all(color: const Color(0xFF9575CD), width: 2),
//   //       ),
//   //       child: DropdownButtonHideUnderline(
//   //         child: DropdownButton<String>(
//   //           value: value,
//   //           hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//   //           icon: const Icon(Icons.keyboard_arrow_down_rounded,
//   //               color: Color(0xFF757575), size: 24),
//   //           isExpanded: true,
//   //           onChanged: onChanged,
//   //           items: items.map<DropdownMenuItem<String>>((String option) {
//   //             return DropdownMenuItem<String>(
//   //               value: option,
//   //               child: Text(option,
//   //                   style: const TextStyle(
//   //                       color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//   //             );
//   //           }).toList(),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget _buildNextButton(VoidCallback _onPressed) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: ElevatedButton(
//         onPressed: _onPressed,
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: ColorManager.primaryColor,
//           foregroundColor: ColorManager.primaryColor8,
//           textStyle: const TextStyle(
//               fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: BorderSide(
//               color: ColorManager.primaryColor,
//               width: 3,
//             ),
//           ),
//         ),
//         child: Text('Next'),
//       ),
//     );
//   }
// }

// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesMusicPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchMusic(widget.placeId, widget.token);
//     });
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C2C54),
//           title: const Text(
//             'MusicPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color(0xFFD32F2F),
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               color: Color(0xFFD32F2F),
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.typemusic.isEmpty &&
//                 model.sing.isEmpty &&
//                 model.more.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                       'MusicType',
//                       model.typemusic
//                           .map((type) => type.music?.typeMusic ?? 'Unknown')
//                           .toList(),
//                       selectedMusicType,
//                       (val) => setState(() => selectedMusicType = val),
//                     ),
//                     _buildDropdown(
//                       'SongsList',
//                       model.sing
//                           .map((sing) => sing.nameSinge ?? 'Unknown')
//                           .toList(),
//                       selectedSong,
//                       (val) => setState(() => selectedSong = val),
//                     ),
//                     _buildDropdown(
//                       'More...',
//                       model.more.map((more) => more.more ?? 'Unknown').toList(),
//                       selectedMore,
//                       (val) => setState(() => selectedMore = val),
//                     ),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items, String? value,
//       Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 350,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: Container(
//         width: 150,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: widget.onNext,
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             backgroundColor: const Color(0xFF2C2C54),
//             foregroundColor: const Color(0xFFD32F2F),
//             textStyle: const TextStyle(
//                 fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//             elevation: 3,
//           ),
//           child: const Text('Next'),
//         ),
//       ),
//     );
//   }
// }

// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;
//   final VoidCallback onNext;

//   const ServicesMusicPageWidget({
//     Key? key,
//     required this.placeId,
//     required this.token,
//     required this.onNext,
//   }) : super(key: key);

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchMusic(widget.placeId, widget.token);
//     });
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           title: Text(
//             'MusicPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: ColorManager.primaryColor8,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.purple[100],
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.typemusic.isEmpty &&
//                 model.sing.isEmpty &&
//                 model.more.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                       'MusicType',
//                       model.typemusic
//                           .map((type) => type.music?.typeMusic ?? 'Unknown')
//                           .toList(),
//                       selectedMusicType,
//                       (val) => setState(() => selectedMusicType = val),
//                     ),
//                     _buildDropdown(
//                       'SongsList',
//                       model.sing
//                           .map((sing) => sing.nameSinge ?? 'Unknown')
//                           .toList(),
//                       selectedSong,
//                       (val) => setState(() => selectedSong = val),
//                     ),
//                     _buildDropdown(
//                       'More...',
//                       model.more.map((more) => more.more ?? 'Unknown').toList(),
//                       selectedMore,
//                       (val) => setState(() => selectedMore = val),
//                     ),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: Container(
//         width: 150,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: widget.onNext,
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             backgroundColor: ColorManager.primaryColor,
//             foregroundColor: ColorManager.primaryColor8,
//             textStyle: const TextStyle(
//                 fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             side: const BorderSide(color: ColorManager.primaryColor, width: 3),
//             elevation: 3,
//           ),
//           child: const Text('Next'),
//         ),
//       ),
//     );
//   }
// }

// extension ListExtensions<T> on List<T> {
//   List<T> divide(T divider) {
//     if (this.isEmpty) return this;
//     return this.length == 1
//         ? this
//         : this.sublist(0, this.length - 1).fold<List<T>>(
//             [],
//             (initialValue, element) => [...initialValue, element, divider],
//           )
//       ..add(this.last);
//   }
// }

// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesMusicPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   late FocusNode _unfocusNode;
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;

//   @override
//   void initState() {
//     super.initState();
//     _unfocusNode = FocusNode();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchMusic(widget.placeId, widget.token);
//     });
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           title: Text(
//             'MusicPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: ColorManager.primaryColor8,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.purple[100],
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.typemusic.isEmpty &&
//                 model.sing.isEmpty &&
//                 model.more.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                       'MusicType',
//                       model.typemusic
//                           .map((type) => type.music?.typeMusic ?? 'Unknown')
//                           .toList(),
//                       selectedMusicType,
//                       (val) => setState(() => selectedMusicType = val),
//                     ),
//                     _buildDropdown(
//                       'SongsList',
//                       model.sing
//                           .map((sing) => sing.nameSinge ?? 'Unknown')
//                           .toList(),
//                       selectedSong,
//                       (val) => setState(() => selectedSong = val),
//                     ),
//                     _buildDropdown(
//                       'More...',
//                       model.more.map((more) => more.more ?? 'Unknown').toList(),
//                       selectedMore,
//                       (val) => setState(() => selectedMore = val),
//                     ),
//                     //_buildCheckboxGroup(),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items, String? value,
//       Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 350,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor2,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: ColorManager.primaryColor, width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint,
//                 style: const TextStyle(color: ColorManager.primaryColor8)),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: ColorManager.primaryColor8,
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: Container(
//         width: 150,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             backgroundColor: ColorManager.primaryColor,
//             foregroundColor: ColorManager.primaryColor8,
//             textStyle: const TextStyle(
//                 fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             side: const BorderSide(color: ColorManager.primaryColor, width: 3),
//             elevation: 3,
//           ),
//           child: const Text('Next'),
//         ),
//       ),
//     );
//   }
// }

// extension ListExtensions<T> on List<T> {
//   List<T> divide(T divider) {
//     if (this.isEmpty) return this;
//     return this.length == 1
//         ? this
//         : this.sublist(0, this.length - 1).fold<List<T>>(
//             [],
//             (initialValue, element) => [...initialValue, element, divider],
//           )
//       ..add(this.last);
//   }
// }

// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesMusicPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchMusic(widget.placeId, widget.token);
//     });
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: ColorManager.primaryColor,
//           title: Text(
//             'MusicPage',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: ColorManager.primaryColor8,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.purple[100],
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.typemusic.isEmpty &&
//                 model.sing.isEmpty &&
//                 model.more.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                       'MusicType',
//                       model.typemusic
//                           .map((type) => type.music?.typeMusic ?? 'Unknown')
//                           .toList(),
//                       selectedMusicType,
//                       (val) => setState(() => selectedMusicType = val),
//                     ),
//                     _buildDropdown(
//                       'SongsList',
//                       model.sing
//                           .map((sing) => sing.nameSinge ?? 'Unknown')
//                           .toList(),
//                       selectedSong,
//                       (val) => setState(() => selectedSong = val),
//                     ),
//                     _buildDropdown(
//                       'More...',
//                       model.more.map((more) => more.more ?? 'Unknown').toList(),
//                       selectedMore,
//                       (val) => setState(() => selectedMore = val),
//                     ),
//                     //_buildCheckboxGroup(),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items, String? value,
//       Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 350,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: ColorManager.primaryColor2,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: ColorManager.primaryColor, width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint,
//                 style: const TextStyle(color: ColorManager.primaryColor8)),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: ColorManager.primaryColor8,
//                         fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//       child: Container(
//         width: 150,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             backgroundColor: ColorManager.primaryColor,
//             foregroundColor: ColorManager.primaryColor8,
//             textStyle: const TextStyle(
//                 fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             side: const BorderSide(color: ColorManager.primaryColor, width: 3),
//             elevation: 3,
//           ),
//           child: const Text('Next'),
//         ),
//       ),
//     );
//   }
// }

extension ListExtensions<T> on List<T> {
  List<T> divide(T divider) {
    if (this.isEmpty) return this;
    return this.length == 1
        ? this
        : this.sublist(0, this.length - 1).fold<List<T>>(
            [],
            (initialValue, element) => [...initialValue, element, divider],
          )
      ..add(this.last);
  }
}





















// Widget _buildCheckboxGroup() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Container(
  //       width: 300,
  //       decoration: BoxDecoration(
  //         gradient: const LinearGradient(
  //           colors: [
  //             Color(0xFF2C2C54),
  //             Color(0xFF2E2E3A),
  //             Color(0xFF4A148C),
  //             Color(0xFFD1C4E9)
  //           ],
  //           stops: [0, 1, 1, 1],
  //           begin: AlignmentDirectional(1, -1),
  //           end: AlignmentDirectional(-1, 1),
  //         ),
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(color: const Color(0xFF9575CD), width: 2),
  //       ),
  //       child: Align(
  //         alignment: AlignmentDirectional(0, 0),
  //         child: Padding(
  //           padding: const EdgeInsets.all(2),
  //           child: Column(
  //             children: ['option1', 'option2'].map((option) {
  //               return CheckboxListTile(
  //                 title: Text(option,
  //                     style:
  //                         const TextStyle(color: ColorManager.primaryColor8)),
  //                 value: false,
  //                 onChanged: (bool? val) {},
  //                 activeColor: const Color(0xFF9575CD),
  //                 checkColor: const Color(0xFF2C2C54),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }









// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesMusicPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? selectedMusicType;
//   String? selectedSong;
//   String? selectedMore;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchMusic(widget.placeId, widget.token);
//     });
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C2C54),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F), size: 30),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'Music System',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color(0xFFD32F2F),
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.typemusic.isEmpty &&
//                 model.sing.isEmpty &&
//                 model.more.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                       'MusicType',
//                       model.typemusic
//                           .map((type) => type.music?.typeMusic ?? 'Unknown')
//                           .toList(),
//                       selectedMusicType,
//                       (val) => setState(() => selectedMusicType = val),
//                     ),
//                     _buildDropdown(
//                       'SongsList',
//                       model.sing
//                           .map((sing) => sing.nameSinge ?? 'Unknown')
//                           .toList(),
//                       selectedSong,
//                       (val) => setState(() => selectedSong = val),
//                     ),
//                     _buildDropdown(
//                       'More...',
//                       model.more.map((more) => more.more ?? 'Unknown').toList(),
//                       selectedMore,
//                       (val) => setState(() => selectedMore = val),
//                     ),
//                     _buildCheckboxGroup(),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items, String? value,
//       Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: onChanged,
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckboxGroup() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFF2C2C54),
//               Color(0xFF2E2E3A),
//               Color(0xFF4A148C),
//               Color(0xFFD1C4E9)
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Padding(
//             padding: const EdgeInsets.all(2),
//             child: Column(
//               children: ['option1', 'option2'].map((option) {
//                 return CheckboxListTile(
//                   title: Text(option,
//                       style: const TextStyle(color: Color(0xFFD32F2F))),
//                   value: false,
//                   onChanged: (bool? val) {},
//                   activeColor: const Color(0xFF9575CD),
//                   checkColor: const Color(0xFF2C2C54),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// extension on List<Widget> {
//   List<Widget> divide(Widget divider) {
//     if (isEmpty) return this;
//     final List<Widget> divided = [];
//     for (var i = 0; i < length; i++) {
//       divided.add(this[i]);
//       if (i < length - 1) {
//         divided.add(divider);
//       }
//     }
//     return divided;
//   }
// }


































// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesMusicPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//       model.fetchMusic(widget.placeId, widget.token);
//     });
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C2C54),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F), size: 30),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'Music System',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color(0xFFD32F2F),
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             if (model.typemusic.isEmpty &&
//                 model.sing.isEmpty &&
//                 model.more.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             }

//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                         'MusicType',
//                         model.typemusic
//                             .map((type) => type.music?.typeMusic ?? 'Unknown')
//                             .toList()),
//                     _buildDropdown(
//                         'SongsList',
//                         model.sing
//                             .map((sing) => sing.nameSinge ?? 'Unknown')
//                             .toList()),
//                     _buildDropdown(
//                         'More...',
//                         model.more
//                             .map((more) => more.more ?? 'Unknown')
//                             .toList()),
//                     _buildCheckboxGroup(),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: (val) {},
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckboxGroup() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFF2C2C54),
//               Color(0xFF2E2E3A),
//               Color(0xFF4A148C),
//               Color(0xFFD1C4E9)
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Padding(
//             padding: const EdgeInsets.all(2),
//             child: Column(
//               children: ['option1', 'option2'].map((option) {
//                 return CheckboxListTile(
//                   title: Text(option,
//                       style: const TextStyle(color: Color(0xFFD32F2F))),
//                   value: false,
//                   onChanged: (bool? val) {},
//                   activeColor: const Color(0xFF9575CD),
//                   checkColor: const Color(0xFF2C2C54),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// extension on List<Widget> {
//   List<Widget> divide(Widget divider) {
//     if (isEmpty) return this;
//     final List<Widget> divided = [];
//     for (var i = 0; i < length; i++) {
//       divided.add(this[i]);
//       if (i < length - 1) {
//         divided.add(divider);
//       }
//     }
//     return divided;
//   }
// }



























// class ServicesMusicPageWidget extends StatefulWidget {
//   final int placeId;
//   final String token;

//   const ServicesMusicPageWidget({
//     super.key,
//     required this.placeId,
//     required this.token,
//   });

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     final model = ScopedModel.of<ApiModel>(context, rebuildOnChange: false);
//     model.fetchMusic(widget.placeId, widget.token);
//   }

//   @override
//   void dispose() {
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFFFFFFF),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C2C54),
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F), size: 30),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'Music System',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color(0xFFD32F2F),
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: ScopedModelDescendant<ApiModel>(
//           builder: (context, child, model) {
//             return Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'lib/assets/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildDropdown(
//                         'MusicType',
//                         model.typemusic
//                             .map((type) => type.music!.typeMusic!)
//                             .toList()),
//                     _buildDropdown('SongsList',
//                         model.sing.map((sing) => sing.nameSinge!).toList()),
//                     _buildDropdown('More...',
//                         model.more.map((more) => more.more!).toList()),
//                     _buildCheckboxGroup(),
//                     _buildNextButton(),
//                   ].divide(const SizedBox(height: 2)),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String hint, List<String> items) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2C2C54),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             hint: Text(hint, style: const TextStyle(color: Color(0xFFD32F2F))),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575), size: 24),
//             isExpanded: true,
//             onChanged: (val) {},
//             items: items.map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F), fontWeight: FontWeight.w800)),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckboxGroup() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFF2C2C54),
//               Color(0xFF2E2E3A),
//               Color(0xFF4A148C),
//               Color(0xFFD1C4E9)
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: const Color(0xFF9575CD), width: 2),
//         ),
//         child: Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Padding(
//             padding: const EdgeInsets.all(2),
//             child: Column(
//               children: ['option1', 'option2'].map((option) {
//                 return CheckboxListTile(
//                   title: Text(option,
//                       style: const TextStyle(color: Color(0xFFD32F2F))),
//                   value: false,
//                   onChanged: (bool? val) {},
//                   activeColor: const Color(0xFF9575CD),
//                   checkColor: const Color(0xFF2C2C54),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A),
//           foregroundColor: const Color(0xFFD32F2F),
//           textStyle: const TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(color: Color(0xFF2C2C54), width: 3),
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }

// extension on List<Widget> {
//   List<Widget> divide(Widget divider) {
//     if (isEmpty) return this;
//     final List<Widget> divided = [];
//     for (var i = 0; i < length; i++) {
//       divided.add(this[i]);
//       if (i < length - 1) {
//         divided.add(divider);
//       }
//     }
//     return divided;
//   }
// }





































// class ServicesMusicPageWidget extends StatefulWidget {
//   const ServicesMusicPageWidget({super.key});

//   @override
//   State<ServicesMusicPageWidget> createState() =>
//       _ServicesMusicPageWidgetState();
// }

// class _ServicesMusicPageWidgetState extends State<ServicesMusicPageWidget> {
//   //late ServicesMusicPageModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();
//   String? dropDownValue1;
//   String? dropDownValue2;
//   String? dropDownValue3;
//   List<String> checkboxGroupValues = [];

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => ServicesMusicPageModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();
//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   void _unfocus() {
//     if (_unfocusNode.canRequestFocus) {
//       FocusScope.of(context).requestFocus(_unfocusNode);
//     } else {
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _unfocus,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(
//             0xFFFFFFFF), // Replace FlutterFlowTheme.of(context).primaryBackground
//         appBar: AppBar(
//           backgroundColor: const Color(
//               0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_rounded,
//                 color: Color(0xFFD32F2F),
//                 size: 30), // Replace FlutterFlowIconButton
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'Music System',
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Color(0xFFD32F2F),
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//             ), // Replace FlutterFlowTheme.of(context).headlineMedium.override
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image:  AssetImage(
//                   'assets/images/773cc2ff-24e6-4ab6-921d-54833a986b19.jpg'),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _buildDropdown(dropDownValue1,
//                     (val) => setState(() => dropDownValue1 = val)),
//                 _buildDropdown(dropDownValue2,
//                     (val) => setState(() => dropDownValue2 = val)),
//                 _buildDropdown(dropDownValue3,
//                     (val) => setState(() => dropDownValue3 = val)),
//                 _buildCheckboxGroup(),
//                 _buildNextButton(),
//               ].divide(const SizedBox(height: 2)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String? value, Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color(
//               0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet2
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//               color: const Color(0xFF9575CD),
//               width: 2), // Replace FlutterFlowTheme.of(context).amethyst
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             hint: const Text('Please select...',
//                 style: TextStyle(
//                     color: Color(
//                         0xFFD32F2F))), // Replace FlutterFlowTheme.of(context).mauve
//             icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                 color: Color(0xFF757575),
//                 size: 24), // Replace FlutterFlowTheme.of(context).secondaryText
//             isExpanded: true,
//             onChanged: onChanged,
//             items: ['Option 1'].map<DropdownMenuItem<String>>((String option) {
//               return DropdownMenuItem<String>(
//                 value: option,
//                 child: Text(option,
//                     style: const TextStyle(
//                         color: Color(0xFFD32F2F),
//                         fontWeight: FontWeight
//                             .w800)), // Replace FlutterFlowTheme.of(context).bodyMedium.override
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckboxGroup() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(
//                   0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet
//               Color(
//                   0xFF2E2E3A), // Replace FlutterFlowTheme.of(context).persianIndigo
//               Color(
//                   0xFF4A148C), // Replace FlutterFlowTheme.of(context).frenchViolet
//               Color(
//                   0xFFD1C4E9) // Replace FlutterFlowTheme.of(context).heliotrope
//             ],
//             stops: [0, 1, 1, 1],
//             begin: AlignmentDirectional(1, -1),
//             end: AlignmentDirectional(-1, 1),
//           ),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: const Color(0xFF9575CD),
//               width: 2), // Replace FlutterFlowTheme.of(context).amethyst
//         ),
//         child: Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Padding(
//             padding: const EdgeInsets.all(2),
//             child: Column(
//               children: ['option1', 'option2'].map((option) {
//                 return CheckboxListTile(
//                   title: Text(option,
//                       style: const TextStyle(
//                           color: Color(
//                               0xFFD32F2F))), // Replace FlutterFlowTheme.of(context).mauve
//                   value: checkboxGroupValues.contains(option),
//                   onChanged: (bool? val) {
//                     setState(() {
//                       if (val == true) {
//                         checkboxGroupValues.add(option);
//                       } else {
//                         checkboxGroupValues.remove(option);
//                       }
//                     });
//                   },
//                   activeColor: const Color(
//                       0xFF9575CD), // Replace FlutterFlowTheme.of(context).amethyst
//                   checkColor: const Color(
//                       0xFF2C2C54), // Replace FlutterFlowTheme.of(context).russianViolet
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNextButton() {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
//       child: ElevatedButton(
//         onPressed: () {

//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           backgroundColor: const Color(0xFF2E2E3A), // Correct parameter
//           foregroundColor: const Color(0xFFD32F2F), // Correct parameter
//           textStyle: const TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           side: const BorderSide(
//               color: Color(0xFF2C2C54),
//               width: 3), // Replace FlutterFlowTheme.of(context).russianViolet
//           elevation: 3,
//         ),
//         child: const Text('Next'),
//       ),
//     );
//   }
// }


