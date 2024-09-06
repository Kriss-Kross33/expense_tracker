part of 'category_cubit.dart';

final class CategoryState extends Equatable {
  const CategoryState({this.selectedCategory = ''});

  final String selectedCategory;

  CategoryState copyWith({String? selectedCategory}) {
    return CategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object> get props => [selectedCategory];
}
