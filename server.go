package main  

import (
  "net/http"
  "os"
  "github.com/mattcarpowich1/simple_api/controllers"
  "github.com/mattcarpowich1/simple_api/db"
  "database/sql"
  "github.com/gorilla/handlers"
  "github.com/gorilla/mux"
  _ "github.com/lib/pq"
)

const connectionString = `
  user=matthewcarpowich
  dbname=shipt_challenge_db
  sslmode=disable`

func main() {
  var err error

  db.DBCon, err = sql.Open("postgres", connectionString)
  if err != nil {
    panic(err)
  }

  router := mux.NewRouter()
  router.HandleFunc("/api/products/breakdown", controllers.GetProductBreakdown(db.DBCon)).Methods("POST")
  http.Handle("/", router)
  http.ListenAndServe(":8080", handlers.LoggingHandler(os.Stdout, router))
}