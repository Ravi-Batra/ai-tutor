<?php
require_once __DIR__ . '/db.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$submittedToken = $_POST['csrf_token'] ?? '';
if (!is_string($submittedToken) || empty($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $submittedToken)) {
    http_response_code(400);
    exit('Invalid form submission. Please return to the test and try again.');
}

$answers = $_POST['answers'] ?? [];
if (!is_array($answers)) {
    http_response_code(400);
    exit('Invalid answers. Please return to the test and try again.');
}
foreach ($answers as $answer) {
    if (!is_string($answer) || !in_array(strtoupper(trim($answer)), ['A', 'B', 'C', 'D'], true)) {
        http_response_code(400);
        exit('Invalid answers. Please return to the test and try again.');
    }
}

$stmt = db()->query(
    "SELECT id, question_no, category, question_text, option_a, option_b, option_c, option_d,
            correct_option, explanation
     FROM questions
     WHERE is_active = 1
     ORDER BY question_no ASC"
);
$questions = $stmt->fetchAll();
if (!$questions) {
    http_response_code(500);
    exit('No active questions are available. Please try again later.');
}

$score = 0;
$review = [];
$allowed = ['A', 'B', 'C', 'D'];

foreach ($questions as $q) {
    $qid = (string)$q['id'];
    $selected = isset($answers[$qid]) ? strtoupper(trim((string)$answers[$qid])) : null;
    if ($selected !== null && !in_array($selected, $allowed, true)) {
        $selected = null;
    }

    $isCorrect = $selected !== null && hash_equals($q['correct_option'], $selected);
    if ($isCorrect) {
        $score++;
    }

    $optionMap = [
        'A' => $q['option_a'],
        'B' => $q['option_b'],
        'C' => $q['option_c'],
        'D' => $q['option_d'],
    ];

    $review[] = [
        'question_no' => $q['question_no'],
        'category' => $q['category'],
        'question_text' => $q['question_text'],
        'selected' => $selected,
        'selected_text' => $selected ? $optionMap[$selected] : 'Not answered',
        'correct' => $q['correct_option'],
        'correct_text' => $optionMap[$q['correct_option']],
        'is_correct' => $isCorrect,
        'explanation' => $q['explanation'],
    ];
}

$total = count($questions);
$percentage = $total > 0 ? round(($score / $total) * 100) : 0;

try {
    $insert = db()->prepare(
        "INSERT INTO attempts (score, total_questions, percentage, submitted_at)
         VALUES (:score, :total, :percentage, NOW())"
    );
    $insert->execute([
        ':score' => $score,
        ':total' => $total,
        ':percentage' => $percentage,
    ]);
} catch (Throwable $e) {
    // Scoring still works even if attempt logging fails.
    error_log('AI Tutor: attempt logging failed.');
}

// Rotate the token so a stale results-page POST cannot be replayed indefinitely.
$_SESSION['csrf_token'] = bin2hex(random_bytes(32));
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Results - <?= htmlspecialchars(APP_TITLE) ?></title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<main class="container">
    <section class="result-summary">
        <p class="eyebrow">Your Result</p>
        <h1><?= $score ?> / <?= $total ?></h1>
        <p class="percentage"><?= $percentage ?>%</p>
        <p>
            <?php if ($percentage >= 90): ?>Strong preparation level.
            <?php elseif ($percentage >= 75): ?>Good preparation; review the missed questions.
            <?php elseif ($percentage >= 55): ?>Moderate preparation; more practice is recommended.
            <?php else: ?>Focus on language quality, fact-checking, instruction-following, and source evaluation.
            <?php endif; ?>
        </p>
        <a class="button-link" href="index.php">Retake Test</a>
    </section>

    <h2 class="review-title">Question-by-question review</h2>

    <?php foreach ($review as $item): ?>
        <section class="review-card <?= $item['is_correct'] ? 'correct' : 'incorrect' ?>">
            <div class="question-heading">
                <span class="question-number">Q<?= (int)$item['question_no'] ?></span>
                <span class="category"><?= htmlspecialchars($item['category']) ?></span>
                <span class="status"><?= $item['is_correct'] ? 'Correct' : 'Incorrect' ?></span>
            </div>
            <h3><?= nl2br(htmlspecialchars($item['question_text'])) ?></h3>
            <p><strong>Your answer:</strong>
                <?= $item['selected'] ? htmlspecialchars($item['selected'] . '. ' . $item['selected_text']) : 'Not answered' ?>
            </p>
            <p><strong>Correct answer:</strong> <?= htmlspecialchars($item['correct'] . '. ' . $item['correct_text']) ?></p>
            <div class="explanation">
                <strong>Explanation</strong>
                <p><?= nl2br(htmlspecialchars($item['explanation'])) ?></p>
            </div>
        </section>
    <?php endforeach; ?>
</main>
</body>
</html>
