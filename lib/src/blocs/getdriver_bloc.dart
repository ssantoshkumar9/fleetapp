// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fleetly/src/models/getdriver_model.dart';
// import 'package:fleetly/src/repositories/get_drivers_repository.dart';
// import 'package:meta/meta.dart';


// abstract class GetDriversListEvent extends Equatable {
//   GetDriversListEvent([List props = const []]) : super(props);
// }

// abstract class GetDriversListState extends Equatable {
//   GetDriversListState([List props = const []]) : super(props);
// }
// class GetDriversListCount extends GetDriversListEvent {
//   final String id;

//    GetDriversListCount({this.id});
//       // : assert(id != null),
//       //   super([id]);
//   String toString() => 'FetchDrivers';
// }
// // class SkillsRefreshGridEvent extends SkillsEvent
// // {

// // }
// class NoDataFound extends GetDriversListState {
// //String errorData;
// //NoDataFound({@required this.errorData});
// // final List<Data> result;

// //   NoDataFound({@required this.result})
// //       : assert(result != null),
// //         super([result]);
// }

// class GetDriversListEmpty extends GetDriversListState {}
// class GetDriversListLoading extends GetDriversListState {}
// // class SkillsLoaded extends SkillsState {
// //   final List<Data> result;

// //   SkillsLoaded({@required this.result})
// //       : assert(result != null),
// //         super([result]);
// // }
// class GetDriversListLoaded extends GetDriversListState {
//    final GetDrivers result;

//   GetDriversListLoaded({@required this.result})
//       : assert(result != null),
//         super([result]);
// }
// class GetDriversListError extends GetDriversListState {}

// class GetDriversListBloc extends Bloc<GetDriversListEvent, GetDriversListState> {
//   String domainId;
//   final GetDriversListRepository getDriversListRepository;

//   GetDriversListBloc({@required this.getDriversListRepository})
//       : assert(getDriversListRepository != null);

//   @override
//   GetDriversListState get initialState => GetDriversListEmpty();

//   @override
//   Stream<GetDriversListState> mapEventToState(GetDriversListEvent event) async* {
//     //  if(event is SkillsRefreshGridEvent)
//     // {
//     //    yield SearchedListCountLoaded(result: allTheData());
//     //     return;
//     // }
//   if (event is GetDriversListCount) {
//       yield GetDriversListLoading();
//       try {
//         if (event.id == null){
//         final GetDrivers item = await getDriversListRepository.getDriversList();

//          yield GetDriversListLoaded(result: item);


//         }else{
//         final GetDrivers item = await getDriversListRepository.getDriversList();

//          yield GetDriversListLoaded(result: item);

//         }
//       }
//       // on DataNotFoundException{
//       //   //yield NoDataFound(result: allTheData());
//       //   return;
//       // }
//        catch (_) {
//         yield GetDriversListError();
//       }
//     }
// }
// }
