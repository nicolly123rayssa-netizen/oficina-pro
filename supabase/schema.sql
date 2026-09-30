-- Oficina Pro: execute no SQL Editor do seu projeto Supabase.
create table if not exists public.quotes (
  id uuid primary key default gen_random_uuid(),
  number text not null,
  client text not null,
  phone text default '',
  vehicle text not null,
  plate text default '',
  date date not null default current_date,
  entry_date date,
  exit_date date,
  items jsonb not null default '[]'::jsonb,
  entry numeric(12,2) not null default 0,
  notes text default '',
  status text not null default 'Pendente',
  validity integer not null default 10,
  photos jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  quote_id uuid references public.quotes(id) on delete set null,
  type text not null check (type in ('Entrada','Saída')),
  category text not null default 'Geral',
  description text not null,
  amount numeric(12,2) not null default 0,
  date date not null default current_date,
  created_at timestamptz not null default now()
);
alter table public.quotes enable row level security;
alter table public.transactions enable row level security;
-- Base inicial: acesso somente para usuários autenticados. Ajuste políticas conforme os usuários da oficina.
create policy "Authenticated users can manage quotes" on public.quotes for all to authenticated using (true) with check (true);
create policy "Authenticated users can manage transactions" on public.transactions for all to authenticated using (true) with check (true);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('quote-photos','quote-photos',true,10485760,array['image/jpeg','image/png','image/webp'])
on conflict (id) do nothing;
create policy "Authenticated users can upload quote photos" on storage.objects for insert to authenticated with check (bucket_id = 'quote-photos');
create policy "Public can view quote photos" on storage.objects for select to public using (bucket_id = 'quote-photos');
create policy "Authenticated users can delete quote photos" on storage.objects for delete to authenticated using (bucket_id = 'quote-photos');
create table if not exists public.settings (
  id integer primary key default 1 check (id = 1),
  name text not null default 'Oficina Pro',
  cnpj text default '',
  phone text default '',
  email text default '',
  address text default '',
  updated_at timestamptz not null default now()
);
alter table public.settings enable row level security;
create policy "Authenticated users can manage company settings" on public.settings for all to authenticated using (true) with check (true);
