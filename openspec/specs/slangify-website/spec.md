## Purpose

Define the structure, content, and behavior of the slangify.org marketing and demo website.

## Requirements

### Requirement: Page shell

The site SHALL be constructed using `site` (Air::Base) with:
- `@tools` containing an `Analytics` instance using the Umami provider
- `:register` listing `LightDark.new` and `Air::Plugin::Hilite.new`
- `:theme-color<blue>`

The single page SHALL be constructed via `page.assuming(...)` with:
- `title => 'Slangify'`
- `description => 'slangify.org'`
- `favicon => '/img/favicon.ico'`

#### Scenario: Page renders with correct title and favicon

- **WHEN** the page is served
- **THEN** the HTML `<title>` is `Slangify`
- **AND** the favicon link points to `/img/favicon.ico`

### Requirement: Navigation bar

The nav bar SHALL be constructed using `nav` (Air::Base) with:
- `logo` — a `span` wrapping an `a` (`:href<https://slangify.org>`, `:target<_self>`) containing an `img` (`:src</img/logo.svg>`, `:height<40px>`, `:alt<Slangify>`)
- `items` — `[external(:href<https://play.slangify.org>)]` labelled "Playground"
- `widgets` — `[lightdark]` (Air::Base LightDark widget)

#### Scenario: Nav renders logo and playground link

- **WHEN** the page loads
- **THEN** the nav shows the Slangify logo SVG
- **AND** a "Playground" link pointing to `https://play.slangify.org` is present
- **AND** a light/dark mode toggle widget is present

### Requirement: Footer

The footer SHALL be constructed using `footer` (Air::Base) containing a `p safe Q|...|` with:
- htmx credit linking to `https://htmx.org` (target `_blank`)
- Åir credit linking to `https://github.com/librasteve/Air` (target `_blank`)
- Cro credit linking to `https://cro.raku.org` (target `_blank`)
- picocss credit linking to `https://picocss.com` (target `_blank`)

#### Scenario: Footer renders all credits

- **WHEN** the page loads
- **THEN** the footer contains links to htmx, Åir, cro, and picocss

### Requirement: Main content layout

The `main` area SHALL contain a `div :align<center>` wrapping:
- `h1 'Slangify'`
- `h3 'Compare Python and Raku Invoice DSL code'`
- A `p` inviting the user to open the Raku example in the playground, using an `a` link to the invoice DSL snapshot at `https://play.slangify.org/<sha1-id>`
- A `grid :cols(2) :gap(6)` containing the two code comparison blocks

#### Scenario: Heading and intro text are rendered

- **WHEN** the page loads
- **THEN** the page shows "Slangify" as an `h1`
- **AND** "Compare Python and Raku Invoice DSL code" as an `h3`
- **AND** a paragraph with a link to open the Raku example in the playground

### Requirement: Code comparison grid

The grid SHALL contain two columns:
1. **Left column** — Python code rendered via `hilite :lang('python')` containing the full Lark-grammar Invoice DSL parser (~130 loc)
2. **Right column** — Raku code rendered via `hilite` (default Raku highlighting) containing the Grammar, Actions, classes, and render sub (~80 loc)

Both blocks SHALL use `q:to/HILITE/ ... HILITE` heredoc strings.

#### Scenario: Python column renders with syntax highlighting

- **WHEN** the page loads
- **THEN** the left column shows the Python Lark parser code
- **AND** highlight.js syntax highlighting is applied with the `python` language

#### Scenario: Raku column renders with rainbow syntax highlighting

- **WHEN** the page loads
- **THEN** the right column shows the Raku Grammar+Actions code
- **AND** Air::Plugin::Hilite applies Raku rainbow syntax highlighting (rainbow-* CSS classes)

#### Scenario: Grid is two columns side by side

- **WHEN** the page loads on a wide screen
- **THEN** the Python and Raku code blocks are displayed side by side in a two-column grid

### Requirement: Light/dark mode

The site SHALL support light and dark mode switching via the `LightDark` plugin registered with `site`. The nav widget `lightdark` provides the toggle.

#### Scenario: Light/dark toggle changes color scheme

- **WHEN** the user clicks the light/dark toggle
- **THEN** the page color scheme switches between light and dark modes

### Requirement: Analytics

The site SHALL include the Umami analytics snippet via `Analytics.new :provider(Umami) :key<4464d54a-3dbe-4f79-8d45-1ef4f22cd677>` in the `@tools` list.

#### Scenario: Analytics script is included

- **WHEN** the page HTML is rendered
- **THEN** the Umami analytics script tag is present in the document
