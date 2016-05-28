package AppBootCamp::Model::Message;

use strict;
use warnings;

sub new{
  my ($class,%obj)=@_;
  bless{'db'=>$obj{'c'}->db},$class;
}

sub get_all_message{
  my $self = shift;
  return $self->{db}->search_by_sql(q{select message.id, message.user_id, message.text, message.mention, message.image, message.deleted, message.created_at, message.updated_at, user.screen_name, user.name, user.image as uimage from message inner join user on message.user_id = user.id order by created_at DESC});
  #return $self->{'db'}->search('message',{},{order_by => 'created_at DESC'});
}

sub get_message_by_user_id{
  my ($self,$user_id) = @_;
  return $self->{db}->search_by_sql(q{select message.id, message.user_id, message.text, message.mention, message.image, message.deleted, message.created_at, message.updated_at, user.screen_name, user.name, user.image as uimage from message inner join user on message.user_id = user.id where user.id = ? order by created_at DESC},[$user_id]);
#  return $self->{'db'}->search('message',{user_id => $user_id},{order_by => 'created_at DESC'});
}

sub post_new_message{
  my ($self,$us_is,$txt,$mt,$im,$dl) = @_;
  return $self->{'db'}->insert(message=>{
      user_id =>  $us_is,
      text    =>  $txt,
      mention =>  $mt,
      image   =>  $im,
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

