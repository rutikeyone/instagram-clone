part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeInitial extends HomeState {
  final model.User user;

  @override
  List<Object> get props => [user];
  const HomeInitial(this.user);
}
