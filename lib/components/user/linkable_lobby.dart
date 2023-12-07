import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/utils.dart';
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
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _model?.lobbies == null
                ? Text('You haven\'t joined a lobby yet')
                : ListView.builder(
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
                                          showDialogLoading(context);
                                          _model
                                              ?.linkRentalToLobby(
                                            widget.rental!,
                                            widget.rental!.price!,
                                            index,
                                          )
                                              .then(
                                            (isSuccess) {
                                              if (isSuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  showSuccess(
                                                      'Rental successfully linked to a lobby'),
                                                );
                                                context
                                                    .goNamed('MainDashboard');
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  showError(
                                                    'Rental linking to a lobby failed',
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                                  ),
                                                );
                                              }
                                            },
                                          );
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(lobby!.title!),
                                          Text(
                                              "${lobby.participants!.length} people"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
      RentalModel rental, double price, int index) async {
    final linkedLobby = lobbies![index];
    return await UserController.linkRentalToLobby(
      rental,
      linkedLobby.id!,
    );
  }
}
