// get_all_banner_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/banner/getAllBanner_api.dart';
import 'package:modern_grocery/repositery/model/Banner/getAllBanner%20Model.dart';

part 'get_all_banner_event.dart';
part 'get_all_banner_state.dart';

class GetAllBannerBloc extends Bloc<GetAllBannerEvent, GetAllBannerState> {
  GetallbannerApi getallbannerApi = GetallbannerApi();

  // late GetAllBannerModel getAllBannerModel;

  GetAllBannerBloc() : super(GetAllBannerInitial()) {
    on<fetchGetAllBanner>((
      event,
      emit,
    ) async {
      emit(GetAllBannerLoading());
      try {
         final getAllBannerModel= await getallbannerApi.getGetAllBannerModel();

        emit(GetAllBannerLoaded(getAllBannerModel));
      } catch (e) {
        print('Error in GetAllBannerBloc: $e');

        emit(GetAllBannerError(errorMessage: e.toString()));
      }
    });
  }
}
