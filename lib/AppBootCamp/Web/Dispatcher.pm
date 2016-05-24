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

  if(AppBootCamp::Repository::User->isAlreadyRegisted($c->req->parameters->{screen_name})){

    p $str2;
  }else{
    return $c->render('signup.tx', {
        error_signup_screen_name  => "eroooooooooooor"
    });
  }
  return $c->redirect('/signup');
};

1;
