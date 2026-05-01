unit module Cragcli;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Asciinema;

my $source = external :href<https://github.com/librasteve/raku-App-Crag>;

sub code-note($s) {
    p( :style('font-size:small; text-align:right'), em("...$s") )
}
sub vignette(*@a, *%h) {
    grid :grid-template-columns<2.2fr 3.2fr>, :gap(1.5), |%h, @a
}

my &index = &page.assuming( #:REFRESH(15),
    title => 'CragCLI',
    description => 'CragCLI: Command Line Calculator',

    nav => nav(
        logo =>
            span(
                a( :href<https://cragcli.info>, :target<_self>, :style("display: flex; align-items: center; gap: 0.5rem; text-decoration: none;"),
                [
                    img( :src</img/IMG_0159_mid.png>, :width<80px> );
                    p "CragCLI";
                ])
            ),
        items   => [:$source],
        widgets => [lightdark],
    ),

    footer => footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Remembered by <a href="https://fco.github.io/Red/" target="_blank">red</a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styleed by <a href="https://picocss.com" target="_blank">picocss</a>.
    |),
);

my @tools = [Analytics.new: :provider(Umami), :key<132eec10-cb18-4a4a-be38-84f6d693f249>,];

# https://commons.wikimedia.org/wiki/File:Horsenden_Hill_contours.jpg#Licensing
my &shadow = &background.assuming(
    :src</img/Horsenden_Hill_contours.jpg>,
    :top(120), :height(480), :size('cover'),
);

our $site =
site :@tools, :register[Background.new, LightDark.new, Air::Plugin::Asciinema.new, Tabs.new], :theme-color<green>, :bold-color<saddlebrown>,
    index
        main [
            shadow;
            div :align<center>, [
                h1 b 'CragCLI: Command Line Calculator';
                h4 b 'with AI and dimensional analysis';
                spacer;
            ];

            div [
                p :style('margin-bottom: unset;'), b em 'the boring bits: ';
                tabs [
                    Arithmetic => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Arithmetic

                                  - `+`add,`-`subtract, `*`multiply, `/`divide
                                  - `()` parentheses (bidmas precedence)
                                  - `-ve` numbers
                                  - `%` modulo operator

                                Just type `crag` in your console: `exit` to quit.
                                END
                                code-note 'starts in 1 second [note 1]';
                            ];
                            article [
                                asciinema '/static/demos/demo-Arithmetic.cast';
                            ];
                        ];

                    Functions => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Functions

                                  - `x%` percent
                                  - `1/x` reciprocal
                                  - `x!` factorial
                                  - `sqrt x` square root
                                  - `x**2`, `x**3`, `x**n` powers
                                  - `x**(1/2)`, `x**(1/3)`, `x**(1/n)` roots

                                Use `Up` / `Down` keys to navigate history.
                                END
                                code-note 'right in your terminal';
                            ];
                            article [
                                asciinema '/static/demos/demo-Functions.cast';
                            ];
                        ];

                    Logs => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Logarithms & Exponentials

                                  - `log10 x` base `10` logarithms
                                  - `log x` natural logarithms (base `e`)
                                  - `exp x` exponentials

                                Use `$_` for previous result (the topic)
                                END
                                code-note 'Euler\'s identity works fine';
                            ];
                            article [
                                asciinema '/static/demos/demo-Logs.cast';
                            ];
                        ];

                    Trig => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Trigonometric & Hyperbolic

                                  - `sin x`, `cos x`, `tan x` trigonometry
                                  - `asin x`, `acos x`, `atan x` inverse
                                  - `sinh x`, `cosh x`, `tanh x` hyperbolics
                                  - `asinh x`, `acosh x`, `atanh x` inverse

                                Use `Inf` (or ∞) for infinity.
                                END
                                code-note 'degrees, radians, grads';
                            ];
                            article [
                                asciinema '/static/demos/demo-Trig.cast';
                            ];
                        ];

                    Fractions => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Fractions

                                  - no rounding, exact math
                                  - decimals are fractions
                                  - proper fractions e.g. `^<9 3/4>`
                                  - defaults to decimal results
                                  - fraction mode `f 1` for fraction results

                                END
                                code-note 'fractions are built-in';
                            ];
                            article [
                                asciinema '/static/demos/demo-Fractions.cast';
                            ];
                        ];

                    Complex => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Complex

                                  - `i` Imaginary
                                  - `3+4i` Complex
                                  - `.abs` absolute magnitude
                                  - `.polar` transformation

                                `i` represents the square root of `-1`.
                                END
                                code-note 'polar coordinate transformations';
                            ];
                            article [
                                asciinema '/static/demos/demo-Complex.cast';
                            ];
                        ];

                    Random => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Random

                                  - `rand` random (0 <= x < 1)
                                  - `10.rand` random in range (0 <= x < 10)
                                  - `(1..6).pick: 6` random select
                                  - `(1..6).roll: 6` random repeat

                                Use `.pick` one time, `.roll` like a dice.
                                END
                                code-note 'uses the MT19937 — Mersenne Twister algorithm';
                            ];
                            article [
                                asciinema '/static/demos/demo-Random.cast';
                            ];
                        ];

                    Memory => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Memory

                                Use `$` or `@` to denote a named variable.

                                  - `$x=42` set Scalar variable `$x`
                                  - `$x/7` recall variable `$x`
                                  - `$_` (dollar underscore) is the previous result
                                  - `@a` is an array variable (i.e. a list of items)
                                  - `@a[i]` to index an array
                                  - `<>` to quote a wordlist
                                END
                                code-note 'hashes (dictionaries) too e.g. %h{}';
                            ];
                            article [
                                asciinema '/static/demos/demo-Memory.cast';
                            ];
                        ];

                    Types => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Types

                                A comprehensive set of number types is included.

                                  - `42` Int (big integer)
                                  - `<2/3>` Rat (rational fraction)
                                  - `1.424e-2` Num (IEEE P754 float 64)
                                  - `3+4i` Complex
                                  - `Inf` infinity and `NaN` not a number
                                  - `<2/3> * <3/4>` exact fractions
                                  - `1.424e-2 * <270/7>` type mixing

                                Unlimited precision & range.
                                END
                                code-note 'calculate with googol range';
                            ];
                            article [
                                asciinema '/static/demos/demo-Types.cast';
                            ];
                        ];

                    Rounding => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Rounding

                                Rounding precision is controlled by the `r()` function.

                                  - `floor`, `ceiling` and `abs` functions
                                  - default rounding is `0.01` (2 digits)
                                  - `r 0.1` is 1 digit, `r 0.00001` is 5 digits
                                  - `r Nil` turns off rounding
                                  - mode controls  like r apply on subsequent lines

                                END
                                code-note 'full internal precision';
                            ];
                            article [
                                asciinema '/static/demos/demo-Rounding.cast';
                            ];
                        ];

                    Infinity => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Infinity

                                  - `Inf` for Infinity
                                  - e.g. on divide by zero operation
                                  - `1/Inf` -> `0`
                                  - `Inf+Inf` -> `Inf`
                                  - `NaN` for Not a Number
                                  - `Inf-Inf` -> `NaN`

                                END
                                code-note 'no more divide by zero errors';
                            ];
                            article [
                                asciinema '/static/demos/demo-Infinity.cast';
                            ];
                        ];
                ];
            ];

            div [
                p :style('margin-bottom: unset;'), b em 'the cool stuff: ';
                tabs [
                    LLM => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### LLM

                                Grab AI info directly into your calculations.

                                  - get text ... `?<query>`
                                  - get amount ... `?^<query in units>`

                                Use amounts in calculations, store them in memory.
                                END
                                code-note 'most popular LLM platforms';
                            ];
                            article [
                                asciinema '/static/demos/demo-LLM.cast';
                            ];
                        ];

                    SIUnits => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### SI Units

                                Just write SI units naturally:

                                  - `42m` metres, `10s` seconds and so on
                                  - `42cm` SI Prefixes `c`, `k`, etc too
                                  - `42m / 10s` speed in m/s (s=d/t)
                                  - `20kg * g` weight in N (F=ma)
                                  - `10N * 4m` energy in J (E=Fd)
                                END
                                code-note 'consistent dimensional analysis';
                            ];
                            article [
                                asciinema '/static/demos/demo-SIUnits.cast';
                            ];
                        ];

                    NonSI => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Non-SI Units

                                General syntax is `^<value units>`.

                                  - `^<4 m>` same as `4m`
                                  - `^<4 in>` 4 inches
                                  - plurals & synonyms
                                  - square and cubic
                                  - common word prefixes
                                  - `.rebase` convert to SI Base Unit
                                  - `.norm` scale to best SI Prefix

                                END
                                code-note 'auto detect US and Imperial locales';
                            ];
                            article [
                                asciinema '/static/demos/demo-NonSI.cast';
                            ];
                        ];

                    Time => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Time & Date

                                  - `42s` SI form
                                  - `^<23:59:59>` HH:MM:SS form
                                  - string to `.Date` and `.DateTime`
                                  - `sleep x` seconds
                                  - `say "\a"` alarm bell

                                END
                                code-note 'a calculator that sleeps';
                            ];
                            article [
                                asciinema '/static/demos/demo-Time.cast';
                            ];
                        ];

                    Data => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Data

                                  - shortform for bits `1b` and bytes `1B`
                                  - power of 2 data prefixes `kib, MiB, BiB`
                                  - datarate, e.g. `^<25 Mbps>`

                                END
                                code-note 'works well with LLM queries';
                            ];
                            article [
                                asciinema '/static/demos/demo-Data.cast';
                            ];
                        ];

                    Currency => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Currency

                                  - `US$25`, `C$20`, `£15`, `10€` currency

                                END
                                code-note '~20 popular currencies included';
                            ];
                            article [
                                asciinema '/static/demos/demo-Currency.cast';
                            ];
                        ];

                    Angles => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Angles

                                  - `30.2º` shortform for degrees
                                  - `2rad` radians too
                                  - `sin 30º` trigonometry
                                  - `^<30º10'5">` degrees, minutes, seconds
                                  - `cmp` for comparison

                                END
                                code-note 'degrees, radians, grads';
                            ];
                            article [
                                asciinema '/static/demos/demo-Angles.cast';
                            ];
                        ];

                    Conversions => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Conversions

                                Use the `in` operator to convert units.

                                  - `£20 in 'US$'` currency
                                  - `39ºC in 'ºF'` temperature
                                  - `10N in 'lb'` weight
                                  - `^<4 in> in 'm'` length

                                END
                                code-note 'items must have the same dimensions';
                            ];
                            article [
                                asciinema '/static/demos/demo-Conversions.cast';
                            ];
                        ];

                    Errors => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Measurement Uncertainty

                                  - use `~` (or `±`) to specify the error
                                  - works with short form `10m~10%`
                                  - and general form `^<5 m ~ 0.2>`
                                  - use `%` to denote relative error

                                END
                                code-note 'errors are propagated through calcs';
                            ];
                            article [
                                asciinema '/static/demos/demo-Errors.cast';
                            ];
                        ];


                    Constants => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Constants

                                  - `c` speed of light (m/s)
                                  - `g` acceleration due to gravity (m/s^2)
                                  - `Na` avogadro number (molecules in one mole)

                                END
                                code-note '~20 physical constants included';
                            ];
                            article [
                                asciinema '/static/demos/demo-Constants.cast';
                            ];
                        ];


                    Colors => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Colors

                                  - comprehensive name library
                                  - math operations
                                  - hsv, hex, cmyk conversion
                                  - `.lighten`, `.darken`, `.invert`, `.saturate`, `.rotate` adjustments

                                END
                                code-note 'X11, CSS3 and xkcd';
                            ];
                            article [
                                asciinema '/static/demos/demo-Colors.cast';
                            ];
                        ];

                    Sequences => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Sequences

                                  - `xx` denotes repetition
                                  - `..` specifies a range
                                  - `|` flattens it into a list
                                  - `^` is for "up to"
                                  - `[]` is for indexing (from 0)
                                  - `...` is a sequence - arithmetic & geometric
                                  - `(0,1,*+*...Inf)[^8]` fibonacci sequence (first 8)

                                Use the `*` _whatever_ to define the next-value operation.
                                END
                                code-note 'infinite lazy sequences';
                            ];
                            article [
                                asciinema '/static/demos/demo-Sequences.cast';
                            ];
                        ];

                    Bases => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Bases

                                  - `0b` binary
                                  - `0o` octal
                                  - `0x` hex
                                  - `0d` decimal
                                  - `0r` roman

                                Any base & mixed-base math supported too.
                                END
                                code-note 'power tools for coders';
                            ];
                            article [
                                asciinema '/static/demos/demo-Bases.cast';
                            ];
                        ];

                    Bitwise => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Bitwise Operations

                                  - `+&`, `+|`, `+^` bitwise AND, OR, XOR/NOT
                                  - `+<`, `+>` bitwise shift left, right

                                END
                                code-note '';
                            ];
                            article [
                                asciinema '/static/demos/demo-Bitwise.cast';
                            ];
                        ];

                    Unicode => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Unicode

                                  - `.ord` codepoint value
                                  - `.uniname` unicode name
                                  - `.uniprops` unicode properties

                                The unit syntax uses uniprop `Numeric_Value`
                                END
                                code-note 'strings use unicode graphemes';
                            ];
                            article [
                                asciinema '/static/demos/demo-Unicode.cast';
                            ];
                        ];

                    Theory => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### Number Theory

                                `abundant-number, are-coprime, chinese-remainder, continued-fraction, convergents, cousin-primes, deficient-number, digit-count, divisor-sigma, divisors, euler-phi, factor-gaussian-integer, factor-integer, factorial, fibonacci, from-continued-fraction, from-number-expansion, gcd-gaussian, gcd-rational, infix:<=>, integer-digits, integer-exponent, integer-partitions, is-abundant-number, is-composite, is-deficient-number, is-happy-number, is-harshad-number, is-perfect-number, is-prime, is-prime-gaussian, is-prime-power, is-quadratic-irrational, kronecker-delta, lcm-gaussian, lcm-rational, mangold-lambda, modular-inverse, multiplicative-order, next-prime, number-expansion, perfect-number, phi-number-system, polygonal-number, power-mod, prime, primitive-root-list, quotient, quotient-reminder, random-prime, real-digits, related-primes, sexy-primes, trial-factor-integer, twin-primes`
                                END
                                code-note 'modelled on Wolfram Language';
                            ];
                            article [
                                asciinema '/static/demos/demo-Theory.cast';
                            ];
                        ];
                ];
            ];

            markdown q:to/MDEND/;

                ## Get Started

                CragCLI is Open Source Software written in Raku, provided under Artistic License 2.0.

                ---

                ***PROVIDED "AS IS" WITHOUT WARRANTY OR LIABILITY***

                ***NOT INTENDED FOR USE IN MISSION CRITICAL APPLICATIONS***

                ---

                ### Step 1

                Install the Raku compiler:

                  - Linux => `curl https://rakubrew.org/install-on-perl.sh | sh`
                  - macOS => `curl https://rakubrew.org/install-on-macos.sh | sh`
                  - Windows => download [https://rakubrew.org/install-on-cmd.bat](https://rakubrew.org/install-on-cmd.bat) and then execute that script in a CMD terminal

                Then:

                  - `rakubrew download`
                  - `rakubrew switch`

                See [https://raku.org/install](https://raku.org/install) for other platforms and package managers

                ### Step 2

                Install and run App::Crag:

                  - `zef install App::Crag --/test`
                  - `crag '0.1+0.2'`  one-liner
                  - `crag` interactive REPL

                ---

                ## Get Help

                  - `crag --help`
                  - [Get More Examples](https://github.com/librasteve/raku-App-Crag/blob/main/crag-of-the-day.md)
                  - [Get In Touch](https://raku.org/community)

                ---

                ## Notes

                  1. Starts in approx. 1sec (as measured on an M1 MacBook, takes longer on first run).

                  2. For LLM::DWIM features, you will need e.g. a free of charge ChatGPT key and go `export OPENAI_API_KEY=mykeygoeshere`.

                  3. Currency exchange rates are provided as at the installation date, reinstall crag (`zef install App::Crag --/test --force-install`) to refresh them.

                  4. crag is a full Raku repl - so you can write subroutines, loops, conditionals, comparisons and so on (see [https://docs.raku.org](https://docs.raku.org))

                  5. If your calculations outgrow the crag app, you can use the underlying crag modules in Raku code.
                MDEND

            div [
                p :style('margin-bottom: unset;'), b em 'some stories: ';
                tabs [
                    Artemis-Launch => tab
                        vignette [
                            article [ markdown q:to/END/;
                                #### Artemis Launch Phase

                                  - Liftoff acceleration over one and a half gravity
                                  - Immense thrust lifting thousands of tons skyward
                                  - Rapid climb to orbital velocity in a few minutes

                                END
                                code-note 'using mass, force, speed, acceleration';
                            ];
                            article [
                                asciinema '/static/demos/demo-Artemis-Launch.cast';
                            ];
                        ];

                    Artemis-TransLunar => tab
                        vignette [
                            article [ markdown q:to/END/;
                                #### Artemis TransLunar Phase

                                  - Precise burn sends spacecraft toward the Moon
                                  - High efficiency engine maximizes velocity per fuel
                                  - Over half the mass consumed for the maneuver
                                  - Small velocity change demands enormous propellant

                                END
                                code-note 'via the Tsiolkovsky rocket equation';
                            ];
                            article [
                                asciinema '/static/demos/demo-Artemis-TransLunar.cast';
                            ];
                        ];

                    Artemis-Reentry => tab
                        vignette [
                            article [ markdown q:to/END/;
                                #### Artemis Reentry Phase

                                  - Gigantic energy dump during atmospheric reentry
                                  - Hundreds of tons TNT equivalent dissipated as heat

                                END
                                code-note 'simple kinetic energy math';
                            ];
                            article [
                                asciinema '/static/demos/demo-Artemis-Reentry.cast';
                            ];
                        ];

                    Artemis-Heatshield => tab
                        vignette [
                            article [ markdown q:to/END/;
                                #### Artemis Heatshield

                                  - Extreme heating concentrated on small shield area
                                  - Thermal protection absorbs megawatts of power
                                  - Intense thermal radiation from superheated heat shield
                                  - At ~2800°C, the capsule radiates ~5 MW per m²
                                  - Total radiated power ~100 MW
                                Still much less than total energy dissipation →
                                👉 most heating handled by ablation, not just radiation

                                END
                                code-note 'apply blackbody radiation (Stefan–Boltzmann) law';
                            ];
                            article [
                                asciinema '/static/demos/demo-Artemis-Heatshield.cast';
                            ];
                        ];
                    ];

                tabs [
                    Formula1-Kinematics => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Formula1 - Kinematics

                                A kinematic perspective.

                                 - You start already insanely fast (~260 km/h)
                                 - Still gain ~70 km/h in just ~5 seconds
                                 - Acceleration is “only” ~0.37g — because at those speeds, aerodynamic drag is brutal
                                 - Distance sanity check is ±30% - real-world is non-linear

                                END
                                code-note 'using distance, time and speed';
                            ];
                            article [
                                asciinema '/static/demos/demo-Formula1-Kinematic.cast';
                            ];
                        ];

                    Formula1-Drag => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Formula1 - Drag

                                Alternate view: force & mass.

                                  - Explosive acceleration — over 1.3g at entry speed
                                  - Drag surge — air resistance rises rapidly with speed
                                  - Fading acceleration — drops as drag grows
                                  - Power loss — engine fights air, not just acceleration

                                END
                                code-note 'using mass, force and accelaration';
                            ];
                            article [
                                asciinema '/static/demos/demo-Formula1-Drag.cast';
                            ];
                        ];

                    Formula1-Energy => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Formula1 - Energy

                                Energy and power take.

                                  - Explosive energy gain over a short straight
                                  - Massive power output sustained for seconds
                                  - Tiny fuel mass delivers huge energy increase
                                  - Relentless drag consumes most of the energy

                                END
                                code-note 'using mass, energy and power';
                            ];
                            article [
                                asciinema '/static/demos/demo-Formula1-Energy.cast';
                            ];
                        ];

                    Formula1-Formulae => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### Formula1 - Formulae

                                LLM Queries can be used to look up forgotten formulae.

                                Here are some from our story with a useful mantra.

                                END
                                code-note 'most popular LLM services supported';
                            ];
                            article [
                                asciinema '/static/demos/demo-Formula1-Formulae.cast';
                            ];
                        ];
                ];
            ];
        ];


