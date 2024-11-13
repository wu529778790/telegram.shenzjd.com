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

ENV CHANNEL=shenzjd_com
ENV LOCALE=zh-cn
ENV TIMEZONE=Asia/Shanghai
ENV TELEGRAM=shenzjd
ENV TWITTER=
ENV GITHUB=wu529778790
ENV DISCORD=https://DISCORD.com
ENV PODCASRT=https://PODCASRT.com
ENV MASTODON=mastodon.social/@Mastodon
ENV BLUESKY=bsky.app
ENV FOOTER_INJECT=FOOTER_INJECT
ENV HEADER_INJECT=HEADER_INJECT
ENV NO_FOLLOW=false
ENV NO_INDEX=false
ENV TELEGRAM_HOST=telegram.dog
ENV STATIC_PROXY=""
ENV GOOGLE_SEARCH_SITE=""
ENV TAGS=""
ENV COMMENTS="true"
ENV LINKS=""
ENV NAVS=""
ENV DOCKER=true

RUN pnpm run build
FROM base AS runtime
# COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD node ./dist/server/entry.mjs