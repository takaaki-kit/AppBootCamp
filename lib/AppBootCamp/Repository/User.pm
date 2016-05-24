package AppBootCamp::Repository::User;
use strict;
use warnings;

use AppBootCamp;
use AppBootCamp::Web::Dispatcher;
use Amon2::Web::Dispatcher::RouterBoom;

sub db{AppBootCamp->context->db}

sub isAlreadyRegisted{
  my($c,$screen_name) = @_;
  return 1 if($c->db->single('user',{screen_name => $screen_name},{}));
  return 0;
}

1;
