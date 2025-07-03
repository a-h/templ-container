# github.com/a-h/templ-container

## Tasks

### build

```bash
docker build -t a-h/templ-container:latest .
```

### run

```bash
docker run -p 8080:8080 --rm a-h/templ-container:latest
```

### watch

```bash
templ generate --watch --proxy="http://localhost:8080" --cmd="go run ."
```
