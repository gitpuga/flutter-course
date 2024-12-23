package main

type Product struct {
	ID          int
	Name        string
	Image       string
	Cost        int
	Describtion string
}

type User struct {
	ID    int
	Image string
	Name  string
	Phone string
	Mail  string
}

type ShopCartProduct struct {
	ID     int
	Count  int
	UserID int
}

type favoriteProduct struct {
	ID     int
	UserID int
}

var products = []Product{
	{
		ID:          1,
		Name:        "Ricoh GR IIIX (GR3 X)",
		Image:       "https://static.insales-cdn.com/images/products/1/378/589406586/6899a51e23c287fb9be21e9e2cc8ed53.jpg",
		Cost:        117000,
		Describtion: "Компактная камера с высоким качеством изображения и отличной портативностью. Идеальна для уличной фотографии и путешествий.",
	},
	{
		ID:          2,
		Name:        "Nikon Z6II Body",
		Image:       "https://static.insales-cdn.com/images/products/1/4423/710930759/a08dd663c9e96e44142a3d5d4b0b8bdc.jpg",
		Cost:        138800,
		Describtion: "Полноформатная беззеркальная камера с высокой производительностью и отличной системой автофокуса. Подходит для профессиональной съемки в различных условиях.",
	},
	{
		ID:          3,
		Name:        "Leica M11 Body Black",
		Image:       "https://static.insales-cdn.com/images/products/1/5910/595924758/Leica_Ludwig_black_front_resized.jpg",
		Cost:        850000,
		Describtion: "Элегантная и высококачественная камера с классическим дизайном. Обеспечивает исключительное качество изображения и ручное управление для истинных ценителей фотографии.",
	},
	{
		ID:          4,
		Name:        "Sony Alpha A7M4 ILCE-7M4 Body",
		Image:       "https://static.insales-cdn.com/images/products/1/2863/663005999/541006f2a9895d25094223a8bf8fe3f4.jpg",
		Cost:        190000,
		Describtion: "Мощная беззеркальная камера с высоким разрешением и продвинутыми функциями видео. Отличный выбор для профессионалов и энтузиастов.",
	},
	{
		ID:          5,
		Name:        "Canon EOS RP Body",
		Image:       "https://static.insales-cdn.com/images/products/1/555/474833451/f8c3c14e41bc278e1d190c4e651c729e__1_.jpg",
		Cost:        70000,
		Describtion: "Легкая и доступная беззеркальная камера с полнокадровым сенсором. Идеальна для начинающих фотографов, желающих получить качественные снимки.",
	},
	{
		ID:          6,
		Name:        "Nikon Coolpix P950",
		Image:       "https://static.insales-cdn.com/images/products/1/6450/575510834/b3c8a5075a2461fb5c7ae2cb764af75c.jpg",
		Cost:        75500,
		Describtion: "Компактная суперзум-камера с 16 МП сенсором и 83-кратным оптическим зумом, позволяющим снимать объекты на большом расстоянии.",
	},
	{
		ID:          7,
		Name:        "Canon EOS R10 Body",
		Image:       "https://static.insales-cdn.com/images/products/1/764/595395324/58dd38b4e0450ef3de543472528f7174.jpg",
		Cost:        72000,
		Describtion: "Беззеркальная камера начального уровня с 24 МП APS-C сенсором и быстрой автофокусировкой, обеспечивающей 7 кадров в секунду.",
	},
	{
		ID:          8,
		Name:        "Fujifilm X-T50 Body Black",
		Image:       "https://static.insales-cdn.com/images/products/1/7778/883621474/1715824013_1827209.jpg",
		Cost:        125000,
		Describtion: "Стильная беззеркальная камера с 26.1 МП APS-C X-Trans CMOS 4 сенсором и быстрой автофокусировкой, обеспечивающей 8 кадров в секунду.",
	},
}
