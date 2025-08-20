import React from 'react'

export default async function HomePage() {
  try {
    const res = await fetch(process.env.API_URL ? `${process.env.API_URL}/v1/posts` : 'http://localhost:4000/v1/posts', { cache: 'no-store' });
    
    if (!res.ok) {
      throw new Error(`API request failed: ${res.status} ${res.statusText}`);
    }
    
    const posts = await res.json();
    
    return (
      <main className="max-w-2xl mx-auto p-4 space-y-3">
        {posts.map((p:any) => (
          <article key={p.id} className="card">
            <div className="text-sm opacity-80">@{p.author.handle}</div>
            {p.cw ? <details><summary className="cursor-pointer">Content warning</summary><p>{p.content}</p></details> : <p>{p.content}</p>}
          </article>
        ))}
      </main>
    );
  } catch (error) {
    console.error('Error fetching posts:', error);
    return (
      <main className="max-w-2xl mx-auto p-4 space-y-3">
        <div className="text-red-500">
          <h2 className="text-xl font-bold mb-2">Error Loading Posts</h2>
          <p>Unable to load posts. Please check if the API server is running.</p>
          <p className="text-sm mt-2">Error: {error instanceof Error ? error.message : 'Unknown error'}</p>
        </div>
      </main>
    );
  }
}