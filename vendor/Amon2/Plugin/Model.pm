package Amon2::Plugin::Model;
use strict;
use warnings;
use Module::Find;
use Try::Tiny;
use DDP;


our $VERSION = '0.01';

sub init {
  my ($class, $context_class, $config) = @_;
  my ($class_prefix) = split /::/, $context_class;
  $class_prefix .= '::Model';
  useall $class_prefix;

  no strict 'refs';
  *{"$context_class\::model"}          = \&_model;
*{"$context_class\::__models"}       = {};
*{"$context_class\::__class_prefix"} = sub { $class_prefix };
}

sub _model {
  my ($self, @names) = @_;
  die 'Model name is not specified.'  unless @names;

  for my $name ( @names ) {
    if ( ! defined $self->{__models}{$name} ) {
      try {
        my $model_class = sprintf '%s::%s', $self->__class_prefix, (ucfirst $name);
        $self->{__models}{$name} = $model_class->new(
          c => $self,
        );
      } catch {
        my ($msg) = @_;
        die $msg;
      };
    }
  }

  return wantarray ? @{$self->{__models}}{@names} : $self->{__models}{$names[0]};
}

1;
