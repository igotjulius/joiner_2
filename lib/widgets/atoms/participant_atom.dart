import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/widgets/atoms/participant_atom_model.dart';

class ParticipantAtom extends StatefulWidget {
  final String? name;
  final String? friendId;
  final bool? showCheckBox;
  final Function(String, String)? eventCallback;
  final String? suffixLabel;

  const ParticipantAtom({
    Key? key,
    this.name,
    this.friendId,
    this.showCheckBox,
    this.eventCallback,
    this.suffixLabel,
  }) : super(key: key);

  @override
  _ParticipantAtomState createState() => _ParticipantAtomState();
}

class _ParticipantAtomState extends State<ParticipantAtom> {
  late ParticipantAtomModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(
        context, () => ParticipantAtomModel(friendId: widget.friendId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
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
                            widget.name!,
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
                                widget.eventCallback!(
                                  _model.friendId!,
                                  widget.name!,
                                );
                              });
                            },
                          ),
                        if (widget.suffixLabel == 'Pending')
                          Text(widget.suffixLabel!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
