import 'package:equatable/equatable.dart';
import '../model/data_intership_model.dart';

abstract class CubitStates extends Equatable{

}
class InitialState extends CubitStates{
  @override
  // TODO: implement props
  List<Object> get props =>
      [];

}
class WelcomeState extends CubitStates{
  @override
  // TODO: implement props
  List<Object> get props =>
      [];

}

class LoadingState extends CubitStates{
  @override
  // TODO: implement props
  List<Object> get props =>
      [];

}

class LoadedState extends CubitStates {
  LoadedState(this.interships);
  final List<DataIntershipModel> interships;
  @override
  List<Object> get props => [ interships];
}

class DetailState extends CubitStates{
  DetailState(this.data);
  final DataIntershipModel data;

  @override
  // TODO: implement props
  List<Object> get props =>
      [data];

}
class FavoriteState extends CubitStates {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
