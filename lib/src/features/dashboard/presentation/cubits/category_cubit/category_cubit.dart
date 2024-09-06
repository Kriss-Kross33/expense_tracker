import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState());

  void onCategorySelected(String category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
