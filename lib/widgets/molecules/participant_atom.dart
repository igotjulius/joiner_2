import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class ParticipantMole extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String friendUserId;
  final bool? showCheckBox;
  final void Function(bool, String, String, String)? onCheckBoxTap;
  final String? suffixLabel;
  final bool? showRemoveOption;
  final String? lobbyId;

  const ParticipantMole({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.friendUserId,
    this.lobbyId,
    this.showCheckBox,
    this.onCheckBoxTap,
    this.suffixLabel,
    this.showRemoveOption,
  }) : super(key: key);

  @override
  _ParticipantMoleState createState() => _ParticipantMoleState();
}

class _ParticipantMoleState extends State<ParticipantMole> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/User_01c_(1).png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${widget.firstName} ${widget.lastName}',
                  ),
                ),
                if (widget.showCheckBox != null)
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      widget.onCheckBoxTap!(
                        value!,
                        widget.friendUserId,
                        widget.firstName,
                        widget.lastName,
                      );
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                if (widget.suffixLabel == 'Pending') Text(widget.suffixLabel!),
                if (widget.showRemoveOption == true)
                  IconButton(
                    iconSize: 16,
                    splashRadius: 24,
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Remove'),
                            content: Text('Remove participant?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final provider =
                                      context.read<Auth>() as UserController;
                                  provider
                                      .removeParticipant(
                                    widget.lobbyId!,
                                    widget.friendUserId,
                                  )
                                      .then((value) {
                                    context.pop();
                                    if (!value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        showError(
                                            'Can\'t remove participant',
                                            Theme.of(context)
                                                .colorScheme
                                                .error),
                                      );
                                    }
                                  });
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text('No'),
                              ),
                            ],
                            elevation: 8.0,
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
