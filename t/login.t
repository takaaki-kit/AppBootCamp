use strict;
use warnings;

use Test::More;
use t::Util;
use AppBootCamp;
use AppBootCamp::Repository::User;



subtest 'DB' => sub{
  my $app=AppBootCamp->bootstrap();
  my $user = $app->model('User');

  subtest 'method:isAlreadyRegist' => sub{
    my $expect=AppBootCamp::Repository::User->isAlreadyRegisted($user,"testuser1");
    is($expect,1);
  };

  subtest 'method:isScreenNamePassMatched' => sub{
    my $expect = AppBootCamp::Repository::User->isScreenNamePassMatched($user,'testuser1','pass');
    is($expect,1);
  };
};

done_testing;
