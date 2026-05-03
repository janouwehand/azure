package main

import (
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"net/http"
	"os"
	"time"
)

func randomID() string {
	b := make([]byte, 8)
	_, _ = rand.Read(b)
	return hex.EncodeToString(b)
}

func main() {
	http.HandleFunc("/write", func(w http.ResponseWriter, r *http.Request) {
		line := fmt.Sprintf("%s %s\n", time.Now().Format(time.RFC3339), randomID())

		f, err := os.OpenFile("/data/log.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}
		defer f.Close()

		_, err = f.WriteString(line)
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}

		fmt.Fprintf(w, "wrote %s", line)
	})

	http.ListenAndServe(":9090", nil)
}