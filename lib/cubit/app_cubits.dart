import 'package:bloc/bloc.dart';
import 'package:learn/cubit/app_cubit_states.dart';
import 'package:learn/model/data_intership_model.dart';
import '../services/data_services.dart';

class AppCubits extends Cubit<CubitStates>{
  AppCubits({required this.data}) : super(InitialState()){
    emit(WelcomeState());
  }
  final DataServices data;
  late final interships;
  void getData ()async{
    try{
      emit(LoadingState());
      interships = await data.getInterships();
      emit(LoadedState(interships));

    }catch(e){
      print('Error: $e');
    }
  }
 detailPage(DataIntershipModel data){
    emit(DetailState(data));
 }
 goHome(){
    emit(LoadedState(interships));
 }
 goFavorit(){
    emit(FavoriteState());
 }
 goWelcome(){
   emit(WelcomeState());
 }

}