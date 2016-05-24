package AppBootCamp::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use DDP;
use CGI;
use Amon2::Web::Dispatcher::RouterBoom;
use AppBootCamp::Repository::User;

get '/signup' => sub {
  my ($c,$args) = @_;

  return $c->render('signup.tx', {
    });
};

post '/signup' =>sub{
  my $c = shift;
  my $str="not regist";
  my $str2="regist";

  my $user = $c->model('User');

  if(AppBootCamp::Repository::User->isAlreadyRegisted($user,$c->req->parameters->{screen_name})){
    return $c->render('signup.tx', {
        error_signup_screen_name  => "this screen_name is already used."
      });
  }

  $user->regist_user($c->req->parameters->{screen_name},$c->req->parameters->{name},$c->req->parameters->{password});

  return $c->redirect('/timeline');
};

get '/timeline'=>sub{
  my ($c,$args) = @_;
  return $c->render('timeline.tx',{
    });
};

1;
