import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/widgets/molecules/participant_atom_model.dart';
import 'package:provider/provider.dart';

class ParticipantMole extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? userId;
  final bool? showCheckBox;
  final Function(String, String, String)? eventCallback;
  final String? suffixLabel;
  final bool? showRemoveOption;
  final Function(Function())? rebuildParent;

  const ParticipantMole({
    Key? key,
    this.firstName,
    this.lastName,
    this.userId,
    this.showCheckBox,
    this.eventCallback,
    this.suffixLabel,
    this.showRemoveOption,
    this.rebuildParent,
  }) : super(key: key);

  @override
  _ParticipantMoleState createState() => _ParticipantMoleState();
}

class _ParticipantMoleState extends State<ParticipantMole> {
  late ParticipantModel _model;

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => ParticipantModel(friendId: widget.userId));
    _model.lobbyId = Provider.of<LobbyModel?>(context, listen: false)?.id;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
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
                      SizedBox(width: 12.1),
                      Expanded(
                        child: Text(
                          '${widget.firstName!} ${widget.lastName!}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      if (widget.showCheckBox != null)
                        Checkbox(
                          value: _model.isChecked,
                          onChanged: (value) {
                            setState(() {
                              _model.isChecked = value!;
                              widget.eventCallback!(_model.friendId!,
                                  widget.firstName!, widget.lastName!);
                            });
                          },
                        ),
                      if (widget.suffixLabel == 'Pending')
                        Text(widget.suffixLabel!),
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
                                          context.pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _model.removeParticipant();
                                          showSnackbar(
                                              context, 'Participant removed');
                                          context.pop();
                                          widget.rebuildParent!(() {});
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                    elevation: 8.0,
                                  );
                                });
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
