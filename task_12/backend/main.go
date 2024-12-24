package main

import (
	"log"
	"shopApi/db"
	"shopApi/handlers"

	"github.com/gin-gonic/gin"
)

func main() {
	// Подключаемся к базе данных
	db, err := db.ConnectDB()
	if err != nil {
		log.Fatal("Ошибка подключения к БД:", err)
	}

	router := gin.Default()

	// Роуты для продуктов
	router.GET("/products/:userId", handlers.GetProducts(db))
	router.GET("/products/:userId/:id", handlers.GetProduct(db))
	router.POST("/products", handlers.CreateProduct(db))
	router.PUT("/products/:id", handlers.UpdateProduct(db))
	router.DELETE("/products/:id", handlers.DeleteProduct(db))

	// Роуты для корзины
	router.GET("/cart/:userId", handlers.GetCart(db))
	router.POST("/cart/:userId", handlers.AddToCart(db))
	router.PUT("/cart/:userId", handlers.UpdateShopCart(db))
	router.DELETE("/cart/:userId/:productId", handlers.RemoveFromCart(db))

	// Роуты для избранного
	router.GET("/favorites/:userId", handlers.GetFavorites(db))
	router.POST("/favorites/:userId", handlers.AddToFavorites(db))
	router.DELETE("/favorites/:userId/:productId", handlers.RemoveFromFavorites(db))

	// Роуты для пользователя
	router.GET("/users/:userId", handlers.GetUser(db))
	router.POST("/users", handlers.CreateNewUser(db))
	router.PUT("/users/:userId", handlers.UpdateUser(db))

	// Запуск сервера
	router.Run(":8080")
}
