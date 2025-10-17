# Run the Project Locally with Docker

## Prerequisites
- Docker installed and running
- Git

## 1. Clone the repository
```bash
git clone https://github.com/I-am-nk/hello-world-node-app.git
cd hello-world-node-app
```

## 2. Build the Docker image
Use the provided `Dockerfile` in the project root:
```bash
docker build -t hello-world-node-app .
```

## 3. Run the container
```bash
docker run -d -p 3000:3000 --name hello-world-app hello-world-node-app
```
What this does:
- Runs the container in detached mode (`-d`)
- Maps container port `3000` to local port `3000` (`-p 3000:3000`)
- Names the container `hello-world-app`

## 4. Access the application
Open your browser and go to:
```
http://localhost:3000
```
You should see `Hello World`.

---

Tips:
- To stop and remove the container:
```bash
docker stop hello-world-app
docker rm hello-world-app
```
- To view container logs:
```bash
docker logs -f hello-world-app
```