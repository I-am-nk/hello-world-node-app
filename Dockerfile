# Stage 1: install dependencies (cached)
FROM node:20-alpine AS deps
WORKDIR /app

# copy only package files to leverage Docker layer caching
COPY package*.json ./

# production install only (omit dev dependencies)
RUN npm ci --omit=dev

# Stage 2: Runtime
FROM node:20-alpine AS runner
WORKDIR /app

# set production env
ENV NODE_ENV=production


# copy installed deps from previous stage
COPY --from=deps /app/node_modules ./node_modules

# copy app source
COPY . .

# use a non-root user for safety
USER node

# expose the port the app runs on
EXPOSE 3000
CMD ["node", "src/app.js"]
