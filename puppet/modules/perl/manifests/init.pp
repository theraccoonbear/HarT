class perl {

  include cpanm
  
  package { 'Data::Printer': ensure => present, provider => cpanm }
  package { 'JSON::XS': ensure => present, provider => cpanm }
  package { 'File::Slurp': ensure => present, provider => cpanm }
  package { 'Moose': ensure => present, provider => cpanm }
  package { 'WWW::Mechanize': ensure => present, provider => cpanm }
  package { 'URI::Encode': ensure => present, provider => cpanm }
  package { 'Time::DayOfWeek': ensure => present, provider => cpanm }
  package { 'DateTime::Format::Strptime': ensure => present, provider => cpanm }
  package { 'FindBin': ensure => present, provider => cpanm }
  package { 'File::Basename': ensure => present, provider => cpanm }
  package { 'LWP::Protocol::https': ensure => present, provider => cpanm }
}