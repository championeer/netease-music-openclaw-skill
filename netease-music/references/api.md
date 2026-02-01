# NeteaseCloudMusicApi notes (cheatsheet)

This skill uses `NeteaseCloudMusicApi` on localhost.

## Server

Default base URL: `http://127.0.0.1:3000`

The included wrapper scripts let you override:

- `NCM_API_BASE` (e.g. `http://127.0.0.1:3000`)
- `NCM_COOKIE_FILE` (defaults to a local file under the repo/runtime config dir)

## Login (QR)

Typical flow (endpoints may differ by version):

1) Get key:
- `GET /login/qr/key?timestamp=<ms>` → `{ data: { unikey } }`

2) Create QR:
- `GET /login/qr/create?key=<unikey>&qrimg=true&timestamp=<ms>` → contains `qrimg` (base64 image) and/or `qrurl`

3) Poll status:
- `GET /login/qr/check?key=<unikey>&timestamp=<ms>`

On success, cookie is returned in response headers/body depending on server.

## Search

- `GET /search?keywords=<kw>&limit=<n>&type=<type>`
  - type: 1 track, 10 album, 100 artist, 1000 playlist (common)

## Playlists

- List user playlists: `GET /user/playlist?uid=<uid>`
- Create playlist: `GET /playlist/create?name=<name>&privacy=<0|10>`
- Add/remove tracks:
  - `GET /playlist/tracks?op=add&pid=<playlistId>&tracks=<songId1,songId2>`
  - `GET /playlist/tracks?op=del&pid=<playlistId>&tracks=<...>`

## Like

- Like/unlike a track:
  - `GET /like?id=<songId>&like=true`
  - `GET /like?id=<songId>&like=false`

(Exact params can change. Use the `raw` command to probe.)
