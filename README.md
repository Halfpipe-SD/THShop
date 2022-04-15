[![Create and publish a Docker image](https://github.com/thieleju/THShop/actions/workflows/publish-docker-image.yml/badge.svg)](https://github.com/thieleju/THShop/actions/workflows/publish-docker-image.yml)
[![Build and Deploy to gh-pages](https://github.com/thieleju/THShop/actions/workflows/deploy-gh-pages.yml/badge.svg)](https://github.com/thieleju/THShop/actions/workflows/deploy-gh-pages.yml)

# THShop

TH-Shop with JWT Authentication and MariaDB

A push on the main branch deploys the frontend to github-pages and deploys a docker image as package

## How To Run

1. Create `.env.development` in `thshop-middleware`

> Example .env.development

```env
SERVER_PORT=3333
CORS_ORIGIN=http://localhost:8080
TOKEN_EXPIRE=1d
JWT_SECRET=
DB_HOST=
DB_USER=
DB_PASSWORD=
DB_NAME=
```

2. Run `npm run dev` in `thshop` and `thshop-middleware`
