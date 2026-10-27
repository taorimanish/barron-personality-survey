// ============================================================
//  BARRON SURVEY — SUPABASE CONFIG
//  Paste your project's values below (see README.md step 2).
//  These two values are SAFE to expose in the browser — the
//  anon key is public by design and is protected by the
//  Row Level Security rules in supabase-setup.sql.
// ============================================================
window.BARRON_SUPABASE = {
  // e.g. "https://abcdefghijklmno.supabase.co"
  url: "https://ybytjwrwtijianrjhtrk.supabase.co",

  // the "anon public" key from Project Settings → API
  anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlieXRqd3J3dGlqaWFucmpodHJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMxMTMwNDcsImV4cCI6MjEwODY4OTA0N30.b2UYSyZvojjmcfT-uOirl_Qi3slbnVN7igAub2Grn2o",

  // name of the table (matches supabase-setup.sql)
  table: "barron_survey_responses",

  // Public link to the live survey (used by the QR code + poster).
  // This is a Bitly short link that redirects to the live survey, so the
  // destination can be changed in Bitly later WITHOUT reprinting posters.
  surveyUrl: "https://bit.ly/barronsurvey"
};
