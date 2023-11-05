import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/lobby_dashboard_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/poll_model.dart';

class LobbyDashboardWidget extends StatefulWidget {
  final String? lobbyId;
  const LobbyDashboardWidget({super.key, this.lobbyId});

  @override
  State<LobbyDashboardWidget> createState() => _LobbyDashboardWidgetState();
}

class _LobbyDashboardWidgetState extends State<LobbyDashboardWidget> {
  late LobbyDashboardModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LobbyDashboardModel());
    _model.fetchLobby(widget.lobbyId!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: _model.currentLobby == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${_model.currentLobby?.title}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Host: Peter Parker'),
                      Text('Meeting place: LLC'),
                    ],
                  ),
                  Divider(),
                  Text('Details'),
                  lobbyDetails(),
                  Text('Expenses'),
                  expenses(),
                  Text('Polls'),
                  polls(),
                ].divide(
                  SizedBox(
                    height: 10,
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
                Text('Meeting Place'),
                Text('LLC'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Meeting Time'),
                Text('9:00 AM'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Destination'),
                Text('Moalboal Cebu'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Planned Date'),
                Text('Oct. 1, 2023'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Budget'),
                Text('Min. 100 / person'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget expenses() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            if(_model.currentLobby!.budget?.keys == null || _model.currentLobby!.budget?.values == null)
                Text("No Budget Plans yet")
            else  
            ListView.separated(
                shrinkWrap: true,
                itemCount: _model.currentLobby!.budget!.length,
                separatorBuilder: (context, index) => Divider(
                      height: 10,
                    ),
                itemBuilder: (context, index) {
                  List<String> budgetCategories =
                      _model.currentLobby!.budget!.keys.toList();
                  List<double> budgetExpenses =
                      _model.currentLobby!.budget!.values.toList();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${budgetCategories[index]}"),
                      Text("₱${budgetExpenses[index]}"),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

 Widget polls() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            if (_model.currentLobby!.poll!.length == 0)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('No polls have been concluded yet.'),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                itemCount: _model.currentLobby!.poll!.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  PollModel poll = _model.currentLobby!.poll![index];
                  var highestChoice = highestCount(poll.choices!);

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${poll.question}"),
                        Text(
                          // "${highestChoice['title']} : ${highestChoice['count']}"),
                          "${highestChoice['title']}",
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
    Map<String, dynamic> highest = {'title': '', 'count': 0};

    // choices.forEach((choice) {
    //   if (choice['count'] >= highest['count']) highest = choice;
    // });
    return highest;
  }
}
