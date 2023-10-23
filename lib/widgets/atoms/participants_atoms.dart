import 'package:flutter/material.dart';

class ParticipantsAtoms extends StatefulWidget {
  final String name;

  const ParticipantsAtoms({Key? key, required this.name}) : super(key: key);

  @override
  _ParticipantsAtomsState createState() => _ParticipantsAtomsState();
}

class _ParticipantsAtomsState extends State<ParticipantsAtoms> {
  bool isCheckd = false;

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
                            widget.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: isCheckd,
                          onChanged: (value) {
                            setState(() {
                              isCheckd = value!;
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
      ),
    );
  }
}
