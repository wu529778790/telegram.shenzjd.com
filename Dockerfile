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
ENV TELEGRAM=shenzjd
ENV GITHUB=wu529778790

EXPOSE 4321
CMD node ./dist/server/entry.mjs