import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/getAllBanner_api.dart';
import 'package:modern_grocery/repositery/model/getAllBanner%20Model.dart';

part 'get_all_banner_event.dart';
part 'get_all_banner_state.dart';

class GetAllBannerBloc extends Bloc<GetAllBannerEvent, GetAllBannerState> {
  GetallbannerApi getallbannerApi = GetallbannerApi();

  late GetAllBannerModel getAllBannerModel;

  GetAllBannerBloc() : super(GetAllBannerInitial()) {
    on<fetchGetAllBanner>((event, emit) async {
      emit(GetAllBannerLoading());
      try {
        getAllBannerModel = await getallbannerApi.getGetAllBannerModel();
        emit(GetAllBannerLoaded());
      } catch (e) {
        print(e);
        emit(GetAllBannerError());
      }
      // TODO: implement event handler
    });
  }
}
