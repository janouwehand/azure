package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		resp, err := http.Get("http://localhost:9090/write")
		if err != nil {
			http.Error(w, "writer call failed: "+err.Error(), 500)
			return
		}
		defer resp.Body.Close()

		b, _ := io.ReadAll(resp.Body)
		file, err := os.ReadFile("/data/log.txt")
		if err != nil {
			http.Error(w, "read failed: "+err.Error(), 500)
			return
		}

		fmt.Fprintf(w, "writer: %s\n\nshared file:\n%s", string(b), string(file))
	})

	http.ListenAndServe(":8080", nil)
}