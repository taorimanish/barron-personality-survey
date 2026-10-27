# 🎉 The Great Barron Personality Investigation — Survey + Supabase Backend

A festive team-culture survey that saves every response to a **Supabase** database.
Coworkers fill out the form; HR reads results and exports to CSV. No emailing answers around.

## 📁 What's in here

| File | What it is |
|------|------------|
| `index.html` | The survey everyone fills out. Submits to Supabase. |
| `results.html` | **HR-only** dashboard: view responses, quick stats, export CSV. |
| `config.js` | Your Supabase URL + public anon key (edit this once). |
| `supabase-setup.sql` | Run once in Supabase to create the table + security rules. |
| `README.md` | This file. |

---

## 🚀 Setup (about 5 minutes)

### 1. Create a free Supabase project
1. Go to **https://supabase.com** → sign in → **New project**.
2. Pick a name (e.g. `barron-survey`) and a database password. Wait ~1 min for it to spin up.

### 2. Add your keys to `config.js`
In Supabase: **Project Settings → API**. Copy:
- **Project URL** → paste as `url`
- **anon public** key → paste as `anonKey`

```js
window.BARRON_SUPABASE = {
  url: "https://YOURPROJECT.supabase.co",
  anonKey: "eyJ...your anon public key...",
  table: "barron_survey_responses"
};
```

> ✅ The **anon** key is meant to be public — it's safe in the browser. It's locked down by the
> security rules in the next step so the public can only *submit*, never *read*, responses.

### 3. Create the database table
In Supabase: **SQL Editor → New query**, paste the contents of `supabase-setup.sql`, and click **Run**.
This creates the `barron_survey_responses` table and sets Row Level Security so:
- Anyone can **submit** a response ✅
- The public **cannot read** anyone's answers 🔒

### 4. Publish the survey so people can open it
`index.html` is a plain static site. Easiest free options:
- **Netlify Drop** — drag this folder onto https://app.netlify.com/drop
- **GitHub Pages** — push this folder to a repo and enable Pages
- **Vercel** — import the folder

Share the link to **`index.html`** with the team. That's it — responses flow into Supabase.

> 💡 I (Kiro) can push this to a GitHub repo and set up GitHub Pages for you — just ask.

---

## 👀 How HR reads the results

**Option A — Supabase dashboard (simplest, nothing to host):**
Supabase → **Table Editor → `barron_survey_responses`**. View, sort, and export to CSV right there.

**Option B — the `results.html` dashboard (nicer view + stats):**
1. Open `results.html` (keep this one private to HR — don't share the public survey link to it).
2. Paste your **service_role** key (Project Settings → API). It stays in your browser tab only and is never saved.
3. You get: all responses, live search, quick stats (top personality, top category, response count), and a one-click **CSV export**.

> ⚠️ The **service_role** key bypasses all security — treat it like a password. Only use it in
> `results.html` on a trusted machine, and never commit it into `config.js` or publish it.

---

## 🔧 Customizing
- **Change questions/wording:** edit `index.html`. If you add/rename a field, also update the column in `supabase-setup.sql` and the labels in `results.html`.
- **Require a name:** add the `required` attribute to the name input in `index.html`.
- **Styling:** colors live in the `:root { ... }` block at the top of each HTML file.

---

## 🧩 How it works (quick)
- The survey uses the official Supabase JS client (loaded from a CDN) and calls
  `supabase.from('barron_survey_responses').insert([...])` on submit.
- Multi-select questions (Q1, Q3) are stored as Postgres `text[]` arrays.
- A draft autosaves in the browser so nobody loses progress mid-form.

Enjoy, and remember: this survey does not guarantee gifts, prizes, vacation days, raises,
or a personal visit from Santa. Nice try, though. 🎄
