import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lobby_creation_model.dart';
export 'lobby_creation_model.dart';

class LobbyCreationWidget extends StatefulWidget {
  const LobbyCreationWidget({Key? key}) : super(key: key);

  @override
  _LobbyCreationWidgetState createState() => _LobbyCreationWidgetState();
}

class _LobbyCreationWidgetState extends State<LobbyCreationWidget> {
  late LobbyCreationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyCreationModel());

    _model.titleInput ??= TextEditingController();
    _model.destInput ??= TextEditingController();
    _model.budgetInput ??= TextEditingController();
    _model.meetingInput ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          actions: [],
          centerTitle: true,
          elevation: 2.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Lobby',
              ),
              SizedBox(
                height: 56,
                child: TextButton(
                  child: Text('CREATE'),
                  onPressed: () async {
                    final lobby = LobbyModel(
                      title: _model.titleInput.text,
                      destination: _model.destInput.text,
                      meetingPlace: _model.meetingInput.text,
                      startDate: _model.datePicked?.start,
                      endDate: _model.datePicked?.end,
                      participants: [],
                    );
                    await UserController.createLobby(lobby, context);
                  },
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            top: true,
            child: ListView(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                CustomTextInput(
                  label: 'Title',
                  controller: _model.titleInput,
                  validator: isEmpty,
                ),
                CustomTextInput(
                  label: 'Destination',
                  controller: _model.destInput,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Trip Date',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () async {
                        _model.datePicked = await showDateRangePicker(
                          context: context,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                        );
                        if (_model.datePicked != null) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Icon(
                                Icons.calendar_today,
                                color: Color(0xFF52B2FA),
                                size: 24.0,
                              ),
                            ),
                            Text(
                              _model.datePicked != null
                                  ? (_model.datePicked!.duration.inDays == 0
                                      ? "${DateFormat('MMM d').format(_model.datePicked!.start)}"
                                      : "${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}")
                                  : '',
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
