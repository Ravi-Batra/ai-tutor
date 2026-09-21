(() => {
    const form = document.getElementById('quizForm');
    if (!form) return;

    const cards = [...document.querySelectorAll('.question-card')];
    const counter = document.getElementById('answeredCounter');

    function updateCounter() {
        const answered = cards.filter(card => card.querySelector('input[type="radio"]:checked')).length;
        counter.textContent = `Answered ${answered} of ${cards.length}`;
    }

    form.addEventListener('change', event => {
        if (event.target.matches('input[type="radio"]')) {
            const card = event.target.closest('.question-card');
            const error = card.querySelector('.error-message');
            error.hidden = true;
            card.classList.remove('needs-answer');
            updateCounter();
        }
    });

    form.addEventListener('submit', event => {
        let firstMissing = null;

        cards.forEach(card => {
            const hasAnswer = card.querySelector('input[type="radio"]:checked');
            const error = card.querySelector('.error-message');
            const missing = !hasAnswer;
            error.hidden = !missing;
            card.classList.toggle('needs-answer', missing);
            if (missing && !firstMissing) firstMissing = card;
        });

        if (firstMissing) {
            event.preventDefault();
            firstMissing.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    });

    updateCounter();
})();
