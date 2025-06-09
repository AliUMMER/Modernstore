import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/CreateBanner_api.dart';
import 'package:modern_grocery/repositery/model/CreateBanner_model.dart';

part 'create_banner_event.dart';
part 'create_banner_state.dart';

class CreateBannerBloc extends Bloc<CreateBannerEvent, CreateBannerState> {
  CreatebannerApi createbannerApi = CreatebannerApi();

  late CreateBannerModel createBannerModel;
  CreateBannerBloc() : super(CreateBannerInitial()) {
    on<fetchCreateBannerEvent>((event, emit) async {
      emit(CreateBannerLoading());
      try {
        createBannerModel = await createbannerApi.getCreateBannerModel();
      } catch (e) {
        print(e);
        emit(CreateBannerError());
      }
      // TODO: implement event handler
    });
  }
}
