unit class Slangify::Examples;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

my $playground-url = 'https://play.slangify.org';

my &fixed-card  = &article.assuming(:style<height:380px;overflow:hidden>);
my &code-size   = &div.assuming(:style<font-size:0.72rem>);

my sub card($title, $desc, Str $code, :$href = $playground-url) {
    fixed-card [
        header a(strong($title), :$href, :target<_blank>);
        p $desc;
        code-size hilite $code;
    ]
}

sub examples-page(&basepage, $shadow) is export {
    basepage :stub<examples>,
        main [
            $shadow;
            div :align<center>, div :style<width:80%>, [
                h1 'Examples';
                h3 'Integrated tools. Zero dependencies.';
                p 'See a full worked example on the ', a('Comparison', :href</comparison>), ' page — we juxtapose Python since it is commonly used for parsing tasks, but similar limitations apply to any language without native grammars: Rust, Go, TypeScript, and beyond.';
            ];

            grid :cols(3), :gap(2), [
                card 'Word Parser',
                    'Grammar is a first-class language feature — no imports, no external library.',
                    q:to/CODE/;
                grammar WordParser {
                    token TOP    { <word>+ % \s+ }
                    token word   { <letter>+     }
                    token letter { <[a..zA..Z]>  }
                }

                say WordParser.parse("hello world");
                CODE

                card 'Date Parser',
                    'Named captures give every matched part a label — no positional indices to break.',
                    q:to/CODE/;
                grammar DateParser {
                    token TOP   { <year> '-' <month> '-' <day> }
                    token year  { \d ** 4 }
                    token month { \d ** 2 }
                    token day   { \d ** 2 }
                }

                my $m = DateParser.parse("2026-05-12");
                say $m<year>;  # ｢2026｣
                CODE

                card 'Calculator',
                    'Separate structure from semantics — grammar defines shape, actions class defines meaning.',
                    q:to/CODE/;
                grammar Calc {
                    token TOP   { <left> '+' <right> }
                    token left  { \d+               }
                    token right { \d+               }
                }
                class CalcActions {
                    method TOP($/) { make +$<left> + +$<right> }
                }
                say Calc.parse("3+4", actions => CalcActions.new).made;
                CODE

                card 'Grammar Inheritance',
                    'Grammars are classes — extend and override tokens without touching the original.',
                    q:to/CODE/;
                grammar Base {
                    token TOP  { <word>+    }
                    token word { <[a..z]>+  }
                }
                grammar Extended is Base {
                    token word { <[a..z]>+ | <[0..9]>+ }
                }
                say Extended.parse("hello 42 world");
                CODE

                card 'Unicode & NFG',
                    'Match any Unicode script natively — no flags, no extra packages, no encoding surprises.',
                    q:to/CODE/;
                grammar NaturalText {
                    token TOP  { <word>+ % \s+ }
                    token word { <:Letter>+    }
                }

                say NaturalText.parse("café résumé");
                say NaturalText.parse("日本語 한국어");
                CODE

                card 'Expression Eval',
                    'Recursive rules express operator precedence — no external parser generator needed.',
                    q:to/CODE/;
                grammar Expr {
                    rule TOP    { <term>+ % ['+' | '-'] }
                    rule term   { <factor>+ % ['*' | '/'] }
                    rule factor { '(' <TOP> ')' | \d+    }
                }

                say Expr.parse("3 + 4 * 2");
                CODE
            ];
        ];
}
