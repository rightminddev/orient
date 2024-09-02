class OnboardingModel {
  final String title;
  final String image;
  final String description;
  OnboardingModel(
      {required this.title, required this.image, required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'info': description,
    };
  }

  factory OnboardingModel.fromMap(Map<String, String> map) {
    return OnboardingModel(
      title: map['title'] ?? "",
      image: map['image'] ?? "",
      description: map['info'] ?? "",
    );
  }
}
