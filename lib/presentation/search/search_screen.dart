import 'package:flutter/material.dart';
import 'package:instagram_clone/generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Form(
          child: TextFormField(
            decoration:
                InputDecoration(labelText: S.of(context).search_for_a_user),
            onFieldSubmitted: (String _) {},
          ),
        ),
      ),
    );
  }
}
