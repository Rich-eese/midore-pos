# Midoré Matcha POS — Full Cloud Version

This package is a **cloud-ready** POS. It supports:
- Shared online menu across PC, iPhone and iPad
- Staff login
- Menu add/edit/hide/delete
- Shared sales history
- Cash received + change
- Inventory/stock counts
- Dashboard for today's sales/orders/average order
- Mobile-friendly layout
- Offline/local demo mode until cloud setup is completed

## 1. Create the free cloud database
Use Supabase (https://supabase.com/).

1. Create a project.
2. Open **SQL Editor**.
3. Open `supabase_schema.sql` from this folder.
4. Paste the whole SQL script and run it.
5. In Supabase, create your staff account under **Authentication → Users → Add user**.
   - You can create the owner/cashier accounts you want.
6. Go to **Project Settings → API** and copy:
   - Project URL
   - anon/publishable key
7. Open `config.js` and replace:
   YOUR_SUPABASE_PROJECT_URL
   YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY
   with those values.
   Do NOT use the service_role/secret key.

## 2. Test on your PC
Open `index.html` through a local web server (recommended), not by double-clicking it.
If you have VS Code, the Live Server extension is an easy option.

## 3. Put it online for iPhone/iPad
Upload the contents of `midore_pos` to any static HTTPS host such as GitHub Pages, Cloudflare Pages, Netlify, or Vercel.
Then open the resulting HTTPS address in Safari and choose **Share → Add to Home Screen**.

## Important
The browser is only the front end. Supabase is the shared database/authentication layer.
Never put a Supabase service-role/secret key in this folder or browser.

## Recommended next upgrades
For a production café, the next improvements should be:
1. Owner vs cashier permissions (cashiers cannot delete/edit products).
2. Receipt printing / thermal printer support.
3. End-of-day cash drawer reconciliation.
4. Product modifiers (size, milk, sweetness, toppings).
5. Purchase/stock-in records and low-stock alerts.
6. Expenses and profit reporting.
7. Automatic backups/export.
