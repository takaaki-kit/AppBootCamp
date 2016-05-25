use strict;
use warnings;

use t::Util;
use AppBootCamp;
use Test::More;

subtest 'Message Model' => sub{
  my $message = AppBootCamp->bootstrap()->model('Message');
  $message->{db}->delete('message');

  subtest 'post_new_message' => sub{
    subtest 'regist new message1' => sub{
      my $expect = $message->post_new_message(1,"new post message",0);
      is($expect->text,"new post message");
    };
    subtest 'regist new message2' => sub{
      my $expect = $message->post_new_message(1,"add new",0);
      is($expect->text,"add new");
    };
  };

  subtest 'get_all_message' => sub{
    subtest 'check the number of posts is 2' => sub{
      my $array = $message->get_all_message();
      my @array = @{$array->all};
      my $expect = @array;
      is($expect,2);
    };
  };



};

done_testing;

