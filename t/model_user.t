use strict;
use warnings;

use t::Util;
use AppBootCamp;
use AppBootCamp::Repository::User;
use Test::More;

subtest 'User Model' => sub{
  subtest 'get_user_by_screen_name' => sub{
    subtest 'exist target user' => sub{
      my $user = AppBootCamp->bootstrap()->model('User');
      my $expect = $user->get_user_by_screen_name('testuser1');
      isnt($expect,undef);
    };

    subtest 'not exist target user' => sub{
      my $user = AppBootCamp->bootstrap()->model('User');
      my $expect = $user->get_user_by_screen_name('no_screen_name');
      is($expect,undef);

    }
  };

  subtest 'regist new user' => sub{
    my $user = AppBootCamp->bootstrap()->model('User');

    my $expect = $user->regist_user('userid','username','pass');
    isnt($expect,undef);

  }

};

done_testing;
