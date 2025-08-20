import 'dotenv/config';
import { Hono } from 'hono';
import { serve } from '@hono/node-server';
import { z } from 'zod';
import { PrismaClient } from '@prisma/client';

const app = new Hono();
const prisma = new PrismaClient();

app.get('/healthz', c => c.text('ok'));
app.get('/readyz', c => c.text('ready'));

app.get('/v1/profiles/:handle', async c => {
  const { handle } = c.req.param();
  const profile = await prisma.profile.findUnique({ where: { handle }});
  if (!profile) return c.json({ error: 'not_found' }, 404);
  return c.json(profile);
});

app.get('/v1/posts', async c => {
  const take = Number(c.req.query('take') ?? '20');
  const posts = await prisma.post.findMany({
    take, orderBy: { createdAt: 'desc' },
    include: { author: { select: { handle: true, displayName: true, avatarUrl: true } } }
  });
  return c.json(posts);
});

app.post('/v1/posts', async c => {
  const body = await c.req.json();
  const schema = z.object({
    authorHandle: z.string(),
    content: z.string().min(1),
    cw: z.string().optional()
  });
  const parsed = schema.parse(body);
  const author = await prisma.profile.findUnique({ where: { handle: parsed.authorHandle }});
  if (!author) return c.json({ error: 'author_not_found' }, 400);
  const post = await prisma.post.create({ data: { authorProfileId: author.id, content: parsed.content, cw: parsed.cw }});
  return c.json(post, 201);
});

app.post('/v1/media/presign', async c => {
  const { key, contentType } = await c.req.json();
  if (!key || !contentType) return c.json({ error: 'bad_request' }, 400);
  const url = await (await import('./s3')).presign(key, contentType);
  return c.json({ url, key });
});

const port = Number(process.env.PORT ?? 4000);
serve({ fetch: app.fetch, port });
console.log(`api listening on :${port}`);
