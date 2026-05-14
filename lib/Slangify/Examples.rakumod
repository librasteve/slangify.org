unit class Slangify::Examples;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

my $playground-url = 'https://play.slangify.org';

my sub card($title, $desc, Str $code, :$href = $playground-url) {
    my $esc = $code.subst('<', '&lt;', :g).subst('>', '&gt;', :g);
    my $preview = safe(
        '<div style="position:relative;height:170px;overflow:hidden;background:#0d1117">'
        ~ '<pre style="margin:0;padding:1.1rem 1.25rem;font-size:0.6rem;color:#c9d1d9;line-height:1.6;font-family:ui-monospace,monospace"><code>'
        ~ $esc
        ~ '</code></pre>'
        ~ '<div style="position:absolute;inset:auto 0 0 0;height:56px;background:linear-gradient(transparent,#0d1117)"></div>'
        ~ '</div>'
    );
    a(
        article(
            [$preview;
             div :style<padding:1rem 1.1rem 1.2rem>, [
                 div :style<display:flex;justify-content:space-between;align-items:center;margin-bottom:0.35rem>, [
                     strong $title;
                     safe '<span style="color:#3d6b52;font-size:0.85rem">↗</span>';
                 ];
                 p :style<font-size:0.8rem;margin:0;line-height:1.45>, $desc;
             ];],
            :class<example-card>,
            :style<overflow:hidden;padding:0;cursor:pointer;border-top:3px solid #3d6b52>
        ),
        :href($href),
        :target<_blank>,
        :style<display:block;text-decoration:none;color:inherit>
    )
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

            safe Q:to/STYLE/;
            <style>
            .example-card { transition: transform 0.22s ease, box-shadow 0.22s ease; }
            .example-card:hover { transform: translateY(-6px); box-shadow: 0 22px 44px rgba(61,107,82,0.22); }
            </style>
            STYLE

            grid :cols(3), :gap(4), [
                card 'Word Parser',
                    'No imports, no external strings — grammar is a first-class language feature.',
                    q:to/CODE/;
                grammar WordParser {
                    token TOP    { <word>+ % \s+ }
                    token word   { <letter>+     }
                    token letter { <[a..zA..Z]>  }
                }

                say WordParser.parse("hello world");
                CODE

                card 'Date Parser',
                    'Named captures label every match — swap rule order and your code still works.',
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
                    'Actions classes keep structure and meaning apart — grammar defines shape, class defines what it does.',
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
                    'Grammars are classes — inherit and override individual tokens without touching the original.',
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
                    'All Raku strings are NFG — "é".chars == 1, not 2. Match any script, no flags needed.',
                    q:to/CODE/;
                grammar NaturalText {
                    token TOP  { <word>+ % \s+ }
                    token word { <:Letter>+    }
                }

                say NaturalText.parse("café résumé");
                say NaturalText.parse("日本語 한국어");
                CODE

                card 'Expression Eval',
                    'Recursive rules express operator precedence — factor inside term inside expr, no hacks needed.',
                    q:to/CODE/;
                grammar Expr {
                    rule TOP    { <term>+ % ['+' | '-'] }
                    rule term   { <factor>+ % ['*' | '/'] }
                    rule factor { '(' <TOP> ')' | \d+    }
                }

                say Expr.parse("3 + 4 * 2");
                CODE
            ];

            h3 'Built In — Not Bolted On';
            p 'Python needs an external library and a grammar string stored separately from the code. Raku grammars are a first-class language feature — the same syntax you use everywhere.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                # Python: external library + grammar-as-string
                from lark import Lark

                GRAMMAR = r"""
                    start: word+
                    word:  LETTER+
                    LETTER: /[a-z]/i
                """

                parser = Lark(GRAMMAR)
                tree = parser.parse("hello world")
                HILITE

                hilite q:to/HILITE/;
                # Raku: grammar is part of the language
                grammar WordParser {
                    token TOP    { <word>+ % \s+ }
                    token word   { <letter>+     }
                    token letter { <[a..zA..Z]>  }
                }

                say WordParser.parse("hello world");
                HILITE
            ];

            h3 'Named Captures — An Instant Parse Tree';
            p 'Lark builds a tree, but you still navigate it by position — swap two rules and your indices silently break. Raku grammar tokens give every matched part a name, so the parse tree is self-documenting.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                from lark import Lark

                GRAMMAR = r"""
                    start: year "-" month "-" day
                    year:  /\d{4}/
                    month: /\d{2}/
                    day:   /\d{2}/
                """

                parser = Lark(GRAMMAR)
                tree = parser.parse("2026-05-12")

                # navigate the tree by child position
                year  = tree.children[0].children[0]
                month = tree.children[1].children[0]
                day   = tree.children[2].children[0]
                HILITE

                hilite q:to/HILITE/;
                grammar DateParser {
                    token TOP   { <year> '-' <month> '-' <day> }
                    token year  { \d ** 4 }
                    token month { \d ** 2 }
                    token day   { \d ** 2 }
                }

                my $m = DateParser.parse("2026-05-12");
                say $m<year>;   # ｢2026｣  named, not positional
                say $m<month>;  # ｢05｣
                say $m<day>;    # ｢12｣
                HILITE
            ];

            h3 'Actions Classes — Parsing Separate from Semantics';
            p 'In Python you mix tree-walking into the transformer class. Raku keeps the grammar (structure) and actions class (meaning) cleanly apart, so each can evolve independently.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                from lark import Lark, Transformer

                GRAMMAR = r"""
                    start: left "+" right
                    left:  /\d+/
                    right: /\d+/
                """

                class CalcActions(Transformer):
                    def left(self, t):  return int(t[0])
                    def right(self, t): return int(t[0])
                    def start(self, t): return t[0] + t[1]

                parser = Lark(GRAMMAR)
                print(CalcActions().transform(parser.parse("3+4")))
                # 7
                HILITE

                hilite q:to/HILITE/;
                grammar Calc {                        # structure only
                    token TOP    { <left> '+' <right> }
                    token left   { \d+                }
                    token right  { \d+                }
                }

                class CalcActions {                   # meaning only
                    method TOP($/)   { make +$<left> + +$<right> }
                }

                say Calc.parse("3+4", actions => CalcActions.new).made;
                # OUTPUT: 7
                HILITE
            ];

            h3 'Grammar Inheritance — Composable & Extensible';
            p 'Raku grammars are classes. You can inherit from them and override individual tokens or rules — extend a grammar without touching the original.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                from lark import Lark

                # no grammar inheritance — copy-paste or
                # string manipulation required
                BASE_GRAMMAR = r"""
                    start: word+
                    word:  LETTER+
                    LETTER: /[a-z]/
                """

                EXTENDED = BASE_GRAMMAR + r"""
                    word: LETTER+ | DIGIT+
                    DIGIT: /[0-9]/
                """

                parser = Lark(EXTENDED)
                print(parser.parse("hello 42 world"))
                HILITE

                hilite q:to/HILITE/;
                grammar Base {
                    token TOP    { <word>+      }
                    token word   { <[a..z]>+   }
                }

                grammar Extended is Base {
                    token word   { <[a..z]>+ | <[0..9]>+ }  # override one token
                }

                say Extended.parse("hello 42 world");
                # ｢hello 42 world｣
                HILITE
            ];

            h3 'Unicode Properties — Match Any Language Natively';
            p 'Python\'s Lark uses re terminals by default, which are ASCII-only — handling accented letters or non-Latin scripts needs an extra regex flag and a third-party install. Raku grammars understand Unicode categories natively, and all Raku strings are NFG (Normal Form Grapheme) — every ', code('Str'), ' counts user-perceived characters, so ', code('"é".chars'), ' is ', code('1'), ', not ', code('2'), '. The same grammar parses English, Arabic, Japanese, or emoji without extra dependencies or encoding surprises.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                from lark import Lark

                # Lark terminals use re by default — ASCII only
                GRAMMAR = r"""
                    start: word+
                    word:  LETTER+
                    LETTER: /[a-zA-Z]+/   # fails on accented chars
                """
                parser = Lark(GRAMMAR)
                parser.parse("café résumé")  # UnexpectedCharacters

                # Unicode: extra flag + pip install regex
                GRAMMAR2 = r"""
                    start: word+
                    word:  LETTER+
                    LETTER: /\p{L}+/
                """
                parser2 = Lark(GRAMMAR2, regex=True)
                print(parser2.parse("café résumé"))
                HILITE

                hilite q:to/HILITE/;
                grammar NaturalText {
                    token TOP  { <word>+ % \s+ }
                    token word { <:Letter>+    }  # any Unicode letter, NFG-aware
                }

                # all Raku Str are NFG — "é".chars == 1, not 2
                say NaturalText.parse("café résumé");
                # ｢café résumé｣

                say NaturalText.parse("日本語 한국어");
                # ｢日本語 한국어｣
                HILITE
            ];
        ];
}
