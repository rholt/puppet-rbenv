require 'spec_helper'

describe 'plenv::compile', :type => :define do
  let(:user)         { 'tester' }
  let(:perl_version) { '5.10.1' }
  let(:title)        { "plenv::compile::#{user}::#{perl_version}" }
  let(:dot_plenv)    { "/home/#{user}/.plenv" }
  let(:carton)       { '1.0.12' }
  let(:params)       { {:user => user, :perl => perl_version, :global => true, :carton => carton} }

  it "installs perl of the chosen version" do
    should contain_exec("plenv::compile #{user} #{perl_version}").
      with_command("plenv install #{perl_version} && touch #{dot_plenv}/.rehash")
  end

  it "issues a rehash command" do
    should contain_exec("plenv::rehash #{user} #{perl_version}").
      with_command("plenv rehash && rm -f #{dot_plenv}/.rehash")
  end

  it "sets the global perl version for the specific user" do
    should contain_file("plenv::global #{user}").
      with_content("#{perl_version}\n").
      with_require("Exec[plenv::compile #{user} #{perl_version}]")
  end

  it "installs perl-build plugin from official repository" do
    should contain_plenv__plugin__perlbuild("plenv::perlbuild::#{user}")
  end

  it "installs carton" do
    should contain_plenv__cpanm("plenv::carton #{user} #{perl_version}").
      with_ensure(carton)
  end
end