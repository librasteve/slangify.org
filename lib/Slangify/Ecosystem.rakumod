unit class Slangify::Ecosystem;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

sub ecosystem-page(&basepage, $shadow, $playground-url) is export {
    basepage :stub<ecosystem>,
        main [
            $shadow;
            div :align<center>, div :style<width:80%>, [
                h1 'Ecosystem';
                h3 'A thriving ecosystem of parsers, DSLs, and syntax extensions.';
                p 'There is a rich landscape of modules that put Grammars to work. They can be found on ', a('raku.land', :href<https://raku.land>), '. Use, adapt, extend, collaborate or publish your own. Here is a selection - they fall into three natural families:';
            ];

            h3 'Custom Domain-Specific Languages';
            p 'These modules define a bespoke mini-language for a particular problem domain. Modules with ', code('DSL'), ' in the name translate natural-language commands into runnable code in multiple target languages; others define custom grammars for configuration, diagrams, or grammar meta-languages.';
            ul [
                li [ code('ANTLR4::Grammar'), ' — converts ANTLR4 grammar files into Raku grammars' ];
                li [ code('Config::BINDish'), ' — extensible BIND9-style configuration file parser' ];
                li [ code('Contact'), ' — parses free-form contact details into structured data' ];
                li [ code('DSL::Bulgarian'), ' — the same workflow DSLs, spoken in Bulgarian' ];
                li [ code('DSL::English::ClassificationWorkflows'), ' — natural language → ML classification pipelines' ];
                li [ code('DSL::English::DataQueryWorkflows'), ' — English commands → Julia, Python, R, SQL data workflows' ];
                li [ code('EBNF::Grammar'), ' — parse an EBNF spec and generate a working Raku grammar' ];
                li [ code('MermaidJS::Grammar'), ' — Mermaid diagram specs → Graphviz, PlantUML, Mathematica' ];
                li [ code('Sparrow6'), ' — task-runner automation DSL — define and run portable pipeline steps' ];
                li [ code('Vixen'), ' — declarative reactive UI DSL for building browser interfaces' ];
            ];

            h3 'Standard-Format Parsers';
            p 'These modules provide a Grammar and Actions pair for parsing an established, published format or language. Many follow the ', code('…ish'), ' naming convention — a signal that the module speaks that format natively.';
            ul [
                li [ code('Cro::Template'), ' — Cro template construct grammar with named alternation' ];
                li [ code('Gherkin::Grammar'), ' — BDD test specifications in 73 human languages' ];
                li [ code('Grammar::HTTP'), ' — HTTP headers, message bodies, and URIs' ];
                li [ code('Jinja2'), ' — template syntax grammar using proto-token dispatch on delimiters' ];
                li [ code('LaTeX::Grammar'), ' — LaTeX math expressions → MathJSON, MathML, AsciiMath' ];
                li [ code('Markdown::Grammar'), ' — converts Markdown to Jupyter, Pod6, Org-mode, HTML' ];
                li [ code('PDF::Grammar'), ' — grammars for PDF content streams, COS, FDF, and document structure' ];
                li [ code('Rakudoc'), ' — Raku\'s native documentation format — grammar parses pod blocks, directives, and inline markup' ];
                li [ code('XML'), ' — full-featured XML library built on a Raku grammar' ];
                li [ code('YAMLish'), ' — pure-Raku YAML parser and emitter' ];
            ];

            div grid :style('width:800px;'), :cols(2), :gap(1), [
                article :style('min-width: 0;'), [
                    header strong 'Jinja2 Template';
                    p 'Proto tokens dispatch on sigil — one grammar covers text, expressions, and blocks.';
                    hilite q:to/CODE/;
                    grammar Jinja2 {
                        token TOP              { <node>*  }
                        proto token node       { * }
                        token node:sym<text>   { <-[{]>+  }
                        token node:sym<expr>   { '{{' \s* <ident> \s* '}}' }
                        token node:sym<block>  { '{%' \s* \w+ \s* '%}'     }
                        token ident            { <[a..z_]> \w*             }
                    }
                    CODE
                ];
                article :style('min-width: 0;'), [
                    header strong 'Cro Template';
                    p 'Named alternation parses each template construct — text, tags, and calls stay distinct.';
                    hilite q:to/CODE/;
                    grammar CroTemplate {
                        token TOP             { <node>* }
                        proto token node      { * }
                        token node:sym<text>  { <-[<]>+     }
                        token node:sym<tag>   { '<.' <ident> '>' <node>* '</' <ident> '>' }
                        token node:sym<call>  { '<&' <ident> '/>'                         }
                        token ident           { <[a..z\-]>+ }
                    }
                    CODE
                ];
            ];

            h3 'Slangs — Grammar Inside the Language Itself';
            p 'A slang hooks a Grammar and Actions pair into Raku\'s own parser, extending the syntax of the language without any preprocessor or macro system. The ', a('Slangify', :href<https://raku.land/zef:lizmat/Slangify>, :target<_blank>), ' module (which inspired the name of this website) manages the lifecycle of all such slangs.';
            ul [
                li [ code('Grammar::Debugger'), ' — interactive step-debugger for any Raku grammar' ];
                li [ code('Physics::Measure'), ' — unit expressions parsed from free text: "miles per hour", "mph", "m.s⁻¹"' ];
                li [ code('Slang::Emoji'), ' — single emoji characters become valid scalar variables' ];
                li [ code('Slang::Kazu'), ' — Japanese numeral literals in Raku source' ];
                li [ code('Slang::Lambda'), ' — use λ as a pointy-block starter in place of ', code('->') ];
                li [ code('Slang::Roman'), ' — Roman-numeral literals: ', code('0rMMXXVI'), ' evaluates to 2026' ];
                li [ code('Slang::SQL'), ' — embed SQL literals directly in Raku source; parameterised queries included' ];
            ];
        ];
}
