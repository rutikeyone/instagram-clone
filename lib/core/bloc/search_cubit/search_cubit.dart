import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  late TextEditingController searchController;
  final FirebaseFirestore firebaseFirestore;
  SearchCubit({required this.firebaseFirestore})
      : super(const SearchPosts(posts: []));

  void init() {
    searchController = TextEditingController();
    _receivePosts();
  }

  void onSearchChanged(String value) {
    if (searchController.text.isNotEmpty) {
      emit(SearchLoading());
      _receiveUserBySearchValue(searchController.text);
    } else {
      _receivePosts();
    }
  }

  void _receiveUserBySearchValue(String value) async {
    final List<User> users = [];
    final snapshot = await firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: value)
        .get();
    final documents = snapshot.docs;

    for (QueryDocumentSnapshot<Map<String, dynamic>> document in documents) {
      final user = User.fromMap(document.data());
      users.add(user);
    }

    if (searchController.text.isNotEmpty) {
      emit(SearchUsers(users: users));
    }
  }

  void _receivePosts() async {
    final List<Post> posts = [];
    final snapshot = await firebaseFirestore
        .collection('posts')
        .orderBy('datePublished')
        .get();
    final documents = snapshot.docs;

    for (QueryDocumentSnapshot<Map<String, dynamic>> document in documents) {
      final Post post = Post.fromSnapshot(document);
      posts.add(post);
    }

    if (searchController.text.isEmpty) {
      emit(SearchPosts(posts: posts));
    }
  }

  void dispose() {
    searchController.dispose();
  }
}
