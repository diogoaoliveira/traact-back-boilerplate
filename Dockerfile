# Generate build from typescript

FROM node:16 as builder
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build


# Build for production
FROM node:16
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn install --production --frozen-lockfile
COPY --from=builder /app/dist ./dist
CMD yarn start:prod

