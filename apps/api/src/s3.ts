import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';

const client = new S3Client({
  region: process.env.S3_REGION,
  endpoint: process.env.S3_ENDPOINT,
  forcePathStyle: true,
  credentials: { accessKeyId: process.env.S3_ACCESS_KEY_ID!, secretAccessKey: process.env.S3_SECRET_ACCESS_KEY! }
});

export async function presign(key: string, type: string) {
  const cmd = new PutObjectCommand({ Bucket: process.env.S3_BUCKET!, Key: key, ContentType: type });
  return getSignedUrl(client, cmd, { expiresIn: 60 });
}
