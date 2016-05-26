package AppBootCamp::Repository::User;
use strict;
use warnings;

use AppBootCamp;
use AppBootCamp::Web::Dispatcher;
use Amon2::Web::Dispatcher::RouterBoom;

use DDP;


sub isAlreadyRegisted{
  my($c,$model,$screen_name) = @_;
  return 1 if($model->get_user_by_screen_name($screen_name));
  return 0;
}

sub isScreenNamePassMatched{
  my($c,$model,$screen_name,$password) = @_;
  return 1 if($model->get_user_by_screen_name_and_password($screen_name,$password)); 
  return 0;
}

1;
