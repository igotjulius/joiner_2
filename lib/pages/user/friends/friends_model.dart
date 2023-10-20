import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/atoms/accepted_friend.dart';
import 'package:joiner_1/widgets/atoms/pending_friend.dart';

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
  FutureBuilder<ResponseModel<List<Map<String, String>>>?> friendList() {
    return FutureBuilder(
      future: UserController.getFriends(),
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

        List<Map<String, String>> pending = [], accepted = [];
        result.forEach(
          (element) {
            if (element['status'] == 'Pending')
              pending.add(element);
            else if (element['status'] == 'Accepted') accepted.add(element);
          },
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Friend Requests'),
            pendingFriends(pending),
            SizedBox(
              height: 40,
            ),
            Text('Friends'),
            acceptedFriends(accepted),
          ],
        );
      },
    );
  }

  Widget pendingFriends(List<Map<String, String>> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return PendingFriendAtom(
          name: list[index]['friendName'],
          friendId: list[index]['friendId'],
          acceptEventAction: acceptFriendRequest,
        );
      },
    );
  }

  Widget acceptedFriends(List<Map<String, String>> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return AcceptedFriendAtom(
          name: list[index]['friendName'],
        );
      },
    );
  }

  void acceptFriendRequest(String friendId) async {
    await UserController.acceptFriendRequest(friendId);
    updateWidget(() {});
  }

  /// Additional helper methods are added here.
}
