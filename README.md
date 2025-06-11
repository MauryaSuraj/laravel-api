# Laravel Dockerized Setup 🚀

This repository contains a fully containerized Laravel application using Docker Compose.  
It includes:

- PHP-FPM (Laravel)
- Nginx
- PostgreSQL
- Redis
- Supervisor (for queue workers & scheduler)

---

## 🔧 Tech Stack

| Service   | Version | Notes           |
|-----------|---------|------------------|
| Laravel   | latest  | Laravel app code |
| PHP       | 8.x     | PHP-FPM          |
| Nginx     | stable-alpine | Web server |
| PostgreSQL| 15      | Database         |
| Redis     | latest  | Cache & Queues   |
| Supervisor| latest  | Queue & Scheduler management |

---

## 📦 Project Structure

```bash
.
├── app/ (your Laravel app code)
├── docker/
│   ├── nginx/
│   │   └── default.conf  # Nginx configuration
│   └── supervisord/
│       └── supervisord.conf  # Supervisor configuration
├── docker-compose.yml
├── Dockerfile
└── README.md
