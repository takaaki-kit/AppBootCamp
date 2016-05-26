use strict;
use warnings;

use t::Util;
use AppBootCamp;
use Test::More;

subtest 'User Model' => sub{
  my $user = AppBootCamp->bootstrap()->model('User');
  $user->{db}->delete('user');

  subtest 'method:regist_user' => sub{
    subtest 'regist new user' => sub{
      my $expect = $user->regist_user('testuser1','username','pass');
      is($expect->screen_name,'testuser1');
    };
  };

  subtest 'get_user_by_screen_name' => sub{
    subtest 'exist target user' => sub{
      my $expect = $user->get_user_by_screen_name('testuser1');
      is($expect->screen_name,'testuser1');
    };

    subtest 'not exist target user' => sub{
      my $expect = $user->get_user_by_screen_name('no_screen_name');
      is($expect,undef);
    };
  };

  subtest 'get_user_by_screen_name_and_password' => sub{
    subtest 'exist target user' => sub{
      my $expect = $user->get_user_by_screen_name_and_password('testuser1','pass');
      isnt($expect,undef);
    };
  };
};

done_testing;
