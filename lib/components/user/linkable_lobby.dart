import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:provider/provider.dart';

class LinkableLobby extends StatefulWidget {
  final RentalModel? rental;
  const LinkableLobby({
    super.key,
    this.rental,
  });

  @override
  State<LinkableLobby> createState() => _LinkableLobbyState();
}

class _LinkableLobbyState extends State<LinkableLobby> {
  LinkableLobbyModel? _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LinkableLobbyModel());
    _model?.lobbies = context.read<FFAppState>().activeLobbies;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _model?.lobbies?.length,
              itemBuilder: (context, index) {
                final lobby = _model?.lobbies?[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Add expense'),
                              content: Text(
                                'Add this rental to a lobby\'s expenses?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return FutureBuilder(
                                          future: _model!.linkRentalToLobby(
                                            widget.rental!.licensePlate!,
                                            widget.rental!.price!,
                                            index,
                                          ),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            return AlertDialog(
                                              title: Text('Success'),
                                              content: Text(
                                                  'Rental successfully linked to a lobby.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    context.goNamed(
                                                        'MainDashboard');
                                                  },
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                    // _model.linkRentalToLobby(price, index)
                                  },
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text('Cancel'),
                                )
                              ],
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IntrinsicHeight(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VerticalDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(lobby!.title!),
                                    Text(
                                        "${lobby.participants!.length} people"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Planned date'),
                                    Text(
                                      lobby.startDate != null
                                          ? '${DateFormat('MMM d').format(lobby.startDate!)} - ${DateFormat('MMM d').format(lobby.endDate!)}'
                                          : '-',
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class LinkableLobbyModel extends FlutterFlowModel {
  List<LobbyModel>? lobbies;
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  Future<bool> linkRentalToLobby(
      String licensePlate, double price, int index) async {
    final linkedLobby = lobbies![index];
    final expense = ExpenseModel(items: {'Car rental': price});
    return await UserController.linkRentalToLobby(
      expense,
      linkedLobby.id!,
      licensePlate,
    );
  }
}
