import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/edit_lobby/edit_lobby_widget.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class LobbyDashboardWidget extends StatefulWidget {
  final String lobbyId;
  const LobbyDashboardWidget({super.key, required this.lobbyId});

  @override
  State<LobbyDashboardWidget> createState() => _LobbyDashboardWidgetState();
}

class _LobbyDashboardWidgetState extends State<LobbyDashboardWidget> {
  late TextStyle _textStyle;
  final DateFormat dateFormat = DateFormat('MMMM dd, yyyy');
  PersistentBottomSheetController? _controller;
  late LobbyModel _currentLobby;

  String hostParticipant() {
    String host = '';
    _currentLobby.participants!.forEach((element) {
      if (element.type!.toString() == 'Host')
        host = '${element.firstName} ${element.lastName}';
    });

    return host;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null) _controller?.close();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textStyle = Theme.of(context).textTheme.titleSmall!;
    final _textStyleMed = Theme.of(context).textTheme.titleMedium!;
    (context.watch<Auth?>() as UserController).activeLobbies.forEach((element) {
      if (element.id == widget.lobbyId) _currentLobby = element;
      return;
    });
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_currentLobby.title}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      _controller = showBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditLobbyWidget(
                            currentLobby: _currentLobby,
                          );
                        },
                      );
                    },
                    child: Text('Edit details'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Host: ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    hostParticipant(),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Joiners: ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    _currentLobby.participants!
                        .where((participant) => participant.type == 'Joiner')
                        .map((participant) =>
                            '${participant.firstName} ${participant.lastName}')
                        .join(', '),
                  ),
                ],
              ),
              Divider(),
              Text(
                'Details',
                style: _textStyleMed,
              ),
              lobbyDetails(),
              Text(
                'Expenses',
                style: _textStyleMed,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      expenses(),
                    ],
                  ),
                ),
              ),
              Text(
                'Polls',
                style: _textStyleMed,
              ),
              polls(),
            ].divide(
              SizedBox(
                height: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget lobbyDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Destination',
                  style: _textStyle,
                ),
                Text(
                  _currentLobby.destination!.isEmpty
                      ? '-'
                      : _currentLobby.destination!,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Planned Date',
                  style: _textStyle,
                ),
                Text(
                  _currentLobby.startDate == null
                      ? '-'
                      : dateFormat.format(_currentLobby.startDate!),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget',
                  style: _textStyle,
                ),
                _currentLobby.expense!.items!.isEmpty
                    ? Text('-')
                    : withCurrency(
                        Text(
                          '${_currentLobby.expense?.total?.toStringAsFixed(2)}',
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget expenses() {
    if (_currentLobby.expense!.items!.isEmpty)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Budget Plans yet',
            style: _textStyle,
          ),
        ],
      );
    else {
      final label = _currentLobby.expense?.items?.keys.toList();
      final value = _currentLobby.expense?.items?.values.toList();
      return ListView.separated(
        shrinkWrap: true,
        itemCount: _currentLobby.expense!.items!.length,
        separatorBuilder: (context, index) => Divider(
          height: 10,
        ),
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${label?[index]}"),
              withCurrency(
                Text("${value?[index].toStringAsFixed(2)}"),
              ),
            ],
          );
        },
      );
    }
  }

  Widget polls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_currentLobby.poll!.length == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No polls have been concluded yet',
                    style: _textStyle,
                  ),
                ],
              )
            else
              ListView.separated(
                shrinkWrap: true,
                itemCount: _currentLobby.poll!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  PollModel poll = _currentLobby.poll![index];
                  final highestChoice = highestCount(poll.choices!);

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${poll.question}"),
                        Text(
                          '${highestChoice['title']} : ${highestChoice['voters'].length}',
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> highestCount(List<dynamic> choices) {
    Map<String, dynamic> highest = {'title': '', 'voters': []};

    choices.forEach((choice) {
      if (choice['voters'].length >= highest['voters'].length) highest = choice;
    });
    return highest;
  }
}
