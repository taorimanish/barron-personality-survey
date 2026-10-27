-- ============================================================
--  THE GREAT BARRON PERSONALITY INVESTIGATION
--  Supabase database setup
--  Run this in your Supabase project:  SQL Editor → New query → Run
-- ============================================================

-- 1) The table that stores every submitted survey response.
create table if not exists public.barron_survey_responses (
  id               bigint generated always as identity primary key,
  created_at       timestamptz not null default now(),
  name             text,                       -- optional; may be null/anonymous
  q1_locations     text[]       default '{}',  -- "where we'd find you" (multi)
  q1_other         text,
  q2_team          text,
  q3_categories    text[]       default '{}',  -- top 3 happy categories (multi)
  q3_other         text,
  q4_spend75       text,
  q5_personality   text,
  q6_worth_it      text,
  q7_white_elephant text,
  q8_obsessed_with text,
  q9_surprise      text
);

-- 2) Turn on Row Level Security (RLS). With RLS on and no policies,
--    nobody can read or write — so we add exactly the policies we want.
alter table public.barron_survey_responses enable row level security;

-- 3) Allow ANYONE (the public "anon" role used by the survey page) to
--    INSERT a response. This lets coworkers submit without logging in.
drop policy if exists "anyone can submit a response" on public.barron_survey_responses;
create policy "anyone can submit a response"
  on public.barron_survey_responses
  for insert
  to anon
  with check (true);

-- NOTE: We deliberately DO NOT grant SELECT to the anon role.
-- That means the public survey page can submit answers but CANNOT read
-- anyone else's answers. HR views results via results.html using the
-- SERVICE ROLE key (kept private) OR by logging into the Supabase
-- dashboard → Table Editor. See README.md step 4.

-- ------------------------------------------------------------
-- OPTIONAL: if you prefer authenticated HR users to read results
-- through Supabase Auth instead of the service key, uncomment:
--
-- drop policy if exists "authenticated can read responses" on public.barron_survey_responses;
-- create policy "authenticated can read responses"
--   on public.barron_survey_responses
--   for select
--   to authenticated
--   using (true);
-- ------------------------------------------------------------
