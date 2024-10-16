
Bun.serve({
  port: 3000,
  fetch(request, server) {
    return new Response('hello, Hosty!')
  },
})

console.log('Server is running on http://localhost:3000')