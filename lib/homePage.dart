import 'package:flutter/material.dart';
import 'package:pro2/provincesPage.dart';
import 'package:pro2/services/apiModel.dart';
import 'package:pro2/services/cashHelper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pro2/services/apiModel.dart';

class HomePage extends StatelessWidget {
  // Replace with your token logic
  var apiModel = new ApiModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: ScopedModelDescendant<ApiModel>(
        builder: (context, child, model) {
          return Center(
            child: ElevatedButton(
              onPressed: () async {
                model.setTypeEventId(1); // Set the type_event_id
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provinces(
                      typeEventId: 1,
                      token: CachHelper.getString(key: "token")!,
                      // token: apiModel.token,
                    ),
                  ),
                );
              },
              child: Text('Go to Provinces Page'),
            ),
          );
        },
      ),
    );
  }
}
