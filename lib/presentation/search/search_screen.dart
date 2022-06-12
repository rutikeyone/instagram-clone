import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/search_cubit/search_cubit.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/search/body_state/loading_body.dart';
import 'package:instagram_clone/presentation/search/body_state/posts_body.dart';
import 'package:instagram_clone/presentation/search/body_state/users_body.dart';

class SearchScreen extends StatefulWidget {
  final SearchCubit searchCubit;
  const SearchScreen({Key? key, required this.searchCubit}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    widget.searchCubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Form(
            child: TextFormField(
              controller: widget.searchCubit.searchController,
              decoration:
                  InputDecoration(labelText: S.of(context).search_for_a_user),
              onChanged: (value) => widget.searchCubit.onSearchChanged(value),
            ),
          ),
        ),
        body: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SearchLoading) {
              return const LoadingBody();
            }

            if (state is SearchPosts) {
              return PostsBody(posts: state.posts);
            }

            if (state is SearchUsers) {
              return UsersBody(
                users: state.users,
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.searchCubit.dispose();
    super.dispose();
  }
}
