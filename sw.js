const CACHE='masari-v5';
const FILES=['./','./index.html','./supabase.js','./manifest.webmanifest','./icon-192.png','./icon-512.png'];
self.addEventListener('install',e=>{
  // add() uno por uno: si falta un archivo (ej. un ícono) no se rompe toda la instalación.
  e.waitUntil(caches.open(CACHE).then(c=>Promise.all(FILES.map(f=>c.add(f).catch(()=>{})))));
  self.skipWaiting();
});
self.addEventListener('activate',e=>{
  e.waitUntil(caches.keys().then(ks=>Promise.all(ks.filter(k=>k!==CACHE).map(k=>caches.delete(k)))));
  self.clients.claim();
});
// Red primero (siempre ves la última versión); si no hay conexión, usa la caché.
self.addEventListener('fetch',e=>{
  const r=e.request;
  if(r.method!=='GET'||new URL(r.url).origin!==location.origin)return;
  e.respondWith(fetch(r).then(res=>{
    if(res.ok){const cp=res.clone();caches.open(CACHE).then(c=>c.put(r,cp))}
    return res;
  }).catch(()=>caches.match(r).then(hit=>hit||caches.match('./index.html'))));
});
