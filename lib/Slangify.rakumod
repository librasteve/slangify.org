unit class Slangify;

use Air::Functional :BASE;
use Air::Base;

use Slangify::Home;
use Slangify::Why;
use Slangify::Where;
use Slangify::How;
use Slangify::Ecosystem;
use Slangify::Examples;
use Slangify::Comparison;
use Slangify::Tutorial;
use Slangify::HTML404;

constant $playground-url = 'https://play.slangify.org/6dfde50adbfd8ca6d6396a88c8603e7b9d21c7e0';

my &basepage = &page.assuming(
    title       => 'Slangify',
    description => 'Power up your Domain Specific Language. Build, parse and embed DSLs using Raku Grammars.',
    favicon     => '/img/favicon.ico',

    footer => footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
        <br>
        Raku&reg; is a trademark of The Raku Foundation.
        <br>
        &copy; Stephen Roe 2026.
    |),
);

my @tools = [Analytics.new: :provider(Umami), :key<4464d54a-3dbe-4f79-8d45-1ef4f22cd677>,];

#| https://www.supercoloring.com/nl/media/coloring/2098734/vintage-zwarte-slang
#| Gebruiksrechten: Gratis voor persoonlijk, educatief en commercieel gebruik. Dit werk bevindt zich in Publiek domein.
#| Naamsvermelding is niet verplicht, maar welkom.
my $shadow = background(
    :src</img/vintage-black-snake-coloring-page-md.png>,
    :top<600px>, :left<50%>, :width<1000px>, :height<544px>, :size<contain>,
    :opacity(0.05), :filter('invert(1) blur(1.5px)'), :translate('-50%, -50%'), :rotate(-90),
);

my Page $home       = home-page       &basepage, $shadow, $playground-url;
my Page $why        = why-page        &basepage, $shadow, $playground-url;
my Page $where      = where-page      &basepage, $shadow, $playground-url;
my Page $how        = how-page        &basepage, $shadow, $playground-url;
my Page $ecosystem  = ecosystem-page  &basepage, $shadow, $playground-url;
my Page $examples   = examples-page   &basepage, $shadow, $playground-url;
my Page $comparison = comparison-page &basepage, $shadow, $playground-url;
my Page $tutorial   = tutorial-page   &basepage, $shadow, $playground-url;
my Page $html404    = html404-page    &basepage, $shadow;

my Page @pages = [$home, $why, $where, $how, $ecosystem, $examples, $comparison, $tutorial];

my $playground = external :href($playground-url);
my $docs       = external :href<https://docs.raku.org/language/grammars>;

my Nav $nav =
    nav(
        logo    => span( a( :href<https://slangify.org>, :target<_self>, img( :src</img/logo.svg>, :height<40px>, :alt<Slangify> ) ) ),
        items   => [:$why, :$where, :$how, :$ecosystem, :$examples, :$tutorial, :$docs, :$playground],
    );

{ .nav = $nav } for @pages;

our $site =
    site :@tools, :register[Air::Plugin::Hilite.new, LeftMenu.new], :theme-color<blue>, :bold-color<#3d6b52>, :@pages, :$html404;
