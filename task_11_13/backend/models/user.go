package models

type User struct {
	ID       int    `db:"id" json:"ID"`
	Name     string `db:"username" json:"Name"`
	Mail     string `db:"mail" json:"Mail"`
	Password string `db:"password"`
	Image    string `db:"image" json:"Image"`
	Phone    string `db:"phone_number" json:"Phone"`
}
