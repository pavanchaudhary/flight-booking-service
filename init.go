package main

import (
	"database/sql"
	"fmt"
	"os"
	"sync"

	"github.com/go-sql-driver/mysql"
	"gopkg.in/yaml.v2"
)

type config struct {
	server struct {
		host string `yaml: "server"`
		port int    `yaml: "port"`
	}
	database struct {
		mysql struct {
			host   string `yaml: "host"`
			port   int    `yaml: "port"`
			user   string `yaml: "user"`
			pass   string `yaml: "pass"`
			net    string `yaml: "net"`
			dbname string `yaml: "dbname"`
		}
	}
}

func getConfig() *config {
	var cfg *config
	configFile, err := os.Open("config.yaml")
	if err != nil {
		fmt.Println(err)
	}
	defer configFile.Close()
	err = yaml.NewDecoder.Decode(cfg)
	if err != nil {
		fmt.Println(err)
	}
	return cfg
}

var mysqlConn *sql.DB

func GetMysqlConn(cfg *config) *sql.DB {
	if mysqlConn != nil {
		return mysqlConn
	}
	once := &sync.Once{}
	once.Do(func() {
		mysqlConfig := mysql.Config{
			User:   cfg.database.mysql.user,
			Passwd: cfg.database.mysql.pass,
			Net:    cfg.database.mysql.net,
			Addr:   fmt.Sprintf("%s:%d", cfg.database.mysql.host, cfg.database.mysql.port),
			DBName: cfg.database.mysql.dbname,
		}
		conn, err := sql.Open("mysql", mysqlConfig.FormatDSN())
		if err != nil {
			fmt.Println(err)
		}
		mysqlConn = conn
	})
	return mysqlConn
}

func init() {
	cfg := getConfig()
	GetMysqlConn(cfg)
}
