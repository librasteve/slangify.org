unit class Slangify::Ecosystem;

use Air::Functional :BASE;
use Air::Base;

sub ecosystem-page(&basepage, $shadow) is export {
    basepage :stub<ecosystem>,
        main [
            $shadow;
            div :align<center>, div :style<width:80%>, [
                h1 'Ecosystem';
                h3 'A thriving ecosystem of parsers, DSLs, and syntax extensions.';
                p 'The Raku community has built a rich landscape of modules that put Grammars to work. They can be found on ', a('raku.land', :href<https://raku.land>), '. Here is a selection - they fall into three natural families:';
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
            ];

            h3 'Standard-Format Parsers';
            p 'These modules provide a Grammar and Actions pair for parsing an established, published format or language. Many follow the ', code('…ish'), ' naming convention — a signal that the module speaks that format natively.';
            ul [
                li [ code('Gherkin::Grammar'), ' — BDD test specifications in 73 human languages' ];
                li [ code('Grammar::HTTP'), ' — HTTP headers, message bodies, and URIs' ];
                li [ code('LaTeX::Grammar'), ' — LaTeX math expressions → MathJSON, MathML, AsciiMath' ];
                li [ code('Markdown::Grammar'), ' — converts Markdown to Jupyter, Pod6, Org-mode, HTML' ];
                li [ code('PDF::Grammar'), ' — grammars for PDF content streams, COS, FDF, and document structure' ];
                li [ code('XML'), ' — full-featured XML library built on a Raku grammar' ];
                li [ code('YAMLish'), ' — pure-Raku YAML parser and emitter' ];
            ];

            h3 'Slangs — Grammar Inside the Language Itself';
            p 'A slang hooks a Grammar and Actions pair into Raku\'s own parser, extending the syntax of the language without any preprocessor or macro system. The ', a('Slangify', :href<https://raku.land/zef:lizmat/Slangify>), ' module — this site — manages the lifecycle of all such slangs.';
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
