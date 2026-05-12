unit class Slangify::Why;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

my $playground-url = 'https://play.slangify.org';

sub why-page(&basepage) is export {
    basepage
        main [
            div :align<center>, [
                h1 'Why Raku Grammars';
                h3 'Native grammar support. Zero dependencies.';
                p 'Try any of these examples live in the ', a('playground', :href($playground-url), :target<_blank>), '.';
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
            p 'Python regex groups are positional and easy to confuse. Raku grammar tokens give every matched part a name, so the parse tree is self-documenting.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                import re

                # Which group is the month again?
                m = re.match(
                    r"(\d{4})-(\d{2})-(\d{2})",
                    "2026-05-12"
                )
                year  = m.group(1)   # fragile positional index
                month = m.group(2)
                day   = m.group(3)
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
                from lark import Transformer

                class CalcTransformer(Transformer):
                    def add(self, items):
                        return items[0] + items[1]   # interleaved logic
                    def number(self, items):
                        return float(items[0])
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

            h3 'Grammar Inheritance — Composable &amp; Extensible';
            p 'Raku grammars are classes. You can inherit from them and override individual tokens or rules — extend a grammar without touching the original.';
            grid :cols(2), :gap(6), [
                hilite :lang('python'), q:to/HILITE/;
                # Python Lark: no grammar inheritance —
                # copy-paste or string manipulation required
                BASE_GRAMMAR = r"""
                    word: LETTER+
                    LETTER: /[a-z]/
                """

                EXTENDED = BASE_GRAMMAR + r"""
                    word: LETTER+ | DIGIT+
                    DIGIT: /[0-9]/
                """
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
        ];
}
