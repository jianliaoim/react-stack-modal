
React Stack Modal
----

Demo http://ui.talk.ai/react-stack-modal

`autoFocus: true` may break entering transition, add requestAnimation frame to by pass.

### Develop

You need a static file server for the HTML files. Personally I suggest using Nginx.

```bash
npm i
gulp dev
```

Build (Pack and optimize assets, add hashes and put entries in `index.html`):

```bash
NODE_ENV=static gulp build # not minified
npm run static

NODE_ENV=ws gulp build
npm run ws
```

### License

MIT
