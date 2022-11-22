import 'package:flutter/material.dart';
import 'package:zona/src/features/models/drafts.dart';
import 'package:http/http.dart' as http;

class DraftProvider extends ChangeNotifier {
  List<Drafts> draftsList = [];

  Future<void> getDrafts(int userid) async {
    final response = http.post(
        Uri.parse("http://new.zona.ae/api/orders/my_draft_orders"),
        body: {
          "iduser": userid,
        });

    draftsList = draftsFromJson(response.toString());

    // notifyListeners();

    print(response.toString());
  }
}
