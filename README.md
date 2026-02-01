# netease-music (OpenClaw Skill)

An OpenClaw skill for managing NetEase Cloud Music (网易云音乐) **content** (no playback):

- Search tracks
- List / create playlists
- Add / remove tracks in playlists
- Batch like / unlike tracks

Repository: https://github.com/championeer/netease-music-openclaw-skill

---

## English — Installation & Usage Guide

### What you get

This skill helps OpenClaw manage your NetEase Cloud Music library via a local API server:

- **Search** songs by keyword
- **Create / manage playlists**
- **Bulk add songs** to a playlist
- **Bulk like/unlike** songs

Playback is intentionally **out of scope** for this skill.

### Requirements

- macOS or Linux (Windows may work but is not tested)
- Node.js 18+ (for the local API server)
- Python 3.10+ (for the wrapper CLI)
- OpenClaw installed

This skill runs an unofficial local server:
- `NeteaseCloudMusicApi` (run locally via `npx`)

### Install the skill

#### Option A — Install from source (git)

1) Clone this repo:

```bash
git clone https://github.com/championeer/netease-music-openclaw-skill.git
cd netease-music-openclaw-skill
```

2) (Optional) Verify the skill folder exists:

```bash
ls -la netease-music/SKILL.md
```

3) Install the `.skill` into OpenClaw

OpenClaw supports installing skills in multiple ways depending on your setup.
If you already have a preferred workflow for skills, use it.

If you need packaging, run:

```bash
# This script ships with OpenClaw
python3 /opt/homebrew/lib/node_modules/openclaw/scripts/package_skill.py ./netease-music
```

This produces `netease-music.skill` which you can install via your OpenClaw skill install flow.

> Note: The exact install command may differ depending on your OpenClaw deployment.

### Start the local API server

From the repo root:

```bash
./netease-music/scripts/ncm-server start
```

By default it uses `http://127.0.0.1:3000`.

### Authenticate (recommended approach)

QR login capture may vary by environment.
For the most reliable setup, we recommend **exporting your cookie from the NetEase web player**
(once), then saving it locally.

1) Login to NetEase web player in your browser.
2) Export the cookie string (Developer Tools → Application/Storage → Cookies).
3) Save it into:

```bash
# Repo-local runtime file (gitignored)
./netease-music/.ncm/cookie.txt
```

**Important:** Treat this cookie as a secret. Do NOT commit it.

### Quick usage

```bash
# Search
./netease-music/scripts/ncm search "周杰伦" --limit 5

# List my playlists (requires cookie)
./netease-music/scripts/ncm playlists

# Create playlist
./netease-music/scripts/ncm playlist-create "自驾必听" --privacy private

# Add tracks to a playlist
./netease-music/scripts/ncm playlist-add <playlistId> <songId1> <songId2>

# Like / Unlike
./netease-music/scripts/ncm like <songId1> <songId2>
./netease-music/scripts/ncm unlike <songId1>
```

### Configuration

Environment variables:

- `NCM_API_BASE` (default: `http://127.0.0.1:3000`)
- `NCM_RUNTIME_DIR` (default: `./netease-music/.ncm`)
- `NCM_COOKIE_FILE` (default: `./netease-music/.ncm/cookie.txt`)

### Troubleshooting

- **Server won’t start**: Check logs at `./netease-music/.ncm/server.log`.
- **401/need login**: Ensure `cookie.txt` is present and valid.
- **Search returns 405 when Cookie is set**: This can happen on some builds.
  Our scripts avoid sending the cookie on `/search` and only use it for authenticated endpoints.

### Legal / Disclaimer

This project uses an **unofficial** API server (`NeteaseCloudMusicApi`).
Use at your own risk and comply with local laws and NetEase terms.

---

## 中文 — 安装与使用指南

### 这个 Skill 能做什么？

这是一个用于管理网易云音乐**内容**（不负责播放）的 OpenClaw Skill：

- 搜索歌曲
- 列出 / 创建歌单
- 批量把歌曲加入歌单
- 批量「喜欢/取消喜欢」

### 环境要求

- macOS 或 Linux（Windows 理论上可行但未测试）
- Node.js 18+（用于启动本地 API 服务）
- Python 3.10+（用于命令行封装脚本）
- 已安装 OpenClaw

本 Skill 会在本机通过 `npx` 启动一个非官方服务：
- `NeteaseCloudMusicApi`

### 安装 Skill

#### 方案 A：从源码安装（git）

1) 克隆仓库：

```bash
git clone https://github.com/championeer/netease-music-openclaw-skill.git
cd netease-music-openclaw-skill
```

2) 确认 Skill 文件存在：

```bash
ls -la netease-music/SKILL.md
```

3) 打包生成 `.skill`

```bash
# OpenClaw 自带脚本
python3 /opt/homebrew/lib/node_modules/openclaw/scripts/package_skill.py ./netease-music
```

会生成 `netease-music.skill`，随后按你自己的 OpenClaw 安装流程导入即可。

> 注：不同部署方式的安装命令可能不同。

### 启动本地 API 服务

在仓库根目录运行：

```bash
./netease-music/scripts/ncm-server start
```

默认地址：`http://127.0.0.1:3000`

### 登录（推荐方式：手动导出 Cookie）

由于二维码登录的 Cookie 捕获在不同环境下可能不稳定，**最稳妥**的方法是：

1) 用浏览器登录网易云网页端
2) 打开开发者工具（Application/Storage → Cookies）复制 Cookie 字符串
3) 保存到本机文件：

```bash
# 仓库本地运行时文件（已在 .gitignore 中忽略）
./netease-music/.ncm/cookie.txt
```

**注意：Cookie 属于敏感凭证，请勿提交到 Git，也不要随意发送给他人。**

### 常用命令

```bash
# 搜索
./netease-music/scripts/ncm search "周杰伦" --limit 5

# 列出我的歌单（需要 cookie）
./netease-music/scripts/ncm playlists

# 创建歌单
./netease-music/scripts/ncm playlist-create "自驾必听" --privacy private

# 往歌单加歌
./netease-music/scripts/ncm playlist-add <playlistId> <songId1> <songId2>

# 喜欢 / 取消喜欢
./netease-music/scripts/ncm like <songId1> <songId2>
./netease-music/scripts/ncm unlike <songId1>
```

### 配置项

可用环境变量：

- `NCM_API_BASE`（默认：`http://127.0.0.1:3000`）
- `NCM_RUNTIME_DIR`（默认：`./netease-music/.ncm`）
- `NCM_COOKIE_FILE`（默认：`./netease-music/.ncm/cookie.txt`）

### 常见问题

- **服务启动失败**：查看 `./netease-music/.ncm/server.log`
- **提示未登录/无权限**：确认 `cookie.txt` 存在且有效
- **/search 在带 Cookie 时返回 405**：某些版本会出现该现象。
  本项目脚本默认不会在 `/search` 请求里携带 cookie，仅在需要鉴权的接口里携带。

### 免责声明

本项目依赖非官方的 `NeteaseCloudMusicApi`。
请自行评估风险，并遵守网易云音乐相关条款与当地法律法规。

---

## License

MIT
