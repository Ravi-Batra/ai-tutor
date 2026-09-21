# AI Tutor handover

- Project: AI Tutor — xAI Hindi Mock Test
- Project path: `D:\PROJECTS\ai-tutor`
- Application path: `D:\PROJECTS\ai-tutor`
- Live URL: https://ai-tutor.lead9.in/
- Hosting: Hostinger; confirm the actual subdomain document root before future uploads.
- Stack: PHP 8+ / MySQL / vanilla HTML-CSS-JS, PDO MySQL, sessions.
- Preparation date: 2026-09-21. Changes are local only. Production was not accessed or modified.

## Features and tables

20 seeded multiple-choice questions; active filtering; responsive layout; answer counter; browser completion validation; server scoring; explanations; retake link; session CSRF protection; anonymous attempt summaries. No login, timer, admin editor, or attempt-history UI.

questions: auto-increment id; unique unsigned tinyint question_no; category; question_text; option_a through option_d; correct_option enum A/B/C/D; explanation; is_active; created_at. Active rows are sorted by question_no.

attempts: auto-increment bigint id; score; total_questions; percentage decimal; submitted_at. No personal information or individual answer history.

## Scoring

The server reloads active questions at POST time. Correct answers earn one point; wrong or omitted choices earn zero. Percentage is round(score / total × 100). Feedback thresholds are 90%, 75%, and 55%. Review reveals correct choices and explanations after submission. Attempt logging is best-effort; failure still displays results and writes a generic server log. Successful scoring rotates the CSRF token.

## Protected files and credentials

Original config.php is unchanged and ignored, including common backup suffixes. config.example.php contains placeholders. Set a separate local database before running development; do not assume the original config is safe for local use. Never share real DB_HOST/DB_NAME/DB_USER/DB_PASS values. APP_TITLE is configurable.

.gitignore excludes configuration, environment secrets, logs, common backups, and editor files. Review every commit; ignores are not a universal secret scanner. Keep exports in ignored dumps/ or outside the project. Keep private configuration backups separately. If secrets were committed elsewhere, rotate them and clean that history before sharing.

The app .htaccess denies direct access to SQL, docs, configuration, and common backup files and disables directory listings where supported. Deploy only the explicit runtime allowlist in README. Never upload .git. Keep error logs private.

## Findings and changes

Malformed token arrays could trigger a PHP TypeError; nested answer arrays could trigger conversion warnings. These now return 400. Empty question-bank POSTs now return 500 without recording 0/0. Unhandled exceptions produce a generic response and class-only log entry, avoiding credential-bearing exception messages. Attempt logging failures now produce a generic diagnostic.

No obvious SQL injection or output XSS was found. Initial question HTML excludes answers/explanations. seed.sql contains both and starts with TRUNCATE: never deploy or run it on existing production data. Production exposure and PHP settings were not probed.

Remaining limitations: browser completion checks can be bypassed; omitted answers intentionally score zero; submitting reveals practice answers; no rate limiting or question snapshot; active edits can change grading; multiple tabs share one token. Normal UI, scoring, schema, and question data were preserved.

## Deployment checklist — future authorized work

- [ ] Pass local lint and isolated database/browser checks.
- [ ] Review and commit changes; verify private config is excluded.
- [ ] Securely back up Hostinger files, config, and database.
- [ ] Confirm subdomain document root, PHP/extensions, and staging behavior.
- [ ] Verify disabled display_errors/display_startup_errors and private logging.
- [ ] Verify HTTPS and Secure/HttpOnly/SameSite session cookies.
- [ ] Upload only index.php, submit.php, db.php, app.js, styles.css, tested .htaccess.
- [ ] Preserve production config.php; exclude SQL, docs, examples, .git, backups.
- [ ] No schema migration needed; do not import seed.sql as an upgrade.
- [ ] Perform authorized post-deployment checks and monitor logs.

## Verification checklist

Runtime checks remain pending: no PHP runtime was found and no MySQL/browser integration testing was performed. Use a separate local database first.

- [ ] All PHP files pass php -l.
- [ ] 20 active seeded questions render, with correct Hindi and mobile layout.
- [ ] Initial HTML/network response contains no answers or explanations.
- [ ] Answer counter and browser completion checks work.
- [ ] All-correct gives 20/20 (100%); all-wrong 0/20 (0%); mixed score is correct.
- [ ] Review shows selected/correct answers, explanations, status, and retake link.
- [ ] One attempt row per accepted POST, with correct totals and timestamp.
- [ ] Invalid/missing/array CSRF returns 400 without an attempt.
- [ ] Scalar answers, nested arrays, and invalid letters return 400.
- [ ] Missing choices score zero; unknown question IDs cannot increase score.
- [ ] Refreshing completed POST rejects stale token; GET submit redirects.
- [ ] Empty question bank returns 500 without a zero-question attempt.
- [ ] Unavailable local DB returns generic 500 without credentials/stack trace.
- [ ] Denied local attempt INSERT still shows results and logs generic failure.
- [ ] SQL/config/example config/README requests return 403 or 404.
- [ ] HTML-like question text displays as text, not executable markup.
- [ ] Git excludes real config and database exports.

## Rollback

Before future deployment, record the commit and retain secure file/database backups. Restore prior runtime files, including prior .htaccess if changed, and preserve correct production configuration. These changes need no database rollback. Full database restores may erase newer attempts: preserve post-backup data and plan separately. Recheck quiz, scoring, and logs after restoring. Git cannot restore ignored config; use its secure backup.

## Future ideas

Question snapshots/versioning, PHP/database integration tests, rate limits, accessible validation focus, dynamic introductory question count, authenticated question editing, optional server timers/randomization, and attempt-level answer history with a deliberate privacy policy. Implement only as needed.

