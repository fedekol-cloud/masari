-- MASARI 3.0 — Ejecutar en Supabase > SQL Editor > New query
create table if not exists public.masari_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.masari_data enable row level security;

drop policy if exists "Users can read own Masari data" on public.masari_data;
create policy "Users can read own Masari data"
on public.masari_data for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert own Masari data" on public.masari_data;
create policy "Users can insert own Masari data"
on public.masari_data for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update own Masari data" on public.masari_data;
create policy "Users can update own Masari data"
on public.masari_data for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Activar Realtime para que los cambios aparezcan en otros dispositivos (idempotente).
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'masari_data'
  ) then
    alter publication supabase_realtime add table public.masari_data;
  end if;
end $$;
