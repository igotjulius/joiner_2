import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_icon_button.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/widgets/atoms/poll_choices.dart';

class PollMolecule extends StatefulWidget {
  final PollModel? poll;
  final String? lobbyId;
  final int? index;
  const PollMolecule({
    super.key,
    this.poll,
    this.lobbyId,
    this.index,
  });

  @override
  State<PollMolecule> createState() => _PollMoleculeState();
}

class _PollMoleculeState extends State<PollMolecule> {
  late PollMoleModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollMoleModel(poll: widget.poll));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).secondaryText,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _model.poll!.question!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Roboto Flex',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _model.poll!.choices!.length,
                  itemBuilder: (context, index) {
                    return AbsorbPointer(
                      absorbing: !_model.poll!.isOpen!,
                      child: Material(
                        child: InkWell(
                          onTap: () async {
                            await _model.votePoll(
                              index,
                              widget.lobbyId!,
                            );
                            setState(() {});
                          },
                          child: PollChoices(
                            choice: _model.poll?.choices![index]['title'],
                            count: _model.counts[index],
                            color: index == _model.selectedIndex
                                ? Colors.blueAccent
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).primary,
                        borderRadius: 4.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.delete,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          _model.deletePoll(widget.lobbyId!);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          _model
                              .closePoll(widget.lobbyId!)
                              .then((_) => setState(() {}));
                        },
                        child: Text(_model.poll!.isOpen!
                            ? 'Close poll'
                            : 'Re-open poll'),
                      ),
                    ],
                  ),
                ),
              ].divide(
                SizedBox(
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PollMoleModel extends FlutterFlowModel {
  PollMoleModel({this.poll});

  PollModel? poll;

  late List<int> counts;
  int? selectedIndex;

  @override
  void initState(BuildContext context) {
    count();
  }

  @override
  void dispose() {}

  // Vote to a poll
  Future<void> votePoll(int index, String lobbyId) async {
    selectedIndex == index ? selectedIndex = null : selectedIndex = index;
    var {'title': title, 'voters': voters as List} = poll?.choices![
        selectedIndex == null ? index : selectedIndex!]; // Selected choice
    if (hasVoted()) {
      if (voters.any((voter) => voter == FFAppState().currentUser?.id)) {
        voters.remove(FFAppState().currentUser?.id);
      } else {
        removeVote();
        voters.add(FFAppState().currentUser?.id);
      }
    } else {
      voters.add(FFAppState().currentUser?.id);
    }

    await UserController.votePoll(title, lobbyId);
    count();
  }

  void removeVote() {
    var choices = poll?.choices;
    for (int i = 0; i < choices!.length; i++) {
      final voters = choices[i]['voters'] as List;
      voters.remove(FFAppState().currentUser!.id);
    }
  }

  // Count voters
  void count() {
    final choices = poll!.choices;
    counts = choices!.map((e) => (e['voters'] as List).length).toList();
    for (int i = 0; i < choices.length; i++) {
      final voters = choices[i]['voters'] as List;
      if (voters.any((voter) => voter == FFAppState().currentUser?.id)) {
        selectedIndex = i;
        break;
      }
    }
  }

  // Check if user has voted
  bool hasVoted() {
    bool alreadyVoted = false;
    final choices = poll?.choices;
    for (int i = 0; i < choices!.length; i++) {
      final voters = choices[i]['voters'] as List;
      alreadyVoted =
          voters.any((voter) => voter == FFAppState().currentUser!.id);
      if (alreadyVoted) break;
    }
    return alreadyVoted;
  }

  // Close a poll
  Future<void> closePoll(String lobbyId) async {
    poll = await UserController.closePoll(lobbyId, poll!.id!);
  }

  // Delete a poll
  Future<List<PollModel>?> deletePoll(String lobbyId) async {
    return UserController.deletePoll(lobbyId, poll!.id!);
  }
}
