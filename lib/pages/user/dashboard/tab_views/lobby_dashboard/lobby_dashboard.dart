import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/pages/user/dashboard/edit_lobby/edit_lobby_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/lobby_dashboard/lobby_dashboard_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/utils/utils.dart';

class LobbyDashboardWidget extends StatefulWidget {
  final LobbyDashboardModel? model;
  final String? lobbyId;
  const LobbyDashboardWidget({super.key, this.lobbyId, this.model});

  @override
  State<LobbyDashboardWidget> createState() => _LobbyDashboardWidgetState();
}

class _LobbyDashboardWidgetState extends State<LobbyDashboardWidget> {
  late LobbyDashboardModel _model;
  late TextStyle _textStyle;
  PersistentBottomSheetController? _controller;

  @override
  void initState() {
    super.initState();
    _model = widget.model!;
    _model.fetchLobby(widget.lobbyId!);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller != null) _controller?.close();
    });
  }

  final DateFormat dateFormat = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    _textStyle = Theme.of(context).textTheme.titleSmall!;
    final _textStyleMed = Theme.of(context).textTheme.titleMedium!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
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
                    "${_model.currentLobby?.title}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      _controller = showBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditLobbyWidget(
                            currentLobby: _model.currentLobby,
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
                    _model.hostParticipant(),
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
                    _model
                        .getAllParticipants()
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
                  _model.currentLobby!.destination!.isEmpty
                      ? '-'
                      : _model.currentLobby!.destination!,
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
                  _model.currentLobby!.startDate == null
                      ? '-'
                      : dateFormat.format(_model.currentLobby!.startDate!),
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
                _model.currentLobby!.expense == null ||
                        _model.currentLobby!.expense!.items!.isEmpty
                    ? Text('-')
                    : withCurrency(
                        Text(
                          '${_model.currentLobby?.expense?.total}',
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
    if (_model.currentLobby!.expense == null ||
        _model.currentLobby!.expense!.items!.isEmpty)
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
      final label = _model.currentLobby?.expense?.items?.keys.toList();
      final value = _model.currentLobby?.expense?.items?.values.toList();
      return ListView.separated(
        shrinkWrap: true,
        itemCount: _model.currentLobby!.expense!.items!.length,
        separatorBuilder: (context, index) => Divider(
          height: 10,
        ),
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${label?[index]}"),
              withCurrency(
                Text("${value?[index]}"),
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
            if (_model.currentLobby!.poll == null ||
                _model.currentLobby!.poll!.length == 0)
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
                itemCount: _model.currentLobby!.poll!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  PollModel poll = _model.currentLobby!.poll![index];
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
