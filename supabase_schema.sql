-- MIDORÉ MATCHA POS — SUPABASE DATABASE
-- Run this entire script in Supabase SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric(10,2) not null check (price >= 0),
  category text not null default 'Matcha',
  desc text default '',
  active boolean not null default true,
  stock integer not null default 999 check (stock >= 0),
  created_at timestamptz not null default now()
);

create table if not exists public.sales (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  total numeric(10,2) not null check (total >= 0),
  cash numeric(10,2) not null check (cash >= 0),
  cashier_email text
);

create table if not exists public.sale_items (
  id uuid primary key default gen_random_uuid(),
  sale_id uuid not null references public.sales(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  name text not null,
  qty integer not null check (qty > 0),
  unit_price numeric(10,2) not null check (unit_price >= 0)
);

alter table public.products enable row level security;
alter table public.sales enable row level security;
alter table public.sale_items enable row level security;

-- Authenticated staff can use the POS.
create policy "staff can read products" on public.products for select to authenticated using (true);
create policy "staff can add products" on public.products for insert to authenticated with check (true);
create policy "staff can edit products" on public.products for update to authenticated using (true) with check (true);
create policy "staff can delete products" on public.products for delete to authenticated using (true);

create policy "staff can read sales" on public.sales for select to authenticated using (true);
create policy "staff can add sales" on public.sales for insert to authenticated with check (true);

create policy "staff can read sale items" on public.sale_items for select to authenticated using (true);
create policy "staff can add sale items" on public.sale_items for insert to authenticated with check (true);

insert into public.products (name,price,category,desc,active,stock)
select 'Matcha Latte',190,'Matcha','Matcha, Oatmilk',true,999
where not exists (select 1 from public.products where name='Matcha Latte');

insert into public.products (name,price,category,desc,active,stock)
select 'Cold Whisk Matcha',200,'Matcha','Matcha, Oatmilk (NO WATER)',true,999
where not exists (select 1 from public.products where name='Cold Whisk Matcha');

insert into public.products (name,price,category,desc,active,stock)
select 'Cereal Milk Matcha',220,'Matcha','Matcha, Corn Milk, Corn Flakes',true,999
where not exists (select 1 from public.products where name='Cereal Milk Matcha');

insert into public.products (name,price,category,desc,active,stock)
select 'Banana Pudding Matcha',220,'Matcha','Matcha, Oatmilk, Banana Pudding',true,999
where not exists (select 1 from public.products where name='Banana Pudding Matcha');
