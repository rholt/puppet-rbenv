require 'spec_helper'

describe 'plenv::plugin::perlbuild', :type => :define do
  let(:user)      { 'tester' }
  let(:title)     { user }

  it {
    should contain_plenv__plugin("plenv::plugin::perlbuild::#{user}").with(
      :plugin_name => 'perl-build',
      :source      => 'https://github.com/tokuhirom/Perl-Build.git',
      :user        => user
    )
  }
end