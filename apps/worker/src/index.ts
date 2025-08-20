import { Queue, Worker, QueueEvents } from 'bullmq';
import Redis from 'ioredis';
import { PrismaClient } from '@sodium/db';

const connection = new Redis(process.env.REDIS_URL ?? 'redis://localhost:6379');
const prisma = new PrismaClient();

export const deliveries = new Queue('deliveries', { connection });
new QueueEvents('deliveries', { connection });

new Worker('deliveries', async job => {
  // TODO: federation fan-out (M2)
  console.log('deliveries job', job.id, job.data);
}, { connection });

console.log('worker up');
