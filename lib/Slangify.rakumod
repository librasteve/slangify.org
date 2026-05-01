unit module Slangify;

use Air::Functional :BASE;
use Air::Base;

my &index = &page.assuming(
    title       => 'Slangify',
    description => 'slangify.org',

    nav => nav(
        logo    => span( a( :href<https://slangify.org>, :target<_self>, p "Slangify" ) ),
        items   => [],
        widgets => [lightdark],
    ),

    footer => footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
    |),
);

my @tools = [Analytics.new: :provider(Umami), :key<4464d54a-3dbe-4f79-8d45-1ef4f22cd677>,];

our $site =
site :@tools, :register[LightDark.new], :theme-color<blue>,
    index
        main [
            div :align<center>, [
                h1 b 'Slangify';
                h3 'Coming soon.';
            ]
        ];
