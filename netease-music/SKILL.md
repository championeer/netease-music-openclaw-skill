---
name: netease-music
description: Manage NetEase Cloud Music (网易云音乐) content via the unofficial NeteaseCloudMusicApi on localhost: search tracks/albums/artists/playlists, list/create playlists, add/remove tracks in playlists, and batch-like/unlike tracks. Use when the user asks to find songs, organize or create playlists, or do bulk收藏/喜欢 operations (no playback control).
---

# NetEase Music (NCM) Skill

## Assumptions

- This skill focuses on **content management** (search/playlist/likes), **not playback**.
- Uses `NeteaseCloudMusicApi` running on localhost.

## Quick start (one-time)

1) Start the API server:

```bash
./netease-music/scripts/ncm-server start
```

2) Login via QR code (interactive):

```bash
./netease-music/scripts/ncm login
```

After login, cookies are stored locally (see script output for the path).

## Common commands

- Search tracks:
  ```bash
  ./netease-music/scripts/ncm search "稻香" --limit 5
  ```

- List my playlists:
  ```bash
  ./netease-music/scripts/ncm playlists
  ```

- Create a playlist:
  ```bash
  ./netease-music/scripts/ncm playlist-create "开车歌" --privacy public
  ```

- Add tracks to a playlist:
  ```bash
  ./netease-music/scripts/ncm playlist-add <playlistId> <songId1> <songId2>
  ```

- Batch like tracks:
  ```bash
  ./netease-music/scripts/ncm like <songId1> <songId2>
  ```

## Notes for the agent

- If the server is not reachable, run `./netease-music/scripts/ncm-server start`.
- If requests fail due to auth, run `./netease-music/scripts/ncm login`.
- API endpoint details and response fields vary across deployments; when implementing new operations, use `./netease-music/scripts/ncm raw <path> [--query k=v]` to probe.

## References

- Endpoint cheatsheet and known flows: `netease-music/references/api.md`
