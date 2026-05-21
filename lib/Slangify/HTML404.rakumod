unit class HTML404;

use Air::Functional :BASE;
use Air::Base;

sub html404-page(&basepage, $shadow) is export {
basepage
    main [
        $shadow;
        div :align<center>, [
            h1 safe '404 Error';
            h2 safe 'Oops - this page does not exist.';
        ];
    ];
}
