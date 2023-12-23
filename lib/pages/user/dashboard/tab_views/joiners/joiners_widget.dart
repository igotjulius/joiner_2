import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/pages/user/dashboard/lobby/lobby_page_widget.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/joiners/modals/invite_participants_widget.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/widgets/molecules/participant_atom.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'joiners_model.dart';
export 'joiners_model.dart';

class JoinersWidget extends StatefulWidget {
  final FabController? fabController;
  final JoinersModel? model;
  const JoinersWidget(this.fabController, this.model, {super.key});

  @override
  _JoinersWidgetState createState() =>
      _JoinersWidgetState(fabController!, model!);
}

class _JoinersWidgetState extends State<JoinersWidget> {
  _JoinersWidgetState(FabController fabController, this._model) {
    fabController.onTapHandler = fabHandler;
  }
  late JoinersModel _model;
  late LobbyProvider _lobbyProvider;

  @override
  void initState() {
    super.initState();
    _lobbyProvider = context.read<LobbyProvider>();
    _model.currentLobby = _lobbyProvider.currentLobby;
    _model.fetchParticipants =
        UserController.getParticipants(_model.currentLobby!.id!);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_model.controller != null) _model.controller?.close();
    });
  }

  void fabHandler() {
    _model.controller = showBottomSheet(
      context: context,
      builder: (context) {
        return ListenableProvider.value(
          value: _lobbyProvider,
          child: InviteParticipantsWidget(),
        );
      },
    );
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<FFAppState>().currentUser!.id!;
    context.watch<LobbyProvider>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Joiners'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: displayParticipants(
                  _model.currentLobby!.participants!,
                  currentUserId,
                ), // _model.getParticipants(currentUserId),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayParticipants(
      List<ParticipantModel> participants, String currentUserId) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: participants.length,
      itemBuilder: (context, index) {
        bool showRemove = currentUserId == _model.currentLobby?.hostId &&
            _model.currentLobby?.hostId != participants[index].userId;
        return ParticipantMole(
          firstName: participants[index].firstName,
          lastName: participants[index].lastName,
          userId: participants[index].userId,
          suffixLabel: participants[index].joinStatus,
          showRemoveOption: showRemove,
        );
      },
    );
  }
}
