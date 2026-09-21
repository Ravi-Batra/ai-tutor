TRUNCATE TABLE questions;

INSERT INTO questions
(question_no, category, question_text, option_a, option_b, option_c, option_d, correct_option, explanation)
VALUES
(1, 'Hindi Grammar', 'Choose the grammatically correct sentence.',
 'मुझे यह जानकारी कल मिला।', 'मुझे यह जानकारी कल मिली।', 'मुझे यह जानकारी कल मिले।', 'मुझे यह जानकारी कल मिलेंगे।',
 'B', '“जानकारी” is feminine singular, so the verb form “मिली” agrees correctly with it.'),

(2, 'Hindi Grammar', 'Which sentence sounds most natural and professional in standard Hindi?',
 'कृपया डॉक्यूमेंट को चेक करके मुझे बताइए।', 'कृपया दस्तावेज़ की जाँच करके मुझे बताइए।', 'कृपया दस्तावेज़ चेकिंग करके बताओ।', 'डॉक्यूमेंट को जाँच करके मेरे को बताइए।',
 'B', '“कृपया दस्तावेज़ की जाँच करके मुझे बताइए।” is grammatically correct, natural, and professionally written standard Hindi. The other choices contain unnecessary English mixing or less standard phrasing.'),

(3, 'Hindi Grammar', 'Identify the sentence with incorrect agreement.',
 'यह समस्या गंभीर है।', 'यह रिपोर्ट तैयार है।', 'यह जानकारी सही है।', 'यह निर्णय सही हैं।',
 'D', '“यह निर्णय” is singular here, so the correct form is “यह निर्णय सही है।”'),

(4, 'Hindi Grammar', 'Which is the clearest professional rewrite of: “यूज़र को पहले लॉगिन करना पड़ेगा उसके बाद वह अपनी डिटेल्स अपडेट कर सकता है।”',
 'यूज़र पहले लॉगिन करेगा फिर डिटेल्स कर सकता है।', 'उपयोगकर्ता को पहले लॉगिन करना होगा। इसके बाद वह अपनी जानकारी अपडेट कर सकता है।', 'उपयोगकर्ता को लॉगिन पड़ता है और अपनी डिटेल अपडेट।', 'पहले लॉगिन, बाद में यूज़र डिटेल्स।',
 'B', 'This version improves grammar, sentence flow, clarity, and unnecessary English mixing while preserving the original meaning.'),

(5, 'English Comprehension', 'Read: “AI systems can produce fluent answers that are nevertheless incorrect. A high-quality evaluator should therefore assess not only grammar and clarity but also factual accuracy, relevance, and whether claims are properly supported.” What is the main idea?',
 'Fluent answers are always reliable.', 'Grammar is the most important evaluation criterion.', 'AI answers should be checked for more than language quality.', 'AI systems should avoid long answers.',
 'C', 'The passage says evaluation must go beyond fluency and grammar to include factual accuracy, relevance, and evidentiary support.'),

(6, 'English Comprehension', 'According to the passage in Question 5, which of the following should an evaluator check?',
 'Only spelling', 'Only factual accuracy', 'Grammar, clarity, accuracy, relevance, and support for claims', 'Whether the answer sounds confident',
 'C', 'The passage explicitly identifies multiple dimensions of quality, not just one. Confidence of tone is not evidence of correctness.'),

(7, 'English Comprehension', 'Which statement best follows from the passage in Question 5?',
 'A well-written answer may still be wrong.', 'Incorrect answers are usually badly written.', 'AI should never provide factual answers.', 'Evaluators do not need subject knowledge.',
 'A', 'The passage directly states that AI can produce fluent answers that are nevertheless incorrect, so polished writing does not guarantee factual accuracy.'),

(8, 'AI Response Evaluation', 'User: “What is the capital of Australia?” Response A: “Sydney is the capital of Australia.” Response B: “Canberra is the capital of Australia.” Which response is better?',
 'Response A, because Sydney is larger.', 'Response B, because Canberra is factually correct.', 'Response A, because Sydney is more famous.', 'Both are equally good.',
 'B', 'Canberra is the capital of Australia. Size and fame do not determine the capital. Factual correctness should take priority.'),

(9, 'AI Response Evaluation', 'User: “Explain photosynthesis in one sentence.” AI: “Photosynthesis is a highly complex biochemical process involving chlorophyll, electron transport chains, ATP synthesis, carbon fixation, stomatal regulation, and numerous enzymatic pathways through which plants ultimately synthesize carbohydrates.” What is the main problem?',
 'It is factually false.', 'It does not match the requested brevity and simplicity.', 'It uses incorrect English.', 'It is too informal.',
 'B', 'The response is broadly factual, but it does not respect the user’s request for a concise, accessible one-sentence explanation. Instruction-following is part of answer quality.'),

(10, 'AI Response Evaluation', 'User: “Can I take antibiotics for a viral cold?” Which response is better?',
 '“Yes. Antibiotics are useful for most viral colds.”', '“Antibiotics do not treat viruses. They may be prescribed if a bacterial infection is diagnosed, so consult a healthcare professional.”', '“Take any antibiotic you already have at home.”', '“Antibiotics and antiviral medicines are the same.”',
 'B', 'Antibiotics treat bacterial infections, not ordinary viral infections. The second response is safer, more accurate, and appropriately advises professional assessment when needed.'),

(11, 'AI Response Evaluation', 'User: “Who invented the telephone?” AI: “Alexander Graham Bell invented the telephone in 1876, and there is no dispute about this.” What is the main weakness?',
 'The date is impossible.', 'The answer is too short.', 'It presents a historically contested attribution as completely undisputed.', 'Bell had nothing to do with telephones.',
 'C', 'Bell is commonly credited with the telephone, but the history includes other inventors and patent disputes. Saying there is “no dispute” is unjustifiably absolute.'),

(12, 'AI Response Evaluation', 'User: “Summarize this paragraph in 20 words.” The AI produces a 52-word summary. How should an evaluator judge this?',
 'Fully correct because the meaning is accurate.', 'It fails an explicit instruction even if the meaning is accurate.', 'Correct if the grammar is good.', 'Correct if all facts are retained.',
 'B', 'The response violates a clear length constraint. Following explicit instructions is a core part of correctness.'),

(13, 'Fact-checking', 'An AI says: “The human body has 206 bones at birth.” What should you do before approving this claim?',
 'Accept it because 206 is a familiar number.', 'Check a reliable medical source because newborns generally have more bones than adults.', 'Reject it without checking.', 'Search only social media.',
 'B', 'Adults commonly have 206 bones, while newborns generally have more bones that later fuse. A medical factual claim should be checked against a reliable medical source.'),

(14, 'Fact-checking', 'An AI response claims: “India became independent on 15 August 1948.” What is the correct evaluation?',
 'Correct', 'Incorrect; India became independent on 15 August 1947.', 'Partially correct', 'Impossible to verify',
 'B', 'India became independent on 15 August 1947. The year 1948 is incorrect.'),

(15, 'Fact-checking', 'An AI says “Company X has 50,000 employees worldwide.” You find: a 2024 company page saying 42,000; a reputable 2026 news article saying approximately 49,500; and a random blog saying 60,000. Which source should carry the most weight for a current answer?',
 'The random blog', 'The older company page automatically', 'The recent credible news source, while ideally tracing its figure to the latest primary source', 'Average all three figures',
 'C', 'For a current question, recency matters. The 2026 credible report is more relevant than stale data, but the strongest practice is to locate and verify the newer primary source if available.'),

(16, 'Fact-checking', 'An AI gives a statistic but provides no source. What is the best evaluator response?',
 'Accept it if it sounds reasonable.', 'Mark it false immediately.', 'Verify it using a trustworthy source before judging.', 'Search only Wikipedia comments.',
 'C', 'An unsupported claim is not automatically false. The correct approach is to verify it using trustworthy evidence before classifying it.'),

(17, 'Research Judgment', 'You need to verify a current government rule in India. Which source should you prefer first?',
 'WhatsApp message', 'Personal blog', 'Official government website or gazette', 'Anonymous forum',
 'C', 'Primary government sources, including official department websites and gazette notifications, normally provide the strongest authority for current government rules.'),

(18, 'Research Judgment', 'Two sources disagree. Source 1 is an official report from 2022. Source 2 is a reputable 2026 newspaper article citing newly released official data. For a question asking for the current figure, what should you do?',
 'Always use Source 1 because it is official.', 'Use Source 2 cautiously and, if possible, locate the newer official data it cites.', 'Average both figures.', 'Ignore both.',
 'B', 'Authority and recency both matter. The ideal approach is to trace the newer report to the current official dataset rather than relying only on an older primary source.'),

(19, 'Research Judgment', 'Which source is generally strongest for verifying a scientific claim?',
 'A viral social-media post', 'Peer-reviewed research or an authoritative scientific institution', 'A product advertisement', 'An anonymous comment',
 'B', 'Peer-reviewed research and authoritative scientific institutions generally provide stronger evidence. Methodology, date, relevance, and scientific consensus should still be considered.'),

(20, 'Research Judgment', 'An AI answer says: “According to research, 90% of people prefer Product A.” No study, survey, organization, date, sample size, or source is given. What is the best evaluation?',
 'Strong claim because it uses a percentage.', 'Reliable because it says “according to research.”', 'Unsupported claim requiring verification.', 'Correct unless disproved.',
 'C', 'A precise statistic should be traceable to a study, survey, organization, sample, methodology, date, or other reliable source. The phrase “according to research” is not itself evidence.');
