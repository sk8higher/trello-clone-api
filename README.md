# Trello API Clone

Has Users (JWT Auth with expiring session, registration/logging in), Columns that have Cards, Cards have Comments.

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://god.gw.postman.com/run-collection/34454879-3d1a043e-4737-4886-9af9-b93ef872f715?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D34454879-3d1a043e-4737-4886-9af9-b93ef872f715%26entityType%3Dcollection%26workspaceId%3D0a4fb8a7-7473-49b1-a66a-0033fa0a0540)

Requests to API described in Postman, first you need to register your account. It will give you a bearer token (Authorization header), which you should use in log in request. Also you'll need to use it in actions that require authentication (mostly everything except index/show actions.) Token expires in 30 minutes, after that you'll need to log in again.
