package AppBootCamp::Web::C::Page;
use strict;
use warnings;
use utf8;
use AppBootCamp::Repository::User;

use File::Copy;
use File::Spec;
use File::Basename;
use Time::Piece;
use DDP;

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
        error_signup_screen_name  => "this screen_name is already used."
      });
  }

  $user->regist_user($screen_name,$c->req->parameters->{name},$c->req->parameters->{password});
  return $c->redirect("/$screen_name");
};

sub get_timeline{
  my ($class,$c,$args) = @_;

  my $message = $c->model('Message');
  my @messages = $message->get_all_message();

   my $ab_dir = File::Spec->catdir($c->base_dir(),$dir);
   my @image = reverse map {$dir.'/'.basename($_)} glob ("$ab_dir/*");
   p @image;

  return $c->render('timeline.tx',{
#      action =>  $args->{screen_name},
      messages =>  \@messages
  });
};

sub post_message_new{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');

  my $upload = $c->req->uploads->{image};
  if($upload){
    my $ext = valid_type($upload->content_type);
    if($ext){
      my $src = $upload->tempname;
      my $dst = create_filename($ext);
      $dst = File::Spec->catfile($c->base_dir(),$dir,$upload->{filename});
      copy $src,$dst;
    }
  }
  my $path=$upload->{filename};
  if(defined($path)){$path = File::Spec->catfile($dir,$path);}
  $message->post_new_message(1,$c->req->parameters->{post_text},0,$path,0);
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

sub post_delete{
  my($class,$c,$args) = @_;
  my $message = $c->model('Message');

  p $c->req->parameters->{delete_id_name};
  $message->delete_message($c->req->parameters->{delete_id_name});
  return $c->redirect('/timeline');

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
        error_login_screen_name  => "this screen_name is already used.",
        error_login_password  => "this password is not correct."
      });
  };

  $c->session->set('screen_name',$screen_name);

  return $c->redirect("/$screen_name");
};

sub valid_type {
  my $type = shift;

  my %valid_types = ('image/gif' => 'gif','image/jpeg' => 'jpg','image/png' => 'png');

  return $valid_types{$type};
}

sub create_filename {
  my $ext = shift;

  my $date = localtime;
  my $rand_num = sprintf "%05s",int(rand 100000);

  return 'image-'.$date->datetime(date => '',time => '',T => '').'-'.$rand_num.'.'.$ext;
}

1;
