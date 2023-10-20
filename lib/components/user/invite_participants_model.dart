import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/atoms/accepted_friend.dart';

class InviteParticipantsModel extends FlutterFlowModel {
  @override
  void dispose() {}

  @override
  void initState(BuildContext context) {}

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

        List<Map<String, String>> friends = [];
        result.forEach(
          (element) {
            if (element['status'] == 'Accepted') friends.add(element);
          },
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Friends'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return AcceptedFriendAtom(
                  name: friends[index]['friendName'],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
