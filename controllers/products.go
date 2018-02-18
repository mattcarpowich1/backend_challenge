package controllers

import (
  "net/http"
  "encoding/json"
  "database/sql"
  "fmt"
  "io/ioutil"
  // "time"
  "github.com/mattcarpowich1/simple_api/db"
)

var (
  dateRange db.DateRange
  productBreakdown db.ProductBreakdown
  err error
)

func GetProductBreakdown(dbCon *sql.DB) http.HandlerFunc {
  fn := func(w http.ResponseWriter, r *http.Request) {
    body, err := ioutil.ReadAll(r.Body)
    defer r.Body.Close()
    if err != nil {
      panic(err)
    }

    err = json.Unmarshal(body, &dateRange)
    if err != nil {
      panic(err)
    }

    err, productBreakdown = db.FetchOrderedProducts(dbCon, &dateRange)
    if err != nil {
      panic(err)
    }

    fmt.Println(productBreakdown)
    // moodsJson, err := json.Marshal(moods)
    // if err != nil {
    //   panic(err)
    // }

    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    // w.Write(moodsJson)
  }

  return fn

}