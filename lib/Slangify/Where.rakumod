unit class Slangify::Where;

use Air::Functional :BASE;
use Air::Base;

sub where-page(&basepage, $shadow, $playground-url) is export {
    basepage :stub<where>,
        main [
            $shadow;
            grid :grid-template-columns("1fr 2fr 1fr"), [
                div [];
                div [
                    div :align<center>, [
                        h1 'Where DSLs Shine';
                        h3 'Three scenarios where a grammar pays back immediately.';
                    ];

                    spacer;
                    markdown q:to/MARKDOWN/;

                    ### Ground Your AI

                    LLMs are fluent — but fluency without constraint is noise. Feed an invoice, a contract, or a form to a model and it will extract the key fields regardless of layout or language. The problem is what comes back.

                    Define a DSL for the expected result — line items, totals, parties, dates — and instruct the model to respond in that form. A Raku Grammar validates the output, rejects malformed responses, and hands clean structured data to the rest of your pipeline. An inversion-of-control harness can tighten the prompt and retry on failure. The LLM provides the reading; the grammar provides the contract.

                    MARKDOWN

                    spacer;
                    markdown q:to/MARKDOWN/;

                    ### Close the Gap

                    Martin Fowler called it the sweet spot — DSLs that are *business-readable*, if not business-writeable. The goal is not to eliminate programmers; it is to shrink what he called the Yawning Crevasse of Doom between the people who understand the domain and the people who build the system.

                    A pricing analyst expressing discount rules. A compliance officer defining validation logic. A content editor writing workflow conditions. Each working in a language shaped to their problem, not the machine's. The grammar enforces correctness; the domain expert provides intent. Raku grammars are classes — they compose, inherit, and evolve alongside the domain they describe.

                    MARKDOWN

                    spacer;
                    markdown q:to/MARKDOWN/;

                    ### Focus the Code

                    Consider a pricing engine. Without a DSL, discount rules live buried in nested conditionals — hard to audit, harder to change when the business shifts. With a DSL the rules become readable declarations:

                    ```
                    10% off orders above £500
                    free shipping above £100
                    loyalty discount 5% after 12 months
                    ```

                    The Grammar parses these rules. The Actions apply them. When the rules change — and they always change — you edit the DSL, not the engine. The implementation is hidden; the intent is visible; the tests stay green.

                    This is what Fowler means by a semantic layer: a thin, expressive surface that maps cleanly onto domain concepts. Raku's Grammar and Actions classes make that layer a first-class citizen of the language — no framework required, no strings evaluated at runtime, no magic.

                    MARKDOWN

                    spacer;
                    p [ small [ 'Concepts and terminology drawn from Martin Fowler, ', a('Domain-Specific Languages', :href<https://martinfowler.com/books/dsl.html>), ' (Addison-Wesley, 2010) and ', a('martinfowler.com/bliki/DomainSpecificLanguage', :href<https://martinfowler.com/bliki/DomainSpecificLanguage.html>), '.' ] ];
                ];
                div [];
            ];
        ];
}
