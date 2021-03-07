# Docker Test

This repo stubs out the minimal version of Next.js app running inside a Lambda Handler, all packaged in a Docker image.

**Important**: The Lamnda running this code has to have a longer timeout than the usual 3s. Probably ~10. This is due to the fact that if a cold-start is happening, the app has to "prepare" (`await app.prepare()`) and that sometimes takes a while.

---

References:

- https://blog.natterstefan.me/how-to-dockerize-a-nextjs-application