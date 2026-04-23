package main

import (
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"net/http"
)

func randomID() string {
	b := make([]byte, 16)
	_, err := rand.Read(b)
	if err != nil {
		return "random-failed"
	}
	return hex.EncodeToString(b)
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello world %s\n", randomID())
	})

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err)
	}
}