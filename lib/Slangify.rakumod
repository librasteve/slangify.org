unit class Slangify;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

use Slangify::Home;
use Slangify::Why;
use Slangify::Python;

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

#| https://garystockbridge617.getarchive.net/amp/media/caterpillar-worm-psf-f0a4ab
#| Public domain scan of drawing of insect, zoological illustration, free to use, no copyright restrictions image - Picryl description

my $shadow = background(
    :src</img/caterpillar-worm-psf-f0a4ab-small.png>,
    :top<160px>, :left<20vw>, :width<60vw>, :height<100vh>, :size<auto>,
    :opacity(0.05), :filter('invert(1) blur(1.5px)'),
);

my Page $home   = home-page    &basepage, $shadow;
my Page $why    = why-page     &basepage, $shadow;
my Page $python = python-page  &basepage, $shadow;

my Page @pages = [$home, $why, $python];

my $playground = external :href<https://play.slangify.org/7303f34380d1dae55188eafa3ca54f4677271dc2>;

my Nav $nav =
    nav(
        logo    => span( a( :href<https://slangify.org>, :target<_self>, img( :src</img/logo.svg>, :height<40px>, :alt<Slangify> ) ) ),
        items   => [:$python, :$why, :$playground],
#        widgets => [lightdark],
    );

{ .nav = $nav } for @pages;

our $site =
    site :@tools, :register[Air::Plugin::Hilite.new], :theme-color<blue>, :bold-color<#3d6b52>, :@pages;
