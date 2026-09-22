<?php
require_once __DIR__ . '/db.php';
session_start();

if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

$stmt = db()->query(
    "SELECT id, question_no, category, question_text, option_a, option_b, option_c, option_d
     FROM questions
     WHERE is_active = 1
     ORDER BY question_no ASC"
);
$questions = $stmt->fetchAll();

if (!$questions) {
    http_response_code(500);
    exit('No active questions found. Import schema.sql and seed.sql first.');
}
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars(APP_TITLE) ?></title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<main class="container">
    <header class="hero">
        <p class="eyebrow">Practice Assessment &bull; Updated</p>
        <h1><?= htmlspecialchars(APP_TITLE) ?></h1>
        <p>20 questions covering Hindi grammar, English comprehension, AI-response evaluation, fact-checking, and research judgment.</p>
        <div class="meta">
            <span>Questions: <?= count($questions) ?></span>
            <span>Suggested time: 45–60 minutes</span>
        </div>
    </header>

    <form id="quizForm" action="submit.php" method="post" novalidate>
        <input type="hidden" name="csrf_token" value="<?= htmlspecialchars($_SESSION['csrf_token']) ?>">

        <?php foreach ($questions as $q): ?>
            <section class="question-card" data-question="<?= (int)$q['question_no'] ?>">
                <div class="question-heading">
                    <span class="question-number">Q<?= (int)$q['question_no'] ?></span>
                    <span class="category"><?= htmlspecialchars($q['category']) ?></span>
                </div>
                <h2><?= nl2br(htmlspecialchars($q['question_text'])) ?></h2>

                <div class="options">
                    <?php foreach (['A', 'B', 'C', 'D'] as $letter):
                        $field = 'option_' . strtolower($letter);
                    ?>
                        <label class="option">
                            <input type="radio" name="answers[<?= (int)$q['id'] ?>]" value="<?= $letter ?>">
                            <span class="option-letter"><?= $letter ?></span>
                            <span><?= htmlspecialchars($q[$field]) ?></span>
                        </label>
                    <?php endforeach; ?>
                </div>
                <p class="error-message" hidden>Please select an answer.</p>
            </section>
        <?php endforeach; ?>

        <div class="submit-panel">
            <p id="answeredCounter">Answered 0 of <?= count($questions) ?></p>
            <button type="submit">Submit Test</button>
        </div>
    </form>
</main>
<script src="app.js"></script>
</body>
</html>
