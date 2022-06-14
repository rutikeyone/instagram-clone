import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  FavouriteCubit({required this.firebaseAuth, required this.firebaseFirestore})
      : super(FavouriteState());

  Stream<QuerySnapshot<Map<String, dynamic>>> get postsStream =>
      firebaseFirestore.collection('posts').snapshots();
}
