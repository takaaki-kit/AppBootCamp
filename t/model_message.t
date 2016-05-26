use strict;
use warnings;

use t::Util;
use AppBootCamp;
use Test::More;

subtest 'Message Model' => sub{
  my $message = AppBootCamp->bootstrap()->model('Message');
  $message->{db}->delete('message');
  $message->{db}->do("ALTER TABLE message AUTO_INCREMENT = 1");

  subtest 'post_new_message' => sub{
    subtest 'regist new message1' => sub{
      my $expect = $message->post_new_message(1,"new post message",0,"NULL",0);
      is($expect->text,"new post message");
    };
    subtest 'regist new message2' => sub{
      my $expect = $message->post_new_message(1,"add new",0,"NULL",0);
      is($expect->text,"add new");
    };
    subtest 'regist new message3' => sub{
      my $expect = $message->post_new_message(2,"add new",0,"NULL",0);
      is($expect->text,"add new");
    };
  };

  subtest 'get_all_message' => sub{
    subtest 'check the number of posts is 2' => sub{
      my $array = $message->get_all_message();
      my @array = @{$array->all};
      my $expect = @array;
      is($expect,3);
    };
  };

  subtest 'get_message_by_user_id' => sub{
    subtest 'get message which user id is 1' => sub{
      my $array = $message->get_message_by_user_id(1);
      my @array = @{$array->all};
      my $expect = @array;
      is($expect,2);
    };
  };

  subtest 'update_message' => sub{
    subtest 'update message text whose id is 2' => sub{
      $message->update_message('update teeeeeeeeeext',2);
      my $expect = $message->{db}->single('message',{id=>2});
      is($expect->text,'update teeeeeeeeeext');
    };
  };

  subtest 'delete_message' => sub{
    subtest 'delete message whose id is 1' => sub{
      my $expect = $message->delete_message(1);
      is($expect,1);
    };
  };


};

done_testing;

