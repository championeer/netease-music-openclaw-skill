# netease-music (OpenClaw Skill)

An OpenClaw skill for managing NetEase Cloud Music (网易云音乐) **content** (no playback):

- Search tracks
- List / create playlists
- Add / remove tracks in playlists
- Batch like / unlike tracks

Repo: https://github.com/championeer/netease-music-openclaw-skill

---

## English — Installation & Usage

### 0) What this skill does (and does not)

- ✅ Content management: search / playlists / bulk operations
- ❌ Playback control: out of scope

Under the hood it uses an unofficial local API server (`NeteaseCloudMusicApi`).

### 1) Requirements

- OpenClaw
- Node.js 18+ (to run the local API server)
- Python 3.10+ (to run the wrapper CLI scripts)
- `git` (recommended, for install)

### 2) One-command install (recommended)

OpenClaw loads skills from either:

- **Workspace skills**: `<your-openclaw-workspace>/skills/<skill-name>`
- **Shared skills**: `~/.openclaw/skills/<skill-name>`

Pick one location and clone this repo’s skill folder into it.

#### Option A — Install for the current workspace (per-agent)

```bash
cd "<your-openclaw-workspace>"
mkdir -p skills
git clone https://github.com/championeer/netease-music-openclaw-skill.git /tmp/netease-music-openclaw-skill
rm -rf skills/netease-music
cp -R /tmp/netease-music-openclaw-skill/netease-music skills/netease-music
```

Then start a **new OpenClaw session** so it picks up the new skill.

#### Option B — Install globally (shared across agents on this machine)

```bash
mkdir -p ~/.openclaw/skills
rm -rf ~/.openclaw/skills/netease-music
git clone https://github.com/championeer/netease-music-openclaw-skill.git /tmp/netease-music-openclaw-skill
cp -R /tmp/netease-music-openclaw-skill/netease-music ~/.openclaw/skills/netease-music
```

Then start a **new OpenClaw session**.

### 2.1) “Just paste the GitHub link to OpenClaw”

If you already have OpenClaw running and it can execute commands on your machine, you can simply tell it:

> Install this OpenClaw skill from GitHub: https://github.com/championeer/netease-music-openclaw-skill
> Put the `netease-music` folder into my `<workspace>/skills` (or `~/.openclaw/skills`).

OpenClaw can usually handle the git clone + copy steps for you.

### 3) Start the local API server

From wherever the skill is installed (the skill folder contains `scripts/`):

```bash
./scripts/ncm-server start
```

Default base URL: `http://127.0.0.1:3000`

### 4) Authenticate (recommended: export cookie once)

QR login capture can be flaky in some environments.
For the most reliable setup, we recommend **exporting your cookie from the NetEase web player** (once).

1) Login to NetEase web player in your browser.
2) Export the cookie string (Developer Tools → Application/Storage → Cookies).
3) Save it into (a repo-local runtime file, gitignored):

```bash
# If installed from this repo layout:
./.ncm/cookie.txt
```

**Important:** Treat the cookie as a secret. Do NOT commit it.

### 5) Quick usage

```bash
# Search (no auth required)
./scripts/ncm search "周杰伦" --limit 5

# List my playlists (requires cookie)
./scripts/ncm playlists

# Create playlist
./scripts/ncm playlist-create "自驾必听" --privacy private

# Add tracks to a playlist
./scripts/ncm playlist-add <playlistId> <songId1> <songId2>

# Like / Unlike
./scripts/ncm like <songId1> <songId2>
./scripts/ncm unlike <songId1>
```

### 6) Configuration

Environment variables:

- `NCM_API_BASE` (default: `http://127.0.0.1:3000`)
- `NCM_RUNTIME_DIR` (default: `./.ncm` under the skill folder)
- `NCM_COOKIE_FILE` (default: `./.ncm/cookie.txt`)

### 7) Troubleshooting

- **Server won’t start**: check `./.ncm/server.log`.
- **401 / need login**: ensure `cookie.txt` exists and is valid.
- **`/search` returns 405 when Cookie is set**: some builds reject Cookie headers on `/search`.
  This project avoids sending Cookie to `/search` and only uses it on authenticated endpoints.

### 8) Legal / Disclaimer

This project uses an **unofficial** API server (`NeteaseCloudMusicApi`).
Use at your own risk and comply with local laws and NetEase terms.

---

## 中文 — 安装与使用

### 0）这个 Skill 做什么/不做什么

- ✅ 内容管理：搜索/歌单/批量操作
- ❌ 播放控制：不在本 Skill 目标内

底层依赖非官方的本地 API：`NeteaseCloudMusicApi`。

### 1）环境要求

- OpenClaw
- Node.js 18+（用于启动本地 API 服务）
- Python 3.10+（用于运行封装脚本）
- 建议安装 `git`

### 2）一条命令安装（推荐）

OpenClaw 会从以下目录加载 skills：

- **工作区（每个 agent 独立）**：`<你的 openclaw workspace>/skills/<skill-name>`
- **全局共享**：`~/.openclaw/skills/<skill-name>`

你只需要把本仓库里的 `netease-music/` 文件夹放进去即可。

#### 方案 A：安装到当前 workspace（推荐，干净不互相影响）

```bash
cd "<你的 openclaw workspace>"
mkdir -p skills
git clone https://github.com/championeer/netease-music-openclaw-skill.git /tmp/netease-music-openclaw-skill
rm -rf skills/netease-music
cp -R /tmp/netease-music-openclaw-skill/netease-music skills/netease-music
```

然后开启一个**新的 OpenClaw 会话**让它刷新技能列表。

#### 方案 B：安装到全局共享（同机多个 agent 都可用）

```bash
mkdir -p ~/.openclaw/skills
rm -rf ~/.openclaw/skills/netease-music
git clone https://github.com/championeer/netease-music-openclaw-skill.git /tmp/netease-music-openclaw-skill
cp -R /tmp/netease-music-openclaw-skill/netease-music ~/.openclaw/skills/netease-music
```

同样需要开启**新的 OpenClaw 会话**。

### 2.1）“把 GitHub 链接丢给 OpenClaw 让它自己装”

如果你的 OpenClaw 能在本机执行命令，你可以直接对它说：

> 帮我从 GitHub 安装这个 OpenClaw skill：https://github.com/championeer/netease-music-openclaw-skill
> 把 `netease-music` 文件夹放进我的 `<workspace>/skills`（或 `~/.openclaw/skills`）。

OpenClaw 通常可以自动完成 git clone + 拷贝安装。

### 3）启动本地 API 服务

在 skill 安装目录（包含 `scripts/`）下运行：

```bash
./scripts/ncm-server start
```

默认地址：`http://127.0.0.1:3000`

### 4）登录（推荐：手动导出 Cookie，一劳永逸）

二维码登录在不同环境下可能不稳定，最稳妥的方法是：

1) 浏览器登录网易云网页端
2) 开发者工具（Application/Storage → Cookies）复制 Cookie 字符串
3) 保存到（本地运行时文件，已在 .gitignore 中忽略）：

```bash
./.ncm/cookie.txt
```

**注意：Cookie 属于敏感凭证，请勿提交到 Git，也不要随意发送给他人。**

### 5）常用命令

```bash
# 搜索（不需要登录）
./scripts/ncm search "周杰伦" --limit 5

# 列出我的歌单（需要 cookie）
./scripts/ncm playlists

# 创建歌单
./scripts/ncm playlist-create "自驾必听" --privacy private

# 往歌单加歌
./scripts/ncm playlist-add <playlistId> <songId1> <songId2>

# 喜欢 / 取消喜欢
./scripts/ncm like <songId1> <songId2>
./scripts/ncm unlike <songId1>
```

### 6）配置项

环境变量：

- `NCM_API_BASE`（默认：`http://127.0.0.1:3000`）
- `NCM_RUNTIME_DIR`（默认：skill 目录下的 `./.ncm`）
- `NCM_COOKIE_FILE`（默认：`./.ncm/cookie.txt`）

### 7）常见问题

- **服务启动失败**：查看 `./.ncm/server.log`
- **提示未登录/无权限**：确认 `cookie.txt` 存在且有效
- **/search 在带 Cookie 时返回 405**：某些版本会这样。
  本项目默认不会在 `/search` 请求里携带 cookie，只在需要鉴权的接口里携带。

### 8）免责声明

本项目依赖非官方的 `NeteaseCloudMusicApi`。
请自行评估风险，并遵守网易云音乐相关条款与当地法律法规。

---

## License

MIT
