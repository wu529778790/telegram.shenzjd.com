FROM node:lts-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app
COPY package.json pnpm-lock.yaml ./

# FROM base AS prod-deps
# RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

FROM base AS build-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

FROM build-deps AS build
COPY . .

ARG SENTRY_DSN
ARG SENTRY_AUTH_TOKEN
ARG SENTRY_PROJECT

RUN export $(cat .env.example) && \
    export DOCKER=true && \
    pnpm run build

FROM base AS runtime
# COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist

ENV HOST=0.0.0.0
ENV PORT=4321
ENV CHANNEL=shenzjd_com
ENV LOCALE=zh-cn
ENV TIMEZONE=Asia/Shanghai
ENV GOOGLE_SEARCH_SITE=shenzjd.com
ENV TELEGRAM=shenzjd_com
ENV GITHUB=wu529778790
ENV NAVS=技术博客,https://blog.shenzjd.com;网盘资源,https://alist.shenzjd.com;今日热点,https://news.shenzjd.com;

EXPOSE 4321
CMD node ./dist/server/entry.mjs