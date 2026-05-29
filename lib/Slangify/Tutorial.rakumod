unit class Slangify::Tutorial;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Rakudoc;

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

sub tutorial-page(&basepage, $shadow, $playground-url) is export {
    state @menu-items = @doc-items.map: -> ($slug, $label) {
        note "Loading tutorial: $slug";
        my $proc = run 'curl', '-s', "$raw-base/$slug.rakudoc", :out;
        my $pod  = $proc.out.slurp: :close;
        Pair.new($label, rakudoc $pod)
    };

    basepage :stub<tutorial>,
        main [
            $shadow;
            leftmenu @menu-items;
        ];
}
