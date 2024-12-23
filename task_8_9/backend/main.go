package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

type Product struct {
	ID          int
	Name        string
	Image       string
	Cost        float64
	Describtion string
	Favorite    bool
	ShopCart    bool
	Count       int
}

type User struct {
	ID    int
	Image string
	Name  string
	Phone string
	Mail  string
}

var users = []User{{
	ID:    1,
	Image: "https://avatars.githubusercontent.com/u/118254224?v=4&size=512",
	Name:  "Наумов Святозар Русланович",
	Phone: "8(999)999-99-99",
	Mail:  "svyatozar1@gmail.com",
}}

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

// обработчик для GET-запроса, возвращает список продуктов
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	json.NewEncoder(w).Encode(products)
}

// обработчик для POST-запроса, добавляет продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)

	newProduct.ID = products[len(products)-1].ID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

// Добавление маршрута для получения одного продукта
func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// удаление продукта по id
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем и удаляем продукт с данным ID
	for i, Product := range products {
		if Product.ID == id {
			// Удаляем продукт из среза
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent) // Успешное удаление, нет содержимого
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта по id
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, Product := range products {
		if Product.ID == id {
			products[i].Name = updatedProduct.Name
			products[i].Image = updatedProduct.Image
			products[i].Cost = updatedProduct.Cost
			products[i].Describtion = updatedProduct.Describtion
			products[i].Favorite = updatedProduct.Favorite
			products[i].ShopCart = updatedProduct.ShopCart
			products[i].Count = updatedProduct.Count

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func getFavoriteProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	var favoriteProducts = []Product{}

	for _, Product := range products {
		if Product.Favorite == true {
			w.Header().Set("Content-Type", "application/json")
			favoriteProducts = append(favoriteProducts, Product)
		}
	}

	json.NewEncoder(w).Encode(favoriteProducts)
}

func getShopCartProductsHandler(w http.ResponseWriter, r *http.Request) {
	// Устанавливаем заголовки для правильного формата JSON
	w.Header().Set("Content-Type", "application/json")
	// Преобразуем список заметок в JSON
	var shopCartProducts = []Product{}

	for _, Product := range products {
		if Product.ShopCart == true {
			w.Header().Set("Content-Type", "application/json")
			shopCartProducts = append(shopCartProducts, Product)
		}
	}

	json.NewEncoder(w).Encode(shopCartProducts)
}

func getUserByIDHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем ID из URL
	idStr := r.URL.Path[len("/Users/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Ищем продукт с данным ID
	for _, user := range users {
		if user.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(user)
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func updateUserHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}
	// Получаем ID из URL
	idStr := r.URL.Path[len("/users/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	// Декодируем обновлённые данные продукта
	var updatedUser User
	err = json.NewDecoder(r.Body).Decode(&updatedUser)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	// Ищем продукт для обновления
	for i, user := range users {
		if user.ID == id {
			users[i].Name = updatedUser.Name
			users[i].Image = updatedUser.Image
			users[i].Phone = updatedUser.Phone
			users[i].Mail = updatedUser.Mail

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}

	// Если продукт не найден
	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)           // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)  // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)       // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler) // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler) // Удалить продукт

	http.HandleFunc("/favorite_products", getFavoriteProductsHandler)
	http.HandleFunc("/shop_cart_products", getShopCartProductsHandler)

	http.HandleFunc("/users/", getUserByIDHandler)
	http.HandleFunc("/users/update/", updateUserHandler)

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}
