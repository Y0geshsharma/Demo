import 'package:equatable/equatable.dart';

abstract class AllEvent extends Equatable {}

class AllEventLoaded extends AllEvent {
  AllEventLoaded();

  @override
  List<Object> get props => [];
}
