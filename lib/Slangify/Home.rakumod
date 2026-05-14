unit class Slangify::Home;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

my $playground-url = 'https://play.slangify.org';

sub home-page(&basepage, $shadow) is export {
    basepage
        main [
            $shadow;
            grid :grid-template-columns("1fr 2fr 1fr"), [
                div [];
                div [
                    div :align<center>, [
                        h1 'Slangify';
                        h3 'Power up your Domain Specific Language.';

                        pre q:to/PRE/;
                            Design your DSL.
                            Create a Grammar
                            to Parse your syntax.

                            Slangify is here to
                            show you how.

                            We focus on why,
                            where & how to use
                            Raku Grammars.
                            PRE

                        p 'Write grammars the same way you write functions or classes. Build your language with native semantics, composition,  tooling and flow.';

                        p safe Q|<b>examples</b> &nbsp;&middot;&nbsp; <b>tools</b> &nbsp;&middot;&nbsp; <b>quick start</b> &nbsp;&middot;&nbsp; <b>resources</b>|;

                        spacer;

                        p a('Try it in the playground →', :href($playground-url), :target<_blank>);
                    ];

                    div [
                        spacer;
                        markdown q:to/MARKDOWN/;

                        ### Why does parsing still feel like a chore?

                         Most languages treat parsing as an afterthought — something you bolt on with a library, define in a string, and hope behaves.

                         - Why should parsing require a module install?
                         - Why define your grammar as a string, separate from your code?
                         - Why number your capture groups?
                         - Why can't you extend a grammar like a class?

                        ### What if ...

                        A grammar is a class. Tokens are named. The parse tree is instant.
                        MARKDOWN

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

                        spacer;
                        markdown q:to/MARKDOWN/;

                        In Raku, a Slang is a user-defined Domain Specific Language - an embedded DSL.

                        Defined by a Grammar and its Actions, Slang code may be written seamlessly within any Raku code - it becomes part of the wider language.

                        Slangify is the tool that extends the native syntax in a single line of code. It's the simple and powerful way to make your DSL come alive. Either as an an embedding, or as a stand-alone user tool or both.

                        Easy to make, easy to use and easy to maintain.
                        MARKDOWN
                    ];
                ];

                div [];
            ];
        ];
}
