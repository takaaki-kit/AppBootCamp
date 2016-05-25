use strict;
use warnings;

use t::Util;
use AppBootCamp;
use Test::More;

subtest 'Message Model' => sub{
  my $message = AppBootCamp->bootstrap()->model('Message');
  
  subtest 'get_all_message' => sub{
    my $expect = $message->get_all_message();
    isnt($expect,undef);
  };

  subtest 'post new message' => sub{
    my $expect = $message->post_new_message(1,"new post message",0);
    isnt($expect,undef);
  }


};

done_testing;

