package AppBootCamp::Repository::Message;
use strict;
use warnings;

use File::Copy;
use File::Spec;
use File::Basename;
use Time::Piece;

my $dir = 'static/upload';

sub post_picture{
  my($class,$upload,$base_dir) = @_;
  if($upload){
    my $ext = valid_type($upload->content_type);
    if($ext){
      my $src = $upload->tempname;
      my $dst = create_filename($ext);
      $dst = File::Spec->catfile($base_dir,$dir,$upload->{filename});
      copy $src,$dst;
    }
  }
  my $path=$upload->{filename};
  if(defined($path)){$path = File::Spec->catfile($dir,$path);}
  return $path;
}

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
