// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeInitial extends HomeState {
  final int pageIndex;
  final model.User user;

  @override
  List<Object> get props => [user, pageIndex];
  const HomeInitial({required this.user, required this.pageIndex});

  HomeInitial copyWith({model.User? user, int? pageIndex}) {
    return HomeInitial(
      user: user ?? this.user,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
