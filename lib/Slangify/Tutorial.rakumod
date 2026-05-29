unit class Slangify::Tutorial;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

constant $raw-base = 'https://raw.githubusercontent.com/librasteve/Slangify-Tutorial/main/rakudoc';

my @doc-items = (
    ('00-intro',      'Intro'     ),
    ('01-setup',      'Setup'     ),
    ('02-schema',     'Schema'    ),
    ('03-llm',        'LLM'       ),
    ('04-output',     'Output'    ),
    ('05-iteration',  'Iteration' ),
    ('06-validation', 'Validation'),
    ('07-patterns',   'Patterns'  ),
    ('08-prompts',    'Prompts'   ),
    ('09-real-world', 'RealWorld' ),
    ('10-pitfalls',   'Pitfalls'  ),
    ('11-next-steps', 'NextSteps' ),
);

sub inline-to-md(Str $text --> Str) {
    my $r = $text;
    $r = $r.subst(/ 'B<' (<-[>]>+) '>' /, { "**$0**" }, :g);
    $r = $r.subst(/ 'C<' (<-[>]>+) '>' /, { "`$0`" }, :g);
    $r = $r.subst(/ 'L<' (<-[|>]>+) '|' (<-[>]>+) '>' /, { "[$0]($1)" }, :g);
    $r = $r.subst(/ 'L<' (<-[>]>+) '>' /, { "[$0]($0)" }, :g);
    $r
}

sub pod-to-content(Str $pod --> Content) {
    my @parts;
    my @buf;
    my ($block-type, $block-lang) = '', '';
    my $in-block = False;

    sub flush-text {
        return unless @buf.join('').trim;
        @parts.push: markdown @buf.join("\n");
        @buf = ();
    }

    for $pod.lines.grep({ $_ ne '=begin pod' && $_ ne '=end pod' }) -> $line {
        if !$in-block && $line ~~ /^ '=begin ' (\w+) [\s+ (.+)]? $/ {
            flush-text();
            $block-type = ~$0;
            my $attrs = ~($1 // '');
            $block-lang = ($attrs ~~ / ':lang<' (\w+) '>' /) ?? ~$0 !! '';
            $in-block = True;
        }
        elsif $in-block && $line eq "=end $block-type" {
            my $code = @buf.join("\n");
            @buf = ();
            $in-block = False;
            @parts.push: $block-lang eq 'raku'
                ?? hilite $code
                !! pre code $code
            if $block-type eq 'code';
            $block-type = '';
            $block-lang = '';
        }
        elsif $in-block {
            @buf.push: $line;
        }
        else {
            given $line {
                when /^ '=head1 ' (.+) $/ { flush-text(); @parts.push: h1 inline-to-md(~$0) }
                when /^ '=head2 ' (.+) $/ { flush-text(); @parts.push: h2 inline-to-md(~$0) }
                when /^ '=head3 ' (.+) $/ { flush-text(); @parts.push: h3 inline-to-md(~$0) }
                when /^ '=item '  (.+) $/ { @buf.push: "* " ~ inline-to-md(~$0) }
                default                   { @buf.push: inline-to-md($line) }
            }
        }
    }
    flush-text();

    content [|@parts]
}

my @menu-items;
my $loaded = 0;

unless $loaded++ {
    @menu-items = @doc-items.map: -> ($slug, $label) {
        note "Loading tutorial: $slug";
        my $proc = run 'curl', '-s', "$raw-base/$slug.rakudoc", :out;
        my $pod  = $proc.out.slurp: :close;
        Pair.new($label, pod-to-content($pod))
    };
}

sub tutorial-page(&basepage, $shadow, $playground-url) is export {
    basepage :stub<tutorial>,
        main [
            $shadow;
            leftmenu @menu-items;
        ];
}
