Label Label Party
====

## Usage

- `npm install`
- Build and watch styles and templates with `npm run gulp`
- Watch JavaScript bundle with `npm run watch`
- Build JavaScript bundle with `npm run build` (for production)
- Serve locally with `npm run dev`
- Visit [localhost:8080](http://localhost:8080) to view your site.


## Serving

Everything in `/public` is static and servable, so you don’t necessarily
need to serve via the included app.coffee in production. But if you do use
app.coffee, be sure to set the environment variable on your server with
`export NODE_ENV=production`. You can change the port in
`/config/production.json`.
