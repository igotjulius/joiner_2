import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/generic_response.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class FriendsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final Function updateWidget;
  FriendsModel(this.updateWidget);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  FutureBuilder<ResponseModel<List<Map<String, String>>>?> friendList(
    Widget Function(List<Map<String, String>>) pendingFriends,
    Widget Function(List<Map<String, String>>) acceptedFriends,
    Widget Function(List<Map<String, String>>) waitingApproval,
  ) {
    return FutureBuilder(
      // future: UserController.getFriends(),
      future: null,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        final result = snapshot.data!.data;
        if (result == null)
          return Center(
            child: Text('Add your friends here'),
          );

        List<Map<String, String>> pending = [], accepted = [], forApproval = [];
        result.forEach(
          (element) {
            if (element['status'] == 'Accepted')
              accepted.add(element);
            else if (element['status'] == 'Pending')
              pending.add(element);
            else
              forApproval.add(element);
          },
        );

        return ListView(
          shrinkWrap: true,
          children: [
            if (pending.isNotEmpty) pendingFriends(pending),
            if (forApproval.isNotEmpty) waitingApproval(forApproval),
            if (accepted.isNotEmpty) acceptedFriends(accepted),
          ].divide(
            SizedBox(
              height: 20,
            ),
          ),
        );
      },
    );
  }

  /// Additional helper methods are added here.
}
