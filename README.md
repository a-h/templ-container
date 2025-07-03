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
templ generate -watch -proxy="http://localhost:8080" -cmd="go run ."
```

### watch-in-container

```bash
docker run -p 8080:8080 -p 7331:7331 --rm \
  -v "$(pwd):/app" \
  -w /app \
  --entrypoint /bin/bash \
  a-h/templ-container:latest \
  -c 'templ generate -watch -proxy="http://localhost:8080" -cmd="go run ." -open-browser=false'
```
