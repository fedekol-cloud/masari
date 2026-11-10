# Masari 4.0 — rediseño premium + sincronización Supabase

## Qué incluye
- `index.html`: app rediseñada, con la lógica y estructura de datos de Masari 3.0.
- `manifest.webmanifest`, `sw.js`, `icon-192.png`, `icon-512.png`: instalación como PWA.
- `supabase-schema.sql`: esquema original como referencia (no hace falta volver a ejecutarlo si ya está creada `masari_data`).

## Antes de publicar
1. Abrí `index.html` y buscá `SUPABASE_ANON_KEY`.
2. Reemplazá `PEGAR_CLAVE_PUBLICABLE_ANON` por la misma Publishable Key que ya usaste en Masari 3.0. La Project URL ya está configurada.
3. No uses nunca `service_role` ni una clave `sb_secret_` en el navegador.
4. Subí el contenido de esta carpeta a la raíz del repositorio GitHub, reemplazando los archivos anteriores.
5. Esperá el deploy de GitHub Pages.
6. Abrí la URL en tus dispositivos. Iniciá sesión con la misma cuenta.

## Datos y sincronización
- Masari 4.0 conserva la clave local `masari_data_v2` y la tabla `masari_data`; al iniciar sesión recupera los datos existentes de Supabase.
- No borres la tabla ni los datos locales. Hacé un backup JSON desde Configuración antes de actualizar.
- El archivo `sw.js` usa una nueva versión de caché (`masari-v4`) para evitar que el navegador siga mostrando la interfaz anterior.
- La sincronización sigue usando una fila JSON por usuario, adecuada para uso personal; evitá editar al mismo tiempo en dos dispositivos.
