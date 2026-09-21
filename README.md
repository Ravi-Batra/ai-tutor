# AI Tutor — Hindi Mock Test

PHP/MySQL practice assessment covering Hindi grammar, English comprehension, AI-response evaluation, fact-checking, and research judgment.

- Complete local project: `D:\PROJECTS\ai-tutor`
- Live URL: https://ai-tutor.lead9.in/
- Hosting: Hostinger
- Stack: PHP 8+ with PDO MySQL and sessions; MySQL; vanilla HTML/CSS/JavaScript.
- No framework, dependencies, or build step.

## Layout

The application and Git repository both live directly in `D:\PROJECTS\ai-tutor`. PHP, CSS, JavaScript, and configuration remain together, preserving their relative paths. Add this folder to GitHub Desktop.

| File in application folder | Purpose |
| --- | --- |
| index.php | Loads active questions and renders quiz |
| submit.php | Validates POST, scores, saves summary, renders explanations |
| db.php | PDO connection and generic exception response |
| config.php | Private configuration, excluded from Git |
| config.example.php | Safe placeholder configuration |
| app.js / styles.css | Completion checks, counter, responsive layout |
| schema.sql | Questions and attempts table definitions |
| seed.sql | 20 sample questions, answer key, explanations |
| .htaccess | Blocks direct access to private/setup files on compatible servers |

See [HANDOVER.md](HANDOVER.md) for verification, rollback, and future work.

## Local database and configuration

1. Install a supported PHP 8+ release with `pdo_mysql`, MySQL, and Apache 2.4 (for example a local Apache/PHP stack).
2. Create a separate empty database named `ai_tutor_local` with utf8mb4 encoding. Never use the live database for development.
3. Select it in local phpMyAdmin. Import `schema.sql`, then `seed.sql`. **The seed begins with TRUNCATE TABLE questions and deletes existing questions. Use only in a disposable local database.** Schema creation does not migrate existing tables.
4. Create a local runtime account with SELECT on questions and INSERT on attempts. Use a separate administrative account for imports and editing.
5. If config.php is absent, copy config.example.php to config.php in the app folder. If it exists, inspect it privately and set LOCAL credentials before running the app. The existing private file was left unchanged during preparation.
6. Set DB_HOST, DB_NAME, DB_USER, DB_PASS, and APP_TITLE. Never include credentials in commits, screenshots, or documentation.
7. Configure a loopback-only local Apache virtual host with document root `D:/PROJECTS/ai-tutor`. Enable .htaccess overrides for Options, Require (AuthConfig), and RedirectMatch (FileInfo; requires mod_alias), then open its local URL.

Use Apache for this workflow: PHP's built-in server ignores .htaccess and would serve the SQL answer key. Never publicly serve the whole repository. Set PHP display_errors=Off, display_startup_errors=Off, log_errors=On, and a private error-log location. Application-level suppression cannot handle every startup/parse error.

## Flow and scoring

index.php loads active questions ordered by question_no, excluding correct_option and explanation. JavaScript counts answers and normally requires completion. submit.php requires POST and a session CSRF token, reloads active questions, and compares A/B/C/D choices with the database. Lowercase and whitespace are normalized. Each correct answer earns one point; wrong or omitted answers earn zero. Percentage is rounded to a whole number.

Results show selected and correct answers, status, and explanation. Attempts store only score, total_questions, percentage, and submitted_at, without identity or individual choices. Logging failure still allows results and emits a generic log message. The token rotates after scoring; refreshing the old POST is rejected.

## Add questions

In local phpMyAdmin, insert a questions row with unique question_no (1–255), category, question_text, nonempty option_a through option_d, correct_option A/B/C/D, and explanation. Set is_active=1 to show or 0 to hide; id and created_at are automatic. Enter plain text with UTF-8 for Hindi. Use an administrative account.

Never re-import seed.sql to add a question. Test edits locally. Counts and scoring are dynamic, but the introductory sentence says 20 questions; update it if the assessment size changes. Avoid changing active questions during an attempt because grading uses the current database rather than a snapshot.

## Local testing

With PHP on PATH, run from the project root in PowerShell:

```powershell
Get-ChildItem .\*.php | ForEach-Object { php -l $_.FullName }
```

Run the HANDOVER checklist against the local database. All-correct should give 20/20 and 100%; all-wrong should give 0/20 and 0%. Check one attempt row per valid submission. Malformed tokens, nested arrays, and invalid choices should return 400. Omitted answers remain accepted server-side and score zero, preserving existing behavior when JavaScript is bypassed.

PHP was not found on PATH or in the checked common local install locations. Runtime, browser, and database integration tests were not run during preparation; complete them before deploying.

## Security review

- No obvious SQL injection found: static question queries and a parameterized attempt insert, with native PDO prepares.
- Database text is escaped in templates; no obvious rendered XSS found.
- CSRF protection already existed. Malformed field types now return 400 instead of type errors or conversion warnings.
- Unhandled exceptions now return generic 500 responses. Empty question-bank POSTs cannot record misleading 0/0 attempts.
- SQL contains answers: exclude it from deployments. .htaccess adds protection only on compatible servers with overrides enabled.
- Answers intentionally become visible after submission, even with omitted choices. This is a practice quiz, not a secure examination system.
- No login, rate limit, or question snapshot. Multi-tab forms share one rotating token. These limitations are preserved and documented.
- .gitignore cannot remove secrets committed elsewhere. No existing Git repository was found here; remote history was not inspected.

## GitHub Desktop

The local repository is initialized with no commits. Choose **File → Add local repository**, select `D:\PROJECTS\ai-tutor`, and review Changes. config.php must not appear; config.example.php should. Review all content before creating a local commit. Publishing or pushing is a separate decision. Prefer a private repository because seed.sql contains the answer bank. Keep private configuration backups outside Git and database exports in ignored dumps/ or outside this project.

## Safe future deployment — separately authorized

1. Pass local tests, review the diff, and commit a known version.
2. Securely back up Hostinger runtime files, private configuration, and database. Confirm the actual subdomain document root in hosting.
3. Test in a separate staging environment with its own database. Verify .htaccess compatibility and private logging with error display disabled.
4. Upload only index.php, submit.php, db.php, app.js, styles.css, and tested .htaccess from the application folder, preserving the existing URL layout. Preserve production config.php. Never upload local config, example config, SQL, documentation, .git, or backups.
5. These changes require no database migration. Never use seed.sql as a production upgrade.
6. Verify HTTPS and Secure/HttpOnly/SameSite session-cookie settings in hosting PHP configuration.
7. Perform authorized verification, monitor private logs, and restore the prior files if checks fail. See HANDOVER for rollback constraints.

No production access, deployment, publishing, or push occurred during preparation. Local files have not been proven identical to the live deployment.


