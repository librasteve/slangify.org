unit class Slangify::How;

use Air::Functional :BASE;
use Air::Base;

sub how-page(&basepage, $shadow, $playground-url) is export {
    basepage :stub<how>,
        main [
            $shadow;
            div :align<center>, div :style<width:80%>, [
                h1 'How Native Grammars';
                h3 'Tools and environments for writing Raku grammars and DSLs.';
                p 'Here is a reflection of the Raku ', a('tools' , :href<https://raku.org/tools>), '. Since Raku Grammars are built-in, all the regular tools apply and some have Grammar specific features ... just follow the ', a('Install' , :href<https://raku.org/install>), ' guidance to get started.';
            ];

            grid :style<width:800px>, :cols(2), :gap(1), [
                article :style('min-width: 0;'), [
                    header h3 'Environments';
                    main markdown q:to/END/;

                    ### Language Servers

                    Editor-agnostic tools for syntax highlighting, autocompletion, etc. Consider using a Language Server over a syntax-highlighting extension for a richer development experience.

                     - [Raku Navigator](https://github.com/bscan/RakuNavigator) Raku language support for VS Code, Emacs, neovim and others.

                    ### Editor Plugins

                    Editor-specific tools, mostly syntax highlighters.

                    #### JetBrains IntelliJ

                     - [Raku IntelliJ Plugin](https://github.com/ab5tract/raku-intellij-plugin) for use with IntelliJ [IDEs](https://www.jetbrains.com/idea/download).

                    #### Visual Studio Code

                     - [Raku Navigator](https://github.com/bscan/RakuNavigator) LSP language server.

                    #### Vim

                     - [Raku syntax highlighting](https://github.com/Raku/vim-raku)

                    #### Emacs

                     - [raku-mode](https://github.com/Raku/raku-mode), an Emacs major mode for Raku which provides syntax highlighting (and more)
                     - [Spacemacs](https://github.com/syl20bnr/spacemacs), an Emacs wrapper with vim key-bindings and extra stuff

                    #### Nano

                     - [Raku syntax highlighting](https://github.com/hankache/raku.nanorc)

                    #### Geany

                     - [Geany](https://www.geany.org) is a popular flyweight Open Source IDE - now supports Raku.

                    END
                ];
                article :style('min-width: 0;'), [
                    header h3 'Interact & Download';
                    main markdown q:to/END/;

                    #### Grammar Editor

                     - [TUI and web based grammar editor (as featured in "playground")](https://raku.land/zef:FCO/Selkie::UI)

                    #### Sandboxes

                     - [Raku track on exercism.io](https://exercism.io/tracks/raku)
                     - [Online Raku compiler (most up to date)](https://repl.it/languages/raku)
                     - [Online Raku REPL (glot.io)](https://glot.io/new/raku)
                     - [Online Raku REPL (tio.run)](https://tio.run/#perl6)
                     - [Online Rakudoc editor](https://pod6.in/)

                    #### Notebooks

                     - [Jupyter Chatbook](https://raku.land/zef:antononcube/Jupyter::Chatbook)
                     - [Jupyter Kernel](https://raku.land/zef:bduggan/Jupyter::Kernel)
                     - [Jupyter Binder](https://github.com/rcmlz/raku-binder-env)

                    #### Cheatsheet

                     - [Cheatsheet](https://raw.githubusercontent.com/Raku/mu/master/docs/Perl6/Cheatsheet/cheatsheet.txt)

                    #### Latest Releases

                    Check out the latest release versions at [Rakudo News](https://rakudo.org/news).

                    #### Download Options

                    Visit the [install page](https://raku.org/nav/1/install) for the most convenient installation option for Linux, macOS, Windows and Docker.

                    Other download, build and installation options are available at [Rakudo Downloads](https://rakudo.org/downloads).
                    END
                ];
            ];
        ];
}
