import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  // Demo users
  const users = await Promise.all(
    ['demo1@example.com','demo2@example.com','demo3@example.com'].map(async (email, i) => {
      const u = await prisma.user.upsert({
        where: { email },
        update: {},
        create: { email }
      });
      const p = await prisma.profile.upsert({
        where: { userId: u.id },
        update: {},
        create: {
          userId: u.id,
          handle: `demo${i+1}`,
          displayName: `Demo ${i+1}`
        }
      });
      return { u, p };
    })
  );

  // Demo posts
  for (const { p } of users) {
    for (let i = 0; i < 5; i++) {
      await prisma.post.create({
        data: { authorProfileId: p.id, content: `Hello from @${p.handle} #${i+1}` }
      });
    }
  }

  // Themes
  await prisma.theme.createMany({
    data: [
      { name: 'Midnight', tokens: { bg: '#0b0f19', text: '#e6e9ef', accent: '#6ea8fe' } },
      { name: 'Pastel', tokens: { bg: '#fff7f8', text: '#333', accent: '#ff91ae' } }
    ]
  });

  console.log('Seed complete.');
}

main().finally(() => prisma.$disconnect());
