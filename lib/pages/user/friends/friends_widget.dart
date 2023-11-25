import 'package:joiner_1/index.dart';
import 'package:joiner_1/pages/user/friends/components/pending_friend.dart';
import 'package:joiner_1/pages/user/friends/components/accepted_friend.dart';
import 'package:joiner_1/pages/user/friends/components/waiting_approval.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'friends_model.dart';
export 'friends_model.dart';

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({Key? key}) : super(key: key);

  @override
  _FriendsWidgetState createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  late FriendsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FriendsModel(setState));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
              child: _model.friendList(
                  pendingFriends, acceptedFriends, waitingApproval),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 72),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Dialog(
                  surfaceTintColor: Colors.white,
                  insetPadding: EdgeInsets.zero,
                  child: InviteFriendWidget(
                    parentSetState: setState,
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget pendingFriends(List<Map<String, String>> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Friend Requests',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return PendingFriendAtom(
              name: '${list[index]['firstName']} ${list[index]['lastName']}',
              friendId: list[index]['friendId'],
              parentSetState: setState,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ],
    );
  }

  Widget acceptedFriends(List<Map<String, String>> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Friends',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return AcceptedFriendAtom(
              name: '${list[index]['firstName']} ${list[index]['lastName']}',
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ],
    );
  }

  Widget waitingApproval(List<Map<String, String>> list) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'For Approval',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return WaitingApproval(
              friendId: list[index]['friendId'],
              name: '${list[index]['firstName']} ${list[index]['lastName']}',
              parentSetState: setState,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ],
    );
  }
}
