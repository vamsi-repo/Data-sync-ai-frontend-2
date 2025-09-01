import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';
import path from 'path';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  return {
    server: {
      host: '0.0.0.0',
      port: 8080,
      proxy: {
        '/api': {
          target: process.env.VITE_API_URL || 'http://127.0.0.1:5000',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, ''),
          secure: false,
          ws: false,
          configure: (proxy) => {
            proxy.on('error', (err, req, res) => {
              console.error('Proxy error:', {
                error: err.message,
                code: (err as any).code,
                syscall: (err as any).syscall || 'unknown',
                address: (err as any).address || 'unknown',
                port: (err as any).port || 'unknown',
                url: req.url,
              });
              if (res && !res.headersSent) {
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ error: 'Proxy error', message: err.message }));
              }
            });
            proxy.on('proxyReq', (proxyReq, req) => {
              console.log('Proxying request:', {
                method: req.method,
                url: req.url,
                headers: req.headers,
              });
            });
            proxy.on('proxyRes', (proxyRes, req) => {
              console.log('Received response for:', {
                url: req.url,
                status: proxyRes.statusCode,
                headers: proxyRes.headers,
              });
            });
          },
        },
      },
    },
    plugins: [react()],
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './src'),
      },
    },
    build: {
      outDir: 'dist',
    },
  };
});