package AppBootCamp::DB::Schema;
use strict;
use warnings;
use utf8;

use Time::Moment;
use Time::TZOffset qw/tzoffset_as_seconds/;

use Teng::Schema::Declare;

base_row_class 'AppBootCamp::DB::Row';

table {
  name 'user';
  pk 'id';
  columns qw(id screen_name name password created_at updated_at);

  inflate 'created_at' => \&inflate_moment_from_mysql_datetime_str;
  deflate 'created_at' => \&deflate_moment_to_mysql_datetime_str;

  inflate 'updated_at' => \&inflate_moment_from_mysql_datetime_str;
  deflate 'updated_at' => \&deflate_moment_to_mysql_datetime_str;
};

table {
  name 'message';
  pk 'id';
  columns qw(id user_id text mention deleted created_at updated_at);

  inflate 'created_at' => \&inflate_moment_from_mysql_datetime_str;
  deflate 'created_at' => \&deflate_moment_to_mysql_datetime_str;

  inflate 'updated_at' => \&inflate_moment_from_mysql_datetime_str;
  deflate 'updated_at' => \&deflate_moment_to_mysql_datetime_str;
};

sub inflate_moment_from_mysql_datetime_str {
  my $mysql_datetime_str = shift;
  my $t      = Time::Moment->from_string($mysql_datetime_str.'Z', lenient => 1);
  my $offset = tzoffset_as_seconds($t->second, $t->minute, $t->hour, $t->day_of_month, $t->month - 1, $t->year);
  return $t->with_offset_same_local($offset / 60);
}

sub deflate_moment_to_mysql_datetime_str {
  my $moment = shift;
  return $moment->strftime('%Y-%m-%d %H:%M:%S');
}

1;
