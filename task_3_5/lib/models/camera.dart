class Camera {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Camera({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

List<Camera> cameras = [
  Camera(
      name: 'Ricoh GR IIIX (GR3 X)',
      description:
          'Компактная камера с высоким качеством изображения и отличной портативностью. Идеальна для уличной фотографии и путешествий.',
      price: 117000.0,
      imageUrl: 'assets/ricoh_gr_iiix.jpg'),
  Camera(
      name: 'Nikon Z6II Body',
      description:
          'Полноформатная беззеркальная камера с высокой производительностью и отличной системой автофокуса. Подходит для профессиональной съемки в различных условиях.',
      price: 138800.0,
      imageUrl: 'assets/nikon_z6ii_body.jpg'),
  Camera(
      name: 'Leica M11 Body Black',
      description:
          'Элегантная и высококачественная камера с классическим дизайном. Обеспечивает исключительное качество изображения и ручное управление для истинных ценителей фотографии.',
      price: 850000.0,
      imageUrl: 'assets/leica_m11_body_black.jpg'),
  Camera(
      name: 'Sony Alpha A7M4 ILCE-7M4 Body',
      description:
          'Мощная беззеркальная камера с высоким разрешением и продвинутыми функциями видео. Отличный выбор для профессионалов и энтузиастов.',
      price: 190000.0,
      imageUrl: 'assets/sony_alpha_ilce_7m4_body.jpg'),
  Camera(
      name: 'Canon EOS RP Body',
      description:
          'Легкая и доступная беззеркальная камера с полнокадровым сенсором. Идеальна для начинающих фотографов, желающих получить качественные снимки.',
      price: 70000.0,
      imageUrl: 'assets/canon_eos_rp_body.jpg'),
];
