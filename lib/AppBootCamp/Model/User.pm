package AppBootCamp::Model::User;

use strict;
use warnings;

sub new{
  my ($class,%obj)=@_;
  bless{'db'=>$obj{'c'}->db},$class;
}
sub get_user_by_screen_name {
  my ($self, $screen_name) = @_;
  return $self->{'db'}->single('user', {'screen_name' => $screen_name});
}

sub regist_user{
  my ($self, $sn,$n,$p) = @_;
  return $self->{db}->fast_insert(user=>{screen_name=>$sn,name=>$n,password=>$p});
}
1;

