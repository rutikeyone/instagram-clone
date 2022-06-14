import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/bloc/add_post_cubit/add_post_cubit.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart';
import 'package:instagram_clone/core/bloc/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';
import 'package:instagram_clone/core/bloc/search_cubit/search_cubit.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/core/service/firestore.dart';
import 'package:instagram_clone/core/service/impl/auth_impl.dart';
import 'package:instagram_clone/core/service/impl/firestore_impl.dart';
import 'package:instagram_clone/core/service/impl/picker_impl.dart';
import 'package:instagram_clone/core/service/impl/storage_impl.dart';
import 'package:instagram_clone/core/service/picker.dart';
import 'package:instagram_clone/core/service/storage.dart';
import 'package:instagram_clone/presentation/login/login_screen.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
  await Firebase.initializeApp();

  getIt.registerSingleton<Auth>(AuthImpl());

  getIt.registerSingleton<Picker>(PickerImpl());
  getIt.registerSingleton<Storage>(StorageImpl());
  getIt.registerSingleton<Firestore>(FirestoreImpl(
      storageService: getIt.get<Storage>(),
      firestore: FirebaseFirestore.instance));

  getIt.registerSingleton<LoginCubit>(LoginCubit(
    auth: getIt.get<Auth>(),
  ));
  getIt.registerSingleton<SignupCubit>(SignupCubit(
    auth: getIt.get<Auth>(),
    picker: getIt.get<Picker>(),
    storage: getIt.get<Storage>(),
  ));
  getIt.registerSingleton<HomeCubit>(
      HomeCubit(loginCubit: getIt.get<LoginCubit>()));
  getIt.registerSingleton<AddPostCubit>(AddPostCubit(
    firestoreService: getIt.get<Firestore>(),
  ));
  getIt.registerSingleton<FeedPostCubit>(FeedPostCubit(
    firestoreService: getIt.get<Firestore>(),
  ));
  getIt.registerSingleton<CommentsCubit>(
    CommentsCubit(
      firestore: getIt.get<Firestore>(),
    ),
  );
  getIt.registerSingleton<SearchCubit>(
      SearchCubit(firebaseFirestore: FirebaseFirestore.instance));
  getIt.registerSingleton<ProfileCubit>(ProfileCubit());
}

Future<void> precachePictures() async {
  await Future.wait([
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder, 'assets/ic_instagram.svg'),
      null,
    ),
  ]);
}
