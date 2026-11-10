# Masari 3.0 — sincronización con Supabase

## Archivos
- `index.html`: aplicación completa.
- `manifest.webmanifest`, `sw.js`, `icon-192.png`, `icon-512.png`: PWA.
- `supabase-schema.sql`: tabla y políticas de seguridad.

## Configuración
1. Crear un proyecto en https://supabase.com/.
2. Abrir SQL Editor y ejecutar `supabase-schema.sql`.
3. En Project Settings > API, copiar Project URL y la clave publicable (anon/public).
4. En `index.html`, reemplazar:
   - `PEGAR_URL_DEL_PROYECTO`
   - `PEGAR_CLAVE_PUBLICABLE_ANON`
5. No pegar nunca la `service_role` key en el navegador.
6. Subir los archivos a la raíz del repositorio GitHub y esperar el deploy de GitHub Pages.
7. Abrir la web en el dispositivo que contiene los datos locales, crear cuenta e iniciar sesión. Si la tabla todavía no tiene una fila para esa cuenta, Masari sube automáticamente los datos locales.
8. Abrir la misma URL en el segundo dispositivo e iniciar sesión con el mismo email y contraseña.

## Importante
- La clave anon/public está diseñada para estar en el frontend; la protección depende de RLS.
- No desactivar RLS.
- La primera sincronización pregunta si se combinan los datos locales con los de la nube cuando ya existe información en ambos lados.
- Exportar un JSON antes de migrar es una buena precaución.
- La sincronización guarda el estado completo de Masari en una fila por usuario. Es adecuada para uso personal; si se hacen cambios simultáneos en dos dispositivos, el último guardado puede prevalecer.
- Para un uso productivo más avanzado conviene normalizar las tablas y añadir resolución de conflictos.
