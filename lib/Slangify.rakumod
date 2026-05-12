unit class Slangify;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

use Slangify::Home;
use Slangify::Why;

my &basepage = &page.assuming(
    title       => 'Slangify',
    description => 'slangify.org',
    favicon     => '/img/favicon.ico',

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

my Page $home = home-page &basepage;
my Page $why  = why-page  &basepage;

my Page @pages = [$home, $why];

my $Playground = external :href<https://play.slangify.org/9966a43929a059bd1087a607a11e58f072b6d1a4>;

my Nav $nav =
    nav(
        logo    => span( a( :href<https://slangify.org>, :target<_self>, img( :src</img/logo.svg>, :height<40px>, :alt<Slangify> ) ) ),
        items   => [:$why, :$Playground],
        widgets => [lightdark],
    );

{ .nav = $nav } for @pages;

our $site =
    site :@tools, :register[LightDark.new, Air::Plugin::Hilite.new], :theme-color<blue>,
        :@pages,
    ;
