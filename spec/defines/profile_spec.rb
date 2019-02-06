require 'spec_helper'

describe 'authclientconfig::profile', type: :define do
  let(:title) { 'namevar' }
  let(:params) do
    {}
  end
	let(:required_params) do
		{
			source: 'puppet://my_module/example_profile'
		}
	end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end

		context 'default_params' do
			let(:params) { required_params }
			it do
				should contain_file(filename).with(
					ensure: 'present',
					path: '/etc/auth-client-config/profile.d/namevar-acc-profile'
				)
			end
		end
  end
end
