unit class Slangify::Examples;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

my $date-url       = 'https://play.slangify.org/d6d88ac49414d683d68eee3ddd1d6cce56b6ec63';
my $calc-url       = 'https://play.slangify.org/673838934ef573f2fcffc9271958291d84169cd4';
my $contact-url    = 'https://raku.land/zef:librasteve/Contact';
my $invoice-url    = 'https://play.slangify.org/37f6f6c7737081b89358496448069cc11551d5f3';
my $restful-url    = 'https://play.slangify.org/9716936e0e292f537f3be29c258a060057cbea1c';
my $http-url       = 'https://github.com/ugexe/Raku-Grammar--HTTP';

my &featured-card = &article.assuming(
    :style('position:relative;height:380px;overflow:hidden;border-left:4px solid #3d6b52')
);
my &regular-card  = &article.assuming(:style('position:relative;height:380px;overflow:hidden'));
my &code-size     = &div.assuming(:style<font-size:0.72rem>);
my &arrow-tag     = &a.assuming(:style('position:absolute;top:0.4rem;right:0.6rem;color:#3d6b52;font-size:0.9rem;text-decoration:none'));

my $open-behind = "var w=window.open(this.href,'_blank');w.blur();window.focus();return false;";

my sub featured($title, $desc, Str $code, $href) {
    featured-card [
        arrow-tag '↗', :$href, :target<_blank>, :onclick($open-behind);
        header a(strong($title), :$href, :target<_blank>, :onclick($open-behind));
        p $desc;
        code-size hilite $code;
    ]
}

my sub card($title, $desc, Str $code) {
    regular-card [
        header a(strong($title));
        p $desc;
        code-size hilite $code;
    ]
}

sub examples-page(&basepage, $shadow, $playground-url) is export {
    basepage :stub<examples>,
        main [
            $shadow;
            div :align<center>, div :style<max-width:80%>, [
                h1 'Examples';
                h3 'From a word list to a full invoice DSL — explore Raku grammars live.';
                p 'Each featured card links to a working playground session. Edit, run, and experiment in your browser. See the ', a('Comparison', :href</comparison>), ' page for a side-by-side with Python.';
            ];
            spacer;

            h3 'Featured';
            p 'Full worked examples — click a title to open in the playground.';
            grid :cols(3), :gap(2), [
                featured 'Date Parser',
                    'Named captures give every matched part a label — no positional indices to break.',
                    q:to/CODE/, $date-url;
                    grammar DateParser {
                        token TOP   { <year> '-' <month> '-' <day> }
                        token year  { \d ** 4 }
                        token month { \d ** 2 }
                        token day   { \d ** 2 }
                    }
                    CODE

                featured 'Calculator',
                    'Separate structure from semantics — grammar defines shape, actions class defines meaning.',
                    q:to/CODE/, $calc-url;
                    grammar Calculator {
                        token TOP { <calc-op> }

                        proto rule calc-op          {*}
                              rule calc-op:sym<add> { <num> '+' <num> }
                              rule calc-op:sym<sub> { <num> '-' <num> }
                              rule calc-op:sym<mul> { <num> '*' <num> }
                              rule calc-op:sym<div> { <num> '/' <num> }

                        token num { \d+ }
                    }
                    CODE

                featured 'Contact',
                    'An ecosystem module - parse contact records accurately - names, addresses, etc.',
                    q:to/CODE/, $contact-url;
                    grammar Contact {
                        rule  TOP    { <name> <email> <phone>?    }
                        rule  name   { <first> <last>             }
                        token first  { <[A..Z]> <[a..z]>+         }
                        token last   { <[A..Z]> <[a..z]>+         }
                        token email  { \S+ '@' \S+ '.' \S+        }
                        token phone  { [\d+]+ % <[-.\s]>          }
                    }
                    CODE

                featured 'RESTful',
                    'Parse structured URLs into named components — verb, subject, and data in one grammar.',
                    q:to/CODE/, $restful-url;
                    grammar REST {
                        token TOP     { <verb> '/' <subject> ['/' <data>]? }
                        token verb    { get | post | put | delete }
                        token subject { \w+  }
                        token data    { \w+  }
                    }
                    CODE

                featured 'Grammar::HTTP',
                    'An ecosystem module — parse HTTP requests into method, target, version, and headers.',
                    q:to/CODE/, $http-url;
                    use Grammar::HTTP;

                    my $req = "GET / HTTP/1.1\r\nHost: www.raku.org\r\n\r\n";
                    my $m   = Grammar::HTTP.parse($req);

                    say $m<request-line><method>;   # ｢GET｣
                    say $m<request-line><target>;   # ｢/｣
                    say $m<header>[0]<field-name>;  # ｢Host｣
                    CODE

                featured 'Invoice DSL',
                    'A full domain-specific language in one grammar — structured fields, items, and totals.',
                    q:to/CODE/, $invoice-url;
                    grammar Invoice {
                        token TOP    { <head> \n <line>+        }
                        rule  head   { invoice <id>             }
                        rule  line   { | date   <date>
                                       | client <quoted>
                                       | item   <quoted> <amount> }
                        token id     { <[A..Za..z0..9_-]>+      }
                        token date   { \d**4 '-' \d**2 '-' \d**2 }
                        token quoted { '"' <( <-["]>+ )> '"'     }
                        token amount { \d+ ['.' \d+]?            }
                    }
                    CODE
            ];
            spacer;

            h3 'Patterns';
            p 'Shorter examples — each one isolates a specific grammar feature.';
            grid :cols(3), :gap(2), [
                card 'Word Parser',
                    'Grammar is a first-class language feature — no imports, no external library.',
                    q:to/CODE/;
                    grammar WordParser {
                        token TOP    { <word>+ % \s+ }
                        token word   { <letter>+     }
                        token letter { <[a..zA..Z]>  }
                    }
                    CODE

                card 'Proto Regexes',
                    'Dispatch on token variants — each sym candidate matches longest-token first.',
                    q:to/CODE/;
                    grammar Expr {
                        token TOP  { <expr>+ % \s+ }
                        proto token expr          {*}
                        token expr:sym<number>    { \d+         }
                        token expr:sym<ident>     { <[a..z]>+   }
                        token expr:sym<operator>  { <[+\-*\/]>  }
                    }
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
                    CODE

                card 'Separator Quantifier',
                    'The % operator matches a list with a delimiter — no manual glue or recursion needed.',
                    q:to/CODE/;
                    grammar CSV {
                        token TOP   { <row>+ % \n   }
                        token row   { <cell>+ % ',' }
                        token cell  { <-[,\n]>*     }
                    }
                    CODE

                card 'Token vs Rule',
                    'token ignores whitespace; rule inserts implicit \s* between atoms — choose deliberately.',
                    q:to/CODE/;
                    grammar Decl {
                        rule  TOP    { let <ident> '=' <value> }
                        token ident  { <[a..z]>+               }
                        token value  { \d+                     }
                    }
                    CODE

                card 'Unicode & NFG',
                    'Match any Unicode script natively — no flags, no extra packages, no encoding surprises.',
                    q:to/CODE/;
                    grammar NaturalText {
                        token TOP  { <word>+ % \s+ }
                        token word { <:Letter>+    }
                    }
                    CODE


            ];
        ];
}
