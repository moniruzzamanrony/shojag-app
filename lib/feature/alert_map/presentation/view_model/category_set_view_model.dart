class CategorySetViewModel {
  final String name;
  final int count;

  const CategorySetViewModel({required this.name, required this.count});

  CategorySetViewModel copyWith({
    String? name,
    int? count,
  }) {
    return CategorySetViewModel(
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }
}
