unit class Slangify::Where;

use Air::Functional :BASE;
use Air::Base;

sub where-page(&basepage, $shadow) is export {
    basepage :stub<where>,
        main [
            $shadow;
            div :align<center>, div :style<width:80%>, [
                h1 'Where Native Grammars';
                h3 'A thriving ecosystem of parsers, DSLs, and syntax extensions.';
                p 'Because grammars are a first-class Raku feature — not a library bolt-on — the community has built a rich landscape of modules that put them to work. Here is a selection of modules that fall into three natural families.';
            ];

            h3 'placeholder';
        ];
}
