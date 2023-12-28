import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LobbyCreationWidget extends StatefulWidget {
  final String destination;
  const LobbyCreationWidget({super.key, required this.destination});

  @override
  _LobbyCreationWidgetState createState() => _LobbyCreationWidgetState();
}

class _LobbyCreationWidgetState extends State<LobbyCreationWidget> {
  DateTimeRange? _datePicked;
  TextEditingController _titleInput = TextEditingController();
  TextEditingController _destInput = TextEditingController();
  TextEditingController _budgetInput = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleInput.dispose();
    _destInput.dispose();
    _budgetInput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _destInput.text = widget.destination;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  if (_formKey.currentState!.validate()) {
                    showDialogLoading(context);
                    final lobby = LobbyModel(
                      title: _titleInput.text,
                      destination: _destInput.text,
                      startDate: _datePicked?.start,
                      endDate: _datePicked?.end,
                      participants: [],
                      poll: [],
                      linkedRental: [],
                    );
                    final provider = context.read<Auth>() as UserController;
                    final result = await provider.createLobby(lobby);
                    context.pop();
                    if (result != null) {
                      context.goNamed(
                        'Lobby',
                        pathParameters: {'lobbyId': result.id!},
                        extra: {'currentLobby': result},
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showError(
                          'Failed to create lobby',
                          Theme.of(context).colorScheme.error,
                        ),
                      );
                    }
                  }
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
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                CustomTextInput(
                  label: 'Title',
                  controller: _titleInput,
                  validator: isEmpty,
                ),
                CustomTextInput(
                  label: 'Destination',
                  controller: _destInput,
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
                        _datePicked = await showDateRangePicker(
                          context: context,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                        );
                        if (_datePicked != null) {
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
                              _datePicked != null
                                  ? (_datePicked!.duration.inDays == 0
                                      ? "${DateFormat('MMM d').format(_datePicked!.start)}"
                                      : "${DateFormat('MMM d').format(_datePicked!.start)} - ${DateFormat('MMM d').format(_datePicked!.end)}")
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
