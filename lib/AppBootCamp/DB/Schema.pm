package AppBootCamp::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'AppBootCamp::DB::Row';

table {
    name 'user';
    pk 'id';
    columns qw(id screen_name name password);
};

1;
