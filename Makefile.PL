use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'tiny',
    AUTHOR              => 'Cosimo Streppone <cosimo@cpan.org>',
    VERSION_FROM        => 'lib/tiny.pm',
    ABSTRACT_FROM       => 'lib/tiny.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'tiny-*' },
);
