
import 'package:bloc/bloc.dart';
import 'package:login_task/features/categories/model/login_model.dart';
import 'package:meta/meta.dart';

import '../../../network/api_const.dart';
import '../../../network/dio_helper.dart';
import '../../../network/hive_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginModel? loginModel;

  Future<void> login(Map<String, dynamic> data) async {
    emit(LoginLoading());

    try {
      final result = await DioHelper().postData(
        ApiConst.login,
        data: data,
      );

      if (result.statusCode == 200) {
        loginModel = LoginModel.fromJson(
          Map<String, dynamic>.from(result.data),
        );

        if (loginModel?.statusCode == 200 &&
            loginModel?.data?.token != null) {
          await HiveHelper.setToken(
            loginModel!.data!.token!,
          );

          emit(LoginSuccess());
        } else {
          emit(LoginError());
        }
      } else {
        emit(LoginError());
      }
    } catch (e) {
      emit(LoginError());
    }
  }
}
