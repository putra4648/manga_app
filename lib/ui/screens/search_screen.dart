import 'package:flutter/material.dart';
import 'package:manga_app/logic/logic.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search anime',
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              onSubmitted: (_) {
                context
                    .read<SearchBloc>()
                    .add(SearchEventRequested(search: controller.text));
                controller.clear();
              },
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SearchLoadedSuccess) {
                  return Column(
                    children: state.mangas
                        .map(
                          (manga) => ListTile(
                            onTap: () {},
                            title: Text(
                              manga.title,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        )
                        .toList(),
                  );
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
