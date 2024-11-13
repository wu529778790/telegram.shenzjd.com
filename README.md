# telegram.shenzjd.com

**将你的 Telegram Channel 转为微博客。**

---

## ✨ 特性

- **将 Telegram Channel 转为微博客**
- **SEO 友好** `/sitemap.xml`
- **浏览器端 0 JS**
- **提供 RSS 和 RSS JSON** `/rss.xml` `/rss.json`

## 平台

1. [Cloudflare](https://broadcast-channel.pages.dev/)
2. [Netlify](https://broadcast-channel.netlify.app/)
3. [Vercel](https://broadcast-channel.vercel.app/)

广播频道支持部署在 Cloudflare、Netlify、Vercel 等支持 Node.js SSR 的无服务器平台或者 VPS。
具体教程见[部署你的 Astro 站点](https://docs.astro.build/zh-cn/guides/deploy/)。

## 🧱 技术栈

- 框架：[Astro](https://astro.build/)
- 内容管理系统：[Telegram Channels](https://telegram.org/tour/channels)
- 模板: [Sepia](https://github.com/Planetable/SiteTemplateSepia)

## 🏗️ 部署

### Docker

1. `docker pull ghcr.io/wu529778790/telegram.shenzjd.com:latest`
2. `docker run -d --name telegram.shenzjd.com -p 4321:4321 -e CHANNEL=miantiao_me ghcr.io/wu529778790/telegram.shenzjd.com:latest`

### Serverless

1. [Fork](https://github.com/wu529778790/telegram.shenzjd.com/fork) 此项目到你 GitHub
2. 在 Cloudflare/Netlify/Vercel 创建项目
3. 选择 `telegram.shenzjd.com` 项目和 `Astro` 框架
4. 配置环境变量 `CHANNEL` 为你的频道名称。此为最小化配置，更多配置见下面的配置项
5. 保存并部署
6. 绑定域名（可选）。
7. 更新代码，参考 GitHub 官方文档 [从 Web UI 同步分叉分支](https://docs.github.com/zh/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork#syncing-a-fork-branch-from-the-web-ui)。

## ⚒️ 配置

```env
## Telegram 频道用户名，必须配置。 t.me/ 后面那串字符
CHANNEL=shenzjd_com

## 语言和时区设置，语言选项见[dayjs](https://github.com/iamkun/dayjs/tree/dev/src/locale)
LOCALE=zh-cn
TIMEZONE=Asia/Shanghai

## 社交媒体用户名
TELEGRAM=shenzjd
TWITTER=shenzujiudi
GITHUB=wu529778790

## 下面两个社交媒体需要为 URL
DISCORD=https://DISCORD.com
PODCASRT=https://PODCASRT.com

## 头部尾部代码注入，支持 HTML
FOOTER_INJECT=FOOTER_INJECT
HEADER_INJECT=HEADER_INJECT

## SEO 配置项，可不让搜索引擎索引内容
NO_FOLLOW=false
NO_INDEX=false

## Sentry 配置项，收集服务端报错
SENTRY_AUTH_TOKEN=SENTRY_AUTH_TOKEN
SENTRY_DSN=SENTRY_DSN
SENTRY_PROJECT=SENTRY_PROJECT

## Telegram 主机名称和静态资源代理，不建议修改
HOST=telegram.dog
STATIC_PROXY=

## 启用谷歌站内搜索
GOOGLE_SEARCH_SITE=memo.miantiao.me

## 启用标签页, 标签使用英文逗号分割
TAGS=标签A,标签B,标签C

## 展示评论
COMMENTS=true

## 链接页面中的超链接, 使用英文逗号和分号分割
LINKS=Title1,URL1;Title2,URL3;Title3,URL3;

## 侧边栏导航项, 使用英文逗号和分号分割
NAVS=Title1,URL1;Title2,URL3;Title3,URL3;
```

## 🙋🏻 常问问题

1. 为什么部署后内容为空？
   - 检查频道是否是公开的，必须是公开的
   - 频道用户名是字符串，不是数字
   - 关闭频道 Restricting Saving Content 设置项
   - 修改完环境变量后需要重新部署
   - Telegram 会屏蔽一些敏感频道的公开展示， 可以通过访问 `https://t.me/s/频道用户名` 确认
