unit class Slangify::Tutorial;

use Air::Functional :BASE;
use Air::Base;

constant $tutorial-base = 'https://librasteve.github.io/Slangify-Tutorial/docs';
constant $cache-dir     = '.cache/tutorial';

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
    ('actions',       'Actions'   ),
    ('grammar',       'Grammar'   ),
);

sub extract-content(Str $html --> Str) {
    my $nav-marker = "← Index</a></p>";
    my $i = $html.index($nav-marker);
    return '<p>Content unavailable</p>' without $i;
    my $content = $html.substr($i + $nav-marker.chars);
    my $end = $content.rindex('</div>');
    $content = $content.substr(0, $end) if $end >= 0;
    $content.trim
}

sub populate-cache() {
    run 'rm', '-rf', $cache-dir;
    run 'mkdir', '-p', $cache-dir;
    for @doc-items -> ($slug, $) {
        note "Fetching tutorial: $slug";
        my $proc = run 'curl', '-s', "$tutorial-base/$slug.html", :out;
        my $html = $proc.out.slurp: :close;
        "$cache-dir/$slug.html".IO.spurt: extract-content($html);
    }
}

my @menu-items;
my $loaded = 0;

unless $loaded++ {
    populate-cache();
    @menu-items = @doc-items.map: -> ($slug, $label) {
        my $html = "$cache-dir/$slug.html".IO.slurp;
        Pair.new($label, content safe $html)
    };
}

sub tutorial-page(&basepage, $shadow, $playground-url) is export {
    basepage :stub<tutorial>,
        main [
            $shadow;
            leftmenu @menu-items;
        ];
}
