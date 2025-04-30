import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modern_grocery/repositery/api/getUserProfile_api.dart';
import 'package:modern_grocery/repositery/model/getUserProfile.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  GetuserprofileApi getuserprofileApi = GetuserprofileApi();

  late GetUserProfile getUserProfile;

  UserprofileBloc() : super(UserprofileInitial()) {
    on<fetchUserprofile>((event, emit) async {
      emit(Userprofileloading());
      try {
        getUserProfile = await getuserprofileApi.getGetUserProfile();

        emit(Userprofileloaded());
      } catch (e) {
        print(e);
        emit(UserprofileError());
      }

      // TODO: implement event handler
    });
  }
}
