package main

import (
	"log/slog"
	"net/http"
	"os"

	"github.com/a-h/templ"
)

func main() {
	log := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	log.Info("Starting server", slog.Int("port", 8080))
	component := Page()
	http.Handle("/", templ.Handler(component))
	http.ListenAndServe(":8080", nil)
}
