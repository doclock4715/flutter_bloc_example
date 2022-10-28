import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/app_blocs.dart';
import 'package:flutter_bloc_example/blocs/app_events.dart';
import 'package:flutter_bloc_example/blocs/app_state.dart';
import 'package:flutter_bloc_example/models/random_number.dart';
import 'package:flutter_bloc_example/repositories/repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/spacex_model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bloc Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: const ConstantScrollBehavior(),
      home: RepositoryProvider(
        create: (context) => SpaceXRepostitory(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpaceXBloc(
        RepositoryProvider.of<SpaceXRepostitory>(context),
      )..add(LoadSpaceXEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<SpaceXBloc, SpaceXState>(
          builder: (context, state) {
            if (state is SpaceXLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SpaceXLoadedState) {
              List<SpaceX> spaceXLaunches = state.spaceXLaunches;
              List<RandomNumber> randomNumber = state.randomNumber;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Image.asset(
                      "assets/images/SpaceX-Logo.png",
                      color: Colors.white,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.black,
                    stretch: true,
                    onStretchTrigger: () async {
                      context.read<SpaceXBloc>().add(LoadSpaceXEvent());
                    },
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (context, index) {
                        return Card(
                          shadowColor: Colors.grey,
                          elevation: 10,
                          margin: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 250,
                                  width: 300,
                                  child: Image.network(
                                      spaceXLaunches.last.links?.patch?.small ??
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                                      fit: BoxFit.fill),
                                ),
                              ),
                              LaunchDetailListTile(
                                title: 'Project Name: ',
                                valueText: spaceXLaunches.last.name ??
                                    "No name provided for this launch.",
                              ),
                              LaunchDetailListTile(
                                title: 'Details of the project: ',
                                valueText: spaceXLaunches.last.details ??
                                    "No details provided for this launch.",
                              ),
                              LaunchDetailListTile(
                                title: 'Date time of the launch: ',
                                valueText: DateFormat('yyyy-MM-dd').format(
                                  DateFormat('yyyy-MM-dd').parse(
                                      spaceXLaunches.last.dateLocal ?? ""),
                                ),
                              ),
                              spaceXLaunches.last.links?.article != null
                                  ? TextButton(
                                      onPressed: () async {
                                        final Uri url = Uri.parse(spaceXLaunches
                                                .last.links?.article ??
                                            "https://www.google.com");
                                        if (!await launchUrl(url)) {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: const Text("Go to article"),
                                    )
                                  : const Text(
                                      "No article link provided for this launch.",
                                      style: TextStyle(fontSize: 16),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "I put this text for trying pull to refresh ability whether working correctly or not. If the number changes in every refresh, then it is okay. Number: ${randomNumber.first.random}",
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class LaunchDetailListTile extends StatelessWidget {
  const LaunchDetailListTile({
    Key? key,
    required this.title,
    required this.valueText,
  }) : super(key: key);

  final String title;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextSpan(
              text: valueText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
