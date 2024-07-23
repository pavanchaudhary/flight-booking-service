package main

import (
	"database/sql"
	"fmt"
	"log"
	"sync"

	"github.com/go-sql-driver/mysql"
	"github.com/spf13/viper"
)

var mysqlConn *sql.DB

func GetMysqlConn() *sql.DB {
	if mysqlConn != nil {
		return mysqlConn
	}
	once := &sync.Once{}
	once.Do(func() {
		mysqlConfig := mysql.Config{
			User:   viper.GetString("database.mysql.user"),
			Passwd: viper.GetString("database.mysql.pass"),
			Net:    viper.GetString("database.mysql.net"),
			Addr:   fmt.Sprintf("%s:%s", viper.GetString("database.mysql.host"), viper.GetString("database.mysql.port")),
			DBName: viper.GetString("database.mysql.dbname"),
		}
		conn, err := sql.Open("mysql", mysqlConfig.FormatDSN())
		if err != nil {
			fmt.Println(err)
		}
		err = conn.Ping()
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println("MySQL DB is connected!")
		mysqlConn = conn
	})
	return mysqlConn
}

func setConfig() {
	viper.SetConfigFile("config.yaml")
	viper.AddConfigPath("./")
	err := viper.ReadInConfig()
	if err != nil {
		fmt.Println(err)
	}
}
