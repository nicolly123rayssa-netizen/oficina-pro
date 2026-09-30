# Oficina Pro

Sistema web de gestão para oficina: orçamentos, fotos, veículos/produção e financeiro.

## Rodar localmente
1. Instale Node.js 20 ou superior.
2. Execute `npm install` e `npm run dev`.
3. Para dados compartilhados entre usuários, configure o Supabase com as instruções em `supabase/schema.sql` e crie um arquivo `.env` a partir de `.env.example`.

Sem Supabase configurado, o app entra em modo de demonstração e guarda dados somente neste navegador. Não use esse modo para operação real compartilhada.

## Publicar gratuitamente
Importe este repositório no Cloudflare Pages (build: `npm run build`, pasta: `dist`) e configure as variáveis VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY nas configurações de build.
