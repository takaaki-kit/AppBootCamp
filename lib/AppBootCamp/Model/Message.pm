package AppBootCamp::Model::Message;

use strict;
use warnings;

sub new{
  my ($class,%obj)=@_;
  bless{'db'=>$obj{'c'}->db},$class;
}

sub get_all_message{
  my $self = shift;
  return $self->{'db'}->search('message',{},{order_by => 'created_at DESC'});
}

sub post_new_message{
  my ($self,$us_is,$txt,$dl) = @_;
  return $self->{'db'}->insert(message=>{
      user_id =>  $us_is,
      text    =>  $txt,
      deleted => $dl
    });
}

sub update_message{
  my($self,$new_text,$id) = @_;
  return $self->{db}->update('message',{text=>$new_text},{id=>$id});
}

sub delete_message{
  my ($self,$delete_id)= @_;
  return $self->{db}->delete('message',{id=>$delete_id});
}
1;

