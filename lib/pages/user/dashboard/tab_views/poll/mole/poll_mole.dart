import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/widgets/atoms/poll_choices.dart';
import 'package:provider/provider.dart';

class PollMolecule extends StatefulWidget {
  final String? lobbyId;
  final int? index;
  const PollMolecule({
    super.key,
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
    _model = createModel(context, () => PollMoleModel());
  }

  @override
  Widget build(BuildContext context) {
    _model.poll = context.watch<LobbyProvider>().polls[widget.index!];
    _model.count();
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _model.poll!.question!,
            ),
            Divider(),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _model.poll!.choices!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.zero,
                  color: index == _model.selectedIndex
                      ? Theme.of(context).primaryColor
                      : null,
                  child: AbsorbPointer(
                    absorbing: !_model.poll!.isOpen!,
                    child: InkWell(
                      customBorder: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onTap: () async {
                        // await _model.votePoll(
                        //   index,
                        //   widget.lobbyId!,
                        // );
                        _model.selectedIndex == index
                            ? _model.selectedIndex = null
                            : _model.selectedIndex = index;
                        var {'title': _, 'voters': voters as List} =
                            _model.poll?.choices![_model.selectedIndex == null
                                ? index
                                : _model.selectedIndex!]; // Selected choice
                        if (_model.hasVoted()) {
                          if (voters.any((voter) =>
                              voter == FFAppState().currentUser?.id)) {
                            voters.remove(FFAppState().currentUser?.id);
                          } else {
                            _model.removeVote();
                            voters.add(FFAppState().currentUser?.id);
                          }
                        } else {
                          voters.add(FFAppState().currentUser?.id);
                        }

                        setState(() {});
                      },
                      child: PollChoices(
                        choice: _model.poll?.choices![index]['title'],
                        count: _model.counts[index],
                        textColor:
                            index == _model.selectedIndex ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 24.0,
                  ),
                  onPressed: () {
                    // _model.deletePoll(widget.lobbyId!).then((value) {
                    //   Provider.of<LobbyProvider>(context, listen: false)
                    //       .removePoll(widget.index!);
                    // });
                    context.read<LobbyProvider>().removePoll(widget.index!);
                  },
                ),
                TextButton(
                  onPressed: () {
                    // _model.closePoll(widget.lobbyId!).then((uPoll) {
                    //   Provider.of<LobbyProvider>(context, listen: false)
                    //       .closePoll(widget.index!, uPoll);
                    // });
                    final uPoll = PollModel(
                      id: _model.poll?.id,
                      question: _model.poll?.question,
                      choices: _model.poll?.choices,
                      isOpen: !_model.poll!.isOpen!,
                    );
                    context
                        .read<LobbyProvider>()
                        .closePoll(widget.index!, uPoll);
                  },
                  child: Text(
                      _model.poll!.isOpen! ? 'Close poll' : 'Re-open poll'),
                ),
              ],
            ),
          ].divide(
            SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}

class PollMoleModel extends FlutterFlowModel {
  PollMoleModel();

  PollModel? poll;

  late List<int> counts;
  int? selectedIndex;

  @override
  void initState(BuildContext context) {}

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
  Future<PollModel> closePoll(String lobbyId) async {
    return await UserController.closePoll(lobbyId, poll!.id!);
  }

  // Delete a poll
  Future<List<PollModel>?> deletePoll(String lobbyId) async {
    return UserController.deletePoll(lobbyId, poll!.id!);
  }
}
