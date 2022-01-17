import 'package:flutter/material.dart';
import 'package:ldapp/models/contestant/contestant.dart';
import 'package:ldapp/models/game/game.dart';
import 'package:ldapp/utils/appcolors.dart';
import 'package:provider/provider.dart';

class LeaderBoardersList extends StatelessWidget {
  const LeaderBoardersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentGameId = Provider.of<Game>(context).currentGameId;
    //Function To Get List Of Contestants

// Listen to the stream from sortedContestantsStream
    return StreamBuilder<List<Contestant>>(
      stream: Provider.of<Game>(context).sortedContestantsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return LeaderBoardTile(
                isOnFire: snapshot.data![index].isContestantOnFire,
                index: index,
                name: snapshot.data![index].name,
                position: index + 1,
                score: snapshot.data![index].totalScore,
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    // return Consumer<Game>(builder: (context, model, child) {
    //   model.getSortedGameContestantsList(currentGameId);
    //   return Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
    //     child: ListView.builder(
    //         itemCount: model.sortedContestantsList.length,
    //         itemBuilder: (_, index) {
    //           return LeaderBoardTile(
    //             index: index,
    //             name: model.sortedContestantsList[index].name,
    //             position: index + 1,
    //             score: model.sortedContestantsList[index].totalScore,
    //           );
    //         }),
    //   );
    // });
  }
}

class LeaderBoardTile extends StatelessWidget {
  final String name;
  final int position;
  final int score;
  final int index;
  final bool isOnFire;

  const LeaderBoardTile({
    Key? key,
    required this.name,
    required this.position,
    required this.score,
    required this.index,
    required this.isOnFire,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if contestant is on fire from sortedContestantsStream Stream

    bool isThisContestantOnFire = true;

    Color secondaryColorAppColor1 = position != 1
        ? AppColors.secondaryAppColor1
        : AppColors.specialGoldColor;
    Color secondaryColorAppColor2 = position != 1
        ? AppColors.secondaryAppColor2
        : AppColors.specialSecondaryGoldColor;
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        children: [
          // The Number
          Container(
            height: 70,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  secondaryColorAppColor1,
                  secondaryColorAppColor2,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              '$position',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black),
            ),
          ),

          // THE SPACING BETWEEN NUMBERS AND NAMES
          const SizedBox(width: 10),

          //THE NAME AND SCORE
          Expanded(
            child: Container(
              height: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    secondaryColorAppColor1,
                    secondaryColorAppColor2,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
              child: Row(
                children: [
                  //The Icon Button
                  Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x4D000000),
                      ),
                      child: isThisContestantOnFire
                          ? const Text(
                              '🔥',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                decorationColor: Colors.transparent,
                                shadows: [
                                  Shadow(color: Colors.transparent),
                                ],
                              ),
                            )
                          : const Text(
                              '❄️',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                decorationColor: Colors.transparent,
                                shadows: [
                                  Shadow(color: Colors.transparent),
                                ],
                              ),
                            )),
                  const SizedBox(width: 20),

                  SizedBox(
                    width: 700,
                    child: Text(
                      name.toUpperCase(),
                      // maxLines: 1,

                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),

                  Text(
                    '$score',
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
