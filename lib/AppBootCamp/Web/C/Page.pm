package AppBootCamp::Web::C::Page;
use strict;
use warnings;
use utf8;
use AppBootCamp::Repository::User;
use DDP;

sub get_signup {
  my ($class,$c,$args) = @_;

  return $c->render('signup.tx', {
    });
};

sub post_signup{
  my $class = shift;
  my $c = shift;

  my $user = $c->model('User');

  if(AppBootCamp::Repository::User->isAlreadyRegisted($user,$c->req->parameters->{screen_name})){
    return $c->render('signup.tx', {
        error_signup_screen_name  => "this screen_name is already used."
      });
  }

  $user->regist_user($c->req->parameters->{screen_name},$c->req->parameters->{name},$c->req->parameters->{password});

  return $c->redirect('/timeline');
};

sub get_timeline{
  my ($class,$c,$args) = @_;

  my $message = $c->model('Message');
  my @messages = $message->get_all_message();

  return $c->render('timeline.tx',{
      messages =>  \@messages
    });
};

sub post_message_new{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');

  $message->post_new_message(1,$c->req->parameters->{post_text},0);

  return $c->redirect('/timeline');

}

sub post_edit{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');

  p $c->req->parameters->{edit_text_name};
  p $c->req->parameters->{edit_id_name};
  $message->update_message($c->req->parameters->{edit_text_name},$c->req->parameters->{edit_id_name});
  return $c->redirect('/timeline');

}

1;
