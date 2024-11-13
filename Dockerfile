FROM node:lts-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app
COPY package.json pnpm-lock.yaml ./

FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

# FROM base AS build-deps
# RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

FROM build-deps AS build
COPY . .
# 从 .env.example 中读取并导出环境变量
RUN grep -v '^#' .env.example > /app/.env && \
    pnpm run build

FROM base AS runtime
# COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/.env ./.env

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
# 在启动时加载环境变量
CMD export $(grep -v '^#' .env | xargs) && node ./dist/server/entry.mjs
