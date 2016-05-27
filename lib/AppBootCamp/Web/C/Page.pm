package AppBootCamp::Web::C::Page;
use strict;
use warnings;
use utf8;
use AppBootCamp::Repository::User;
use AppBootCamp::Repository::Message;
use DDP;

use Plack::Session;

my $dir = 'static/upload';

sub get_signup {
  my ($class,$c,$args) = @_;

  return $c->render('signup.tx', {
    });
};

sub post_signup{
  my $class = shift;
  my $c = shift;

  my $user = $c->model('User');

  my $screen_name = $c->req->parameters->{screen_name};

  if(AppBootCamp::Repository::User->isAlreadyRegisted($user,$screen_name)){
    return $c->render('signup.tx', {
        error_code  => "this ID is already used"
      });
  }
  $c->session->set('screen_name',$screen_name);

  $user->regist_user($screen_name,$c->req->parameters->{name},$c->req->parameters->{password});
  return $c->redirect("/$screen_name");
};

sub get_timeline{
  my ($class,$c,$args) = @_;
  unless(AppBootCamp::Repository::User->isLogined($c->session->get('screen_name'))){return $c->redirect('/login');}
  my $message = $c->model('Message');
  my $user = $c->model('User');
  my $login_user = $user->get_user_by_screen_name($c->session->get('screen_name'));
  my @messages = $message->get_message_by_user_id($login_user->id);

  return $c->render('timeline.tx',{
      screen_name =>  $login_user->screen_name,
      name  => $login_user->name,
      profile => $login_user->text,
      user_image  => $login_user->image,
      login_id  => $login_user->id,
      messages =>  \@messages
  });
};

sub post_message_new{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');
  my $user = $c->model('User');
  my $login_user = $user->get_user_by_screen_name($c->session->get('screen_name'));

  my $path = AppBootCamp::Repository::Message->post_picture($c->req->uploads->{image},$c->base_dir());

  $message->post_new_message($login_user->id,$c->req->parameters->{post_text},0,$path,0);
  my $sn = $login_user->screen_name;
  p $c->req->headers->referer;
  return $c->redirect("/$sn");

}

sub post_edit{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');
  my $user = $c->model('User');
  my $login_user = $user->get_user_by_screen_name($c->session->get('screen_name'));

  $message->update_message($c->req->parameters->{edit_text_name},$c->req->parameters->{edit_id_name});
  my $sn = $login_user->screen_name;
  return $c->redirect("/$sn");
}

sub post_delete{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');
  my $user = $c->model('User');
  my $login_user = $user->get_user_by_screen_name($c->session->get('screen_name'));

  $message->delete_message($c->req->parameters->{delete_id_name});
  my $sn = $login_user->screen_name;
  return $c->redirect("/$sn");
}

sub get_login {
  my ($class,$c,$args) = @_;

  return $c->render('login.tx', {
    });
};

sub post_login{
  my $class = shift;
  my $c = shift;

  my $user = $c->model('User');
  my $screen_name = $c->req->parameters->{screen_name};

  unless(AppBootCamp::Repository::User->isScreenNamePassMatched($user,$screen_name,$c->req->parameters->{password})){
    return $c->render('login.tx', {
        error_code  => "ID or Password is not correct"
      });
  };
  $c->session->set('screen_name',$screen_name);

  return $c->redirect("/$screen_name");
};

sub get_discover{
  my($class,$c,$args) = @_;
  unless(AppBootCamp::Repository::User->isLogined($c->session->get('screen_name'))){return $c->redirect('/login');}
  my $message = $c->model('Message');
  my $user = $c->model('User');
  my $login_user = $user->get_user_by_screen_name($c->session->get('screen_name'));
  my @messages = $message->get_all_message();


  return $c->render('timeline.tx',{
      screen_name =>  $login_user->screen_name,
      name  => $login_user->name,
      profile => $login_user->text,
      user_image  => $login_user->image,
      login_id  => $login_user->id,
      messages =>  \@messages
  });
};

sub get_logout{
  my($class,$c,$args) = @_;
  $c->session->expire;

  $c->redirect("/login");
};

sub get_profile{
  my($class,$c,$args) = @_;
  return $c->render('profile.tx',{
    });

};

sub post_profile{
  my($class,$c,$args) = @_;
  my $user = $c->model('User');
  my $login_user = $user->get_user_by_screen_name($c->session->get('screen_name'));

  my $sn = $login_user->screen_name;
  my $path = AppBootCamp::Repository::Message->post_picture($c->req->uploads->{image},$c->base_dir());
  $user->update_user($sn,$c->req->parameters->{name},$c->req->parameters->{text},$path);
  p $sn;
  return $c->redirect("/$sn");
};


1;
