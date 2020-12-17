import 'package:cached_network_image/cached_network_image.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manga_app/logic/logic.dart';
import 'package:manga_app/ui/widgets/custom_style_hook.dart';

class ScheduleScreen extends StatelessWidget {
  final TabController tabController;

  const ScheduleScreen({Key key, @required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Anime Schedule'),
      ),
      bottomNavigationBar: StyleProvider(
        style: CustomStyleHook(),
        child: ConvexAppBar(
          controller: tabController,
          backgroundColor: Theme.of(context).appBarTheme.color,
          elevation: 0,
          style: TabStyle.flip,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: FontAwesomeIcons.calendarAlt, title: 'Schedule'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child:
                  Text('Today', style: Theme.of(context).textTheme.headline4),
            ),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleLoading) {
                  return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
                if (state is ScheduleLoadedSuccess) {
                  final schedules = state.mangas;
                  return Column(
                    children: schedules
                        .map(
                          (schedule) => Container(
                            margin: const EdgeInsets.all(10),
                            height: size.height * 0.3,
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: size.height,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: CachedNetworkImageProvider(
                                        schedule.imageUrl,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          schedule.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          schedule.synopsis ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Chip(
                                          avatar: CircleAvatar(
                                            child: Icon(Icons.star_outline),
                                          ),
                                          label: Text(
                                            schedule.score.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
                if (state is ScheduleFailure) {
                  return Text('Error');
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
