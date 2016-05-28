use strict;
use warnings;

use Test::More;
use t::Util;
use AppBootCamp;
use AppBootCamp::Repository::User;



subtest 'DB' => sub{
  my $app=AppBootCamp->bootstrap();
  my $user = $app->model('User');
  my $expect=AppBootCamp::Repository::User->isAlreadyRegisted($user,"testuser1");
  is($expect,1);
};

done_testing;
